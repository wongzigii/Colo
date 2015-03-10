//
//  ColorModel.m
//  Colo
//
//  Created by Wongzigii on 12/10/14.
//  Copyright (c) 2014 Wongzigii. All rights reserved.
//

#import "ColorModel.h"

@implementation ColorModel
//designated initializer
- (id)initWithArray:(NSArray *)array andTitle:(NSString *)title andStar:(NSString *)star andFavoutite:(NSString *)favourite
{
    if (!self) {
        self = [super init];
    }
    self.colorArray = array;
    self.title = title;
    self.star = star;
    self.favourite = favourite;
    return self;
}

//Throwing an exception if use -init
- (instancetype)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"Must use initWithArray:andTitle:andStar:andFavourite: instead"
                                 userInfo:nil];
}

@end
