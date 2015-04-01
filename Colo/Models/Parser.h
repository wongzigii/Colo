//
//  Parser.h
//  Colo
//
//  Created by Wongzigii on 12/10/14.
//  Copyright (c) 2014 Wongzigii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ColorModel.h"

@interface Parser : NSObject

typedef void (^completionHandler_t) (id result);

+ (UIColor *)translateStringToColor:(NSString *)str;

- (instancetype)initWithPath:(NSString *)path;

- (void)startParse;

- (NSMutableArray *)returnArray;

@property (nonatomic, copy) completionHandler_t completionHandler;

@property (nonatomic, readonly) BOOL isExecuting;
@property (nonatomic, readonly) BOOL isFinished;

@end

@interface UIColor (Hex)

+ (UIColor *)translateWithHexString:(NSString *)string;

@end
