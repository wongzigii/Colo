//
//  ColorCell.h
//  Colo
//
//  Created by Wongzigii on 1/4/15.
//  Copyright (c) 2015 Wongzigii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *firstColor;
@property (strong, nonatomic) IBOutlet UIView *secondColor;
@property (strong, nonatomic) IBOutlet UIView *thirdColor;
@property (strong, nonatomic) IBOutlet UIView *fourthColor;
@property (strong, nonatomic) IBOutlet UIView *fifthColor;
@property (strong, nonatomic) IBOutlet UIView *background;
@property (strong, nonatomic) IBOutlet UILabel *title;

@property (strong, nonatomic) IBOutlet UILabel *favourites;
@property (strong, nonatomic) IBOutlet UIView *top;
@property (strong, nonatomic) IBOutlet UIView *bottom;
@property (strong, nonatomic) IBOutlet UIImageView *stars;

@property (nonatomic, strong) NSString *first;
@property (nonatomic, strong) NSString *second;
@property (nonatomic, strong) NSString *third;
@property (nonatomic, strong) NSString *fourth;
@property (nonatomic, strong) NSString *fifth;

@end
