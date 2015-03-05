//
//  ColorManagerObject.h
//  Colo
//
//  Created by Wongzigii on 15/3/4.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface ColorManagerObject : NSManagedObject

@property (nonatomic) UIColor *firstColor;
@property (nonatomic) UIColor *secondColor;
@property (nonatomic) UIColor *thirdColor;
@property (nonatomic) UIColor *fourthColor;
@property (nonatomic) UIColor *fifthColor;

@end
