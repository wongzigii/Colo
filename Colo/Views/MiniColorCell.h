//
//  MiniColorCell.h
//  Colo
//
//  Created by Wongzigii on 15/3/7.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorModel.h"
@interface MiniColorCell : UITableViewCell
@property (strong, nonatomic)   UIView *firstColor;
@property (strong, nonatomic)   UIView *secondColor;
@property (strong, nonatomic)   UIView *thirdColor;
@property (strong, nonatomic)   UIView *fourthColor;
@property (strong, nonatomic)   UIView *fifthColor;
@property (strong, nonatomic)   UIView *background;

- (void)configureForColor:(ColorModel *)model;

@end
