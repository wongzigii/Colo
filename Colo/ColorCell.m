//
//  ColorCell.m
//  Colo
//
//  Created by Wongzigii on 1/4/15.
//  Copyright (c) 2015 Wongzigii. All rights reserved.
//


#import "ColorCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ColorCell()

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation ColorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.background  = [UIView new];
        self.firstColor  = [UIView new];
        self.secondColor = [UIView new];
        self.thirdColor  = [UIView new];
        self.fourthColor = [UIView new];
        self.fifthColor  = [UIView new];
        self.title       = [UILabel new];
        self.stars       = [UIImageView new];
        self.favourites  = [UILabel new];
        self.top         = [UIView new];
        self.bottom      = [UIView new];
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        self.background.translatesAutoresizingMaskIntoConstraints  = NO;
        self.firstColor.translatesAutoresizingMaskIntoConstraints  = NO;
        self.secondColor.translatesAutoresizingMaskIntoConstraints = NO;
        self.thirdColor.translatesAutoresizingMaskIntoConstraints  = NO;
        self.fourthColor.translatesAutoresizingMaskIntoConstraints = NO;
        self.fifthColor.translatesAutoresizingMaskIntoConstraints  = NO;
        self.title.     translatesAutoresizingMaskIntoConstraints  = NO;
        self.stars.     translatesAutoresizingMaskIntoConstraints  = NO;
        self.favourites.translatesAutoresizingMaskIntoConstraints  = NO;
        self.top.       translatesAutoresizingMaskIntoConstraints  = NO;
        self.bottom.    translatesAutoresizingMaskIntoConstraints  = NO;
        
        [self.contentView addSubview:self.background];
        [self.background addSubview:self.top];
        [self.background addSubview:self.bottom];
        [self.top        addSubview:self.firstColor];
        [self.top        addSubview:self.secondColor];
        [self.top        addSubview:self.thirdColor];
        [self.top        addSubview:self.fourthColor];
        [self.top        addSubview:self.fifthColor];
        [self.bottom     addSubview:self.title];
        [self.bottom     addSubview:self.stars];
        [self.bottom     addSubview:self.favourites];
        
        self.background.layer.cornerRadius = 10;
        [self.background setClipsToBounds:YES];
        
        self.favourites.layer.cornerRadius = 3;
        self.favourites.layer.masksToBounds = YES;
        [self.favourites setFont:[UIFont boldSystemFontOfSize:13.0f]];
        self.favourites.textAlignment= NSTextAlignmentCenter;
        
        self.title.textColor = [UIColor whiteColor];
        [self.title setFont:[UIFont boldSystemFontOfSize:15.0f]];
        self.stars.image = [UIImage imageNamed:@"star-8x"];
        
        self.bottom.backgroundColor     = [UIColor blackColor];
        self.title.backgroundColor      = [UIColor clearColor];
        self.favourites.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    if (!self.didSetupConstraints) {
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_firstColor,_secondColor,_thirdColor,_fourthColor,_fifthColor,_background,_top,_bottom,_title,_stars,_favourites);
        
        NSString *format;
        NSArray *constraintsArray;
        NSDictionary *metrics = @{@"topHeight":@100.0, @"bottomHeight":@50};
        
        format = @"V:|[_background]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [self.contentView addConstraints:constraintsArray];
        
        format = @"H:|[_background]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [self.contentView addConstraints:constraintsArray];
        
        format = @"V:|[_top(topHeight)][_bottom(bottomHeight)]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:metrics views:viewsDictionary];
        [_background addConstraints:constraintsArray];

        format = @"H:|[_bottom]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_background addConstraints:constraintsArray];
        
        format = @"H:|[_top]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_background addConstraints:constraintsArray];
        

//
        //Top
        format = @"H:|[_firstColor][_secondColor(==_firstColor)][_thirdColor(==_firstColor)][_fourthColor(==_firstColor)][_fifthColor(==_firstColor)]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_top addConstraints:constraintsArray];
        
        format = @"V:|[_firstColor]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_top addConstraints:constraintsArray];

        format = @"V:|[_secondColor]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_top addConstraints:constraintsArray];

        format = @"V:|[_thirdColor]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_top addConstraints:constraintsArray];

        format = @"V:|[_fourthColor]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_top addConstraints:constraintsArray];

        format = @"V:|[_fifthColor]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_top addConstraints:constraintsArray];
//
        //Bottom
        format = @"V:|-[_title]-|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_bottom addConstraints:constraintsArray];
        
        [_bottom addConstraint:[NSLayoutConstraint constraintWithItem:_stars
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_bottom
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0f
                                                             constant:0.0f]];
        
        format = @"V:[_stars(17)]";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];
        [_bottom addConstraints:constraintsArray];
    
        
        format = @"V:|-12-[_favourites]-12-|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_bottom addConstraints:constraintsArray];
        
        format = @"H:|-[_title(240)]-[_stars(17)]-[_favourites(35)]-|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_bottom addConstraints:constraintsArray];
//
        self.didSetupConstraints = YES;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:NO];
}

@end
