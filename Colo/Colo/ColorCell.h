//
//  ColorCell.h
//  Colo
//
//  Created by Wongzigii on 1/4/15.
//  Copyright (c) 2015 Wongzigii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorCell : UITableViewCell

@property (strong, nonatomic)   UIView *firstColor;
@property (strong, nonatomic)   UIView *secondColor;
@property (strong, nonatomic)   UIView *thirdColor;
@property (strong, nonatomic)   UIView *fourthColor;
@property (strong, nonatomic)   UIView *fifthColor;
@property (strong, nonatomic)   UIView *background;
@property (strong, nonatomic)   UILabel *title;
@property (strong, nonatomic)   UILabel *favourites;
@property (strong, nonatomic)   UIView *top;
@property (strong, nonatomic)   UIView *bottom;
@property (strong, nonatomic)   UIImageView *stars;

@property (copy, nonatomic)     NSString *first;
@property (copy, nonatomic)     NSString *second;
@property (copy, nonatomic)     NSString *third;
@property (copy, nonatomic)     NSString *fourth;
@property (copy, nonatomic)     NSString *fifth;

@end
