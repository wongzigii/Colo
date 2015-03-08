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

#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define CocoaJSHandler   @"mpAjaxHandler"

#define DefaultCountryChoose @"English.html"
#define COLO_Danmark       @"Danmark.html"
#define COLO_German        @"German.html"
#define COLO_English       @"English.html"
#define COLO_Spain         @"Spain.html"
#define COLO_France        @"France.html"
#define COLO_Italy         @"Italy.html"
#define COLO_Holland       @"Holland.html"
#define COLO_Poland        @"Poland.html"
#define COLO_Portugal      @"Portugal.html"
#define COLO_Crezh         @"Crezh.html"
#define COLO_Sweden        @"Sweden.html"
#define COLO_Finland       @"Finland.html"
#define COLO_Turkey        @"Turkey.html"
#define COLO_Russia        @"Russia.html"
#define COLO_China         @"China.html"
#define COLO_Japan         @"Japan.html"
#define COLO_Korea         @"Korea.html"

#define WZRedBeginColor    [UIColor colorWithRed:255.0 / 255.0 green:107.0 / 255.0 blue:51.0 / 255.0 alpha:1.0]
#define WZGreenBeginColor  [UIColor colorWithRed:46.0 / 255.0f green:190.0 / 255.0 blue:140.0 / 255.0 alpha:1.0]
#define WZBlueBeginColor   [UIColor colorWithRed:132.0 / 255.0 green:179.0 / 255.0 blue:230.0 / 255.0 alpha:1.0]

#define WZRedEndColor      [UIColor colorWithRed:255.0 / 255.0 green:70.0 / 255.0 blue:0.0 / 255.0 alpha:1.0]
#define WZGreenEndColor    [UIColor colorWithRed:18.0 / 255.0f green:181.0 / 255.0 blue:53.0 / 255.0 alpha:1.0]
#define WZBlueEndColor     [UIColor colorWithRed:37.0 / 255.0 green:146.0 / 255.0 blue:224.0 / 255.0 alpha:1.0]

#define Color1             [UIColor colorWithRed:255.0 / 255.0 green:107.0 / 255.0 blue:51.0 / 255.0 alpha:1.0]
#define Color2             [UIColor colorWithRed:46.0 / 255.0f green:190.0 / 255.0 blue:140.0 / 255.0 alpha:1.0]
#define Color3             [UIColor colorWithRed:0.0 / 255.0 green:160.0 / 255.0 blue:190.0 / 255.0 alpha:1.0]
#define Color4             [UIColor colorWithRed:92.0 / 255.0 green:194.0 / 255.0 blue:2.0 / 255.0 alpha:1.0]
#define Color5             [UIColor colorWithRed:5.0 / 255.0 green:234.0 / 255.0 blue:147.0 / 255.0 alpha:1.0]
#define Color6             [UIColor colorWithRed:6.0 / 255.0 green:136.0 / 255.0 blue:234.0 / 255.0 alpha:1.0]
#define Color7             [UIColor colorWithRed:234.0 / 255.0 green:126.0 / 255.0 blue:165.0 / 255.0 alpha:1.0]
#define Color8             [UIColor colorWithRed:132.0 / 255.0 green:179.0 / 255.0 blue:230.0 / 255.0 alpha:1.0]
#define Color9             [UIColor colorWithRed:37.0 / 255.0 green:146.0 / 255.0 blue:224.0 / 255.0 alpha:1.0]
#define Color10            [UIColor colorWithRed:37.0 / 255.0 green:146.0 / 255.0 blue:224.0 / 255.0 alpha:1.0]
#define Color11            [UIColor colorWithRed:37.0 / 255.0 green:146.0 / 255.0 blue:224.0 / 255.0 alpha:1.0]
#define Color12            [UIColor colorWithRed:37.0 / 255.0 green:146.0 / 255.0 blue:224.0 / 255.0 alpha:1.0]
#define Color13            [UIColor colorWithRed:37.0 / 255.0 green:146.0 / 255.0 blue:224.0 / 255.0 alpha:1.0]
#define Color14            [UIColor colorWithRed:37.0 / 255.0 green:146.0 / 255.0 blue:224.0 / 255.0 alpha:1.0]
#define Color15            [UIColor colorWithRed:37.0 / 255.0 green:146.0 / 255.0 blue:224.0 / 255.0 alpha:1.0]
#define Color16            [UIColor colorWithRed:37.0 / 255.0 green:146.0 / 255.0 blue:224.0 / 255.0 alpha:1.0]
#define Color17            [UIColor colorWithRed:37.0 / 255.0 green:146.0 / 255.0 blue:224.0 / 255.0 alpha:1.0]
