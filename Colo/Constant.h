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
