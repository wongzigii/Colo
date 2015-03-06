//
//  SimpleGetHTTPRequest.m
//  Colo
//
//  Created by Wongzigii on 15/3/6.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import "SimpleGetHTTPRequest.h"


@interface SimpleGetHTTPRequest () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, readwrite) BOOL isCancelled;
@property (nonatomic, readwrite) BOOL isExecuting;
@property (nonatomic, readwrite) BOOL isFinished;

@property (nonatomic) NSURL*    url;
@property (nonatomic) NSMutableURLRequest* request;
@property (nonatomic) NSURLConnection* connection;
@property (nonatomic) NSMutableData* responseData;
@property (nonatomic) NSHTTPURLResponse* lastResponse;
@property (nonatomic) NSError* error;

@end


@implementation SimpleGetHTTPRequest

@synthesize isCancelled = _isCancelled;
@synthesize isExecuting = _isExecuting;
@synthesize isFinished = _isFinished;

@synthesize url = _url;
@synthesize request = _request;
@synthesize connection = _connection;
@synthesize responseData = _responseData;
@synthesize lastResponse = _lastResponse;
@synthesize error = _error;




- (id)initWithURL:(NSURL*)url {
    NSParameterAssert(url);
    // TODO: url's scheme shall be http or https
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void) dealloc {
}

- (void) terminate {
    NSAssert([NSThread currentThread] == [NSThread mainThread], @"not executing on main thread");
    
    if (_isFinished)
        return;
    
    completionHandler_t onCompletion = self.completionHandler;
    id result = self.error ? self.error : self.responseData;
    if (onCompletion) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            onCompletion(result);
        });
    };
    
    self.completionHandler = nil;
    self.connection = nil;
    self.isExecuting = NO;
    self.isFinished = YES;
}



- (void) start {
    // ensure the start method is executed on the main thread:
    if ([NSThread currentThread] != [NSThread mainThread]) {
        [self performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:NO];
        return;
    }
    // bail out if the receiver has already been started or cancelled:
    if (_isCancelled || _isExecuting || _isFinished) {
        return;
    }
    self.isExecuting = YES;
    self.request = [[NSMutableURLRequest alloc] initWithURL:_url];
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
    if (!self.connection) {
        self.error = [NSError errorWithDomain:@"SimpleGetHTTPRequest"
                                         code:-2
                                     userInfo:@{NSLocalizedDescriptionKey:@"Couldn't create NSURLConnection"}];
        [self terminate];
        return;
    }
    [self.connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [self.connection start];
}


- (void) cancel {
    NSError* reason = [NSError errorWithDomain:@"SimpleGetHTTPRequest"
                                          code:-1
                                      userInfo:@{NSLocalizedDescriptionKey:@"cancelled"}];
    [self cancelWithReason:reason sender:nil];
}

- (void) cancelWithReason:(id)reason sender:(id)sender {
    // Accessing ivars must be synchronized! Access also occures in the delegate
    // methods, which run on the main thread. Thus we simply use the main thread
    // to synchronize access:
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_isCancelled || _isFinished) {
            return;
        }
        self.error = reason;
        [self.connection cancel];
        [self terminate];
    });
}


#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.error = error;
    [self terminate];
}


#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    assert([response isKindOfClass:[NSHTTPURLResponse class]]);
    
    // A real implementation should  check the HTTP  status code here and
    // possibly other response properties like the content-type, and then
    // branch  to  corresponding actions.  Here, our "action" --  call it
    // "response handler" -- will just accumulate the incomming data into
    // the NSMutableData object `responseData`.
    //
    // A GET request really only succeeds when the status code is 200 (OK),
    // except redirection responses  and authentication  challenges, which
    // are handled elsewhere.
    //
    // Any other response is likely an error. When we didn't get a 200 (OK)
    // we shouldn't terminated the  connection, though. Rather we retrieve
    // the response data - if any - since this may  contain valuable error
    // information - possibly other MIME type than requested.
    
    // Note: usually, status codes in the range 200 to 299 are considered a
    // succesful HTTP response.  However, depending on the  client needs, a
    // successful request may only allow status code 200 (OK).
    //
    // Redirect repsonses (3xx)  and authentication challenges  are handled
    // by the underlaying  NSURLConnection and possibly invoke other corres-
    // ponding delegate methods and do not show up here.
    
    // For a GET request, we are fine just doing this:
    self.responseData = [[NSMutableData alloc] initWithCapacity:1024];
    self.lastResponse = (NSHTTPURLResponse*)response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Here, we use the most simplistic approach to handle the received data:
    // we accumulating the data chunks into a NSMutableData object.
    // This approach becomes problematic when the size of the data will become
    // large. Alterntative approaches are for example:
    //  - save the data into a temporary file
    //  - synchronously process and reduce the data chunk immediately
    //  - asynchronously disaptch data processing onto another queue
    
    [self.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    // If we consider the request a failure - or at least if it was "not successful" -
    // we construct a descriptive NSError object and assign it our `error` property.
    // Note that the connection itself may have succeeded perfectly, but it just returned
    // a status code which would not match our requirements.
    // Purposefully, the NSError object will contain the response data in the `userInfo`
    // dictionary.
    // Notice, that in case of an error, the server may send a respond in an unexpected
    // content type and encoding. Thus, we may need to check the Content-Type and possibly
    // do nneed to convert/decode the response data into a format that's readable/processable
    // by the  client.
    //
    // So, in order to test if the request succeded, we MUST confirm that we got what we
    // expect, e.g. HTTP status code, Content-Type, encoding, etc.
    // The response data (if any) will be kept separately in property `responseData`.
    
    if (self.lastResponse.statusCode != 200) {
        NSString* desc = [[NSString alloc] initWithFormat:@"connection failed with response %ld (%@)",
                          (long)self.lastResponse.statusCode, [NSHTTPURLResponse localizedStringForStatusCode:self.lastResponse.statusCode]];
        self.error = [[NSError alloc] initWithDomain:@"SimpleGetHTTPRequest"
                                                code:-4
                                            userInfo:@{
                                                       NSLocalizedDescriptionKey: desc,
                                                       NSLocalizedFailureReasonErrorKey:[self.responseData description]
                                                       }];
    }
    [self terminate];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    // This will effectively prevent NSURLConnection to cache the response.
    // That's not always desired, though.
    return nil;
}



@end
