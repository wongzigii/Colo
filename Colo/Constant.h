//
//  Constant.h
//  Colo
//
//  Created by Wongzigii on 15/3/5.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//  macros

#import <Foundation/Foundation.h>


#define DEBUG_MODE

#ifdef DEBUG_MODE
#define DebugLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DebugLog( s, ... )
#endif

#define kWZServer_China www.wongzigii.com/Colo/China.html
#define kWZServer_English www.wongzigii.com/Colo/English.html
#define kWZServer_Chinaa www.wongzigii.com/Colo/China.html

#define IS_IOS8 [[UIDevice currentDevice].systemVersion hasPrefix:@"8"]

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height = 568) ? NO : YES)

#define kDeviceWidth  self.view.frame.size.width
#define kDeviceHeight self.view.frame.size.height
#define CocoaJSHandler   @"mpAjaxHandler"