//
//  ViewController.m
//  Colo
//
//  Created by Wongzigii on 12/6/14.
//  Copyright (c) 2014 Wongzigii. All rights reserved.
//  https://color.adobe.com/zh/explore/most-popular/?time=week

#import "ViewController.h"
#import "Parser.h"

#define kDeviceWidth  self.view.frame.size.width
#define kDeviceHeight self.view.frame.size.height
#define CocoaJSHandler       @"mpAjaxHandler"
static NSString *JSHandler;

@interface ViewController ()
@end

@implementation ViewController
      
#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, kDeviceWidth, kDeviceHeight - 69)];
    self.webView.backgroundColor = [UIColor yellowColor];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    self.parseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, kDeviceHeight - 69, 20, 20)];
    [self.parseButton addTarget:self action:@selector(startParse) forControlEvents:UIControlEventTouchUpInside];
    self.parseButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.parseButton];
    
    self.reloadButton = [[UIButton alloc] initWithFrame:CGRectMake(20, kDeviceHeight - 69, 20, 20)];
    [self.reloadButton addTarget:self action:@selector(reloadTheWebpage) forControlEvents:UIControlEventTouchUpInside];
    self.reloadButton.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.reloadButton];
    
    NSURL *url = [[NSURL alloc] initWithString:@"https://color.adobe.com/zh/explore/most-popular/?time=all"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    JSHandler = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"parser"
                                                                          withExtension:@"js"]
                                         encoding:NSUTF8StringEncoding
                                            error:nil];
    [self.webView stringByEvaluatingJavaScriptFromString:JSHandler];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([[[[request URL] scheme] lowercaseString] isEqual:@"mpajaxhandler"]) {
        
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"OK"
                                                     message:@"已经获得"
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:nil, nil];
        [al show];
        NSString *htmlString = [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
        self.HTML = htmlString;
        //[self saveDataToUserDefault:htmlString];
        //NSLog(@"self.html : %@",self.HTML);
        [Parser parseWithHTMLString:self.HTML];
        return NO;
    }
    return YES;
}

#pragma mark - Private Method
//开始解析
//- (void)startParse
//{
//    //[Parser groupedTheArray:[Parser createData]];
//    [Parser groupedTheArray:[Parser parseWithHTMLString]];
//}

//重载
- (void)reloadTheWebpage
{
    [self.webView reload];
}

//- (void)saveDataToUserDefault:(NSString *)string
//{
//    NSError *error;
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSLocalDomainMask, YES);
//    NSString *filepath = [NSString stringWithFormat:@"%@/%@",[path objectAtIndex:0], @"index.html"];
//    [string writeToFile:filepath
//             atomically:YES
//               encoding:NSUTF8StringEncoding
//                  error:&error];
//}


@end
