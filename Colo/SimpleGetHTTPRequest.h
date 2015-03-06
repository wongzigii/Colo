//
//  SimpleGetHTTPRequest.h
//  Colo
//
//  Created by Wongzigii on 15/3/6.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^completionHandler_t) (id result);


@interface SimpleGetHTTPRequest : NSObject


/**
 Initializes the receiver
 
 Parameter `url` is the url for the resource which will be loaded. The url’s
 scheme must be `http` or `https`.
 */
- (id)initWithURL:(NSURL*)url;


/**
 Start the asynchronous HTTP request.
 This can be executed only once, that is if the receiver has already been
 started, it will have no effect.
 */
- (void) start;

/**
 Cancels a running operation at the next cancelation point and returns
 immediately.
 
 `cancel` may be send to the receiver from any thread and multiple times.
 The receiver's completion block will be called once the receiver will
 terminate with an error code indicating the cancellation.
 
 If the receiver is already cancelled or finished the message has no effect.
 */
- (void) cancel;


@property (nonatomic, readonly) BOOL isCancelled;
@property (nonatomic, readonly) BOOL isExecuting;
@property (nonatomic, readonly) BOOL isFinished;

/**
 Set or retrieves the completion handler.
 
 The completion handler will be invoked when the connection terminates. If the
 request was sucessful, the parameter `result` of the block will contain the
 response body of the GET request, otherwise it will contain a NSError object.
 
 The execution context is unspecified.
 
 Note: the completion handler is the only means to retrieve the final result of
 the HTTP request.
 */
@property (nonatomic, copy) completionHandler_t completionHandler;



@end

