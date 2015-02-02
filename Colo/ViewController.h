//
//  ViewController.h
//  Colo
//
//  Created by Wongzigii on 12/6/14.
//  Copyright (c) 2014 Wongzigii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>


@interface ViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong)  UIWebView *webView;
@property (nonatomic, strong)  NSString *HTML;
@property (nonatomic, strong)  UIButton *parseButton;
@property (nonatomic, strong)  UIButton *reloadButton;
@end

