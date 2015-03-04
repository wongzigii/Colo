//
//  ColorModel.h
//  Colo
//
//  Created by Wongzigii on 12/10/14.
//  Copyright (c) 2014 Wongzigii. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *star;
@property (nonatomic, copy) NSString *favourite;
@property (nonatomic, copy) NSArray  *colorArray;

- (id)initWithArray:(NSArray *)array andTitle:(NSString *)title andStar:(NSString *)star andFavoutite:(NSString *)favourite;
@end
