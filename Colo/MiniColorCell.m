//
//  MiniColorCell.m
//  Colo
//
//  Created by Wongzigii on 15/3/7.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import "MiniColorCell.h"
#import "ColorManagerObject.h"
#import "ColorModel.h"
#import "Parser.h"

@interface MiniColorCell ()
@property (nonatomic, assign) BOOL didSetupConstraints;
@end

@implementation MiniColorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.background  = [UIView new];
        self.firstColor  = [UIView new];
        self.secondColor = [UIView new];
        self.thirdColor  = [UIView new];
        self.fourthColor = [UIView new];
        self.fifthColor  = [UIView new];
        
        self.background.translatesAutoresizingMaskIntoConstraints  = NO;
        self.firstColor.translatesAutoresizingMaskIntoConstraints  = NO;
        self.secondColor.translatesAutoresizingMaskIntoConstraints = NO;
        self.thirdColor.translatesAutoresizingMaskIntoConstraints  = NO;
        self.fourthColor.translatesAutoresizingMaskIntoConstraints = NO;
        self.fifthColor.translatesAutoresizingMaskIntoConstraints  = NO;
        
        self.background.layer.cornerRadius = 5.0;
        self.background.clipsToBounds = YES;
        self.contentView.backgroundColor = [UIColor colorWithRed:39.0 / 255.0 green:39.0 / 255.0 blue:39.0 / 255.0 alpha:1.0];
        [self.contentView addSubview:self.background];
        [self.background        addSubview:self.firstColor];
        [self.background        addSubview:self.secondColor];
        [self.background        addSubview:self.thirdColor];
        [self.background        addSubview:self.fourthColor];
        [self.background        addSubview:self.fifthColor];
        
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    if (!self.didSetupConstraints) {
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_firstColor,_secondColor,_thirdColor,_fourthColor,_fifthColor,_background);
        
        NSString *format;
        NSArray *constraintsArray;
        //NSDictionary *metrics = @{@"topHeight":@100.0, @"bottomHeight":@50};
        
        format = @"V:[_background(25)]";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];
        [self.contentView addConstraints:constraintsArray];
        
        format = @"H:[_background(200)]";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];
        [self.contentView addConstraints:constraintsArray];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.background
                                                            attribute:NSLayoutAttributeCenterY
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.contentView
                                                            attribute:NSLayoutAttributeCenterY
                                                           multiplier:1.0f
                                                             constant:0.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.background
                                                                    attribute:NSLayoutAttributeCenterX
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.contentView
                                                                    attribute:NSLayoutAttributeCenterX
                                                                   multiplier:1.0f
                                                                     constant:0.0f]];
                                
        //Top
        format = @"H:|[_firstColor][_secondColor(==_firstColor)][_thirdColor(==_firstColor)][_fourthColor(==_firstColor)][_fifthColor(==_firstColor)]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_background addConstraints:constraintsArray];
        
        format = @"V:|[_firstColor]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_background addConstraints:constraintsArray];
        
        format = @"V:|[_secondColor]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_background addConstraints:constraintsArray];
        
        format = @"V:|[_thirdColor]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_background addConstraints:constraintsArray];
        
        format = @"V:|[_fourthColor]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_background addConstraints:constraintsArray];
        
        format = @"V:|[_fifthColor]|";
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary];
        [_background addConstraints:constraintsArray];
        
        self.didSetupConstraints = YES;
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:NO];
}

//For Now
- (void)configureForColor:(ColorModel *)model
{
    //    self.title.text = model.title;
    //self.favourites.text = model.stars;
    
    self.firstColor.backgroundColor  = [UIColor translateWithHexString:[model.colorArray objectAtIndex:0]];
    self.secondColor.backgroundColor = [UIColor translateWithHexString:[model.colorArray objectAtIndex:1]];
    self.thirdColor.backgroundColor  = [UIColor translateWithHexString:[model.colorArray objectAtIndex:2]];
    self.fourthColor.backgroundColor = [UIColor translateWithHexString:[model.colorArray objectAtIndex:3]];
    self.fifthColor.backgroundColor  = [UIColor translateWithHexString:[model.colorArray objectAtIndex:4]];
}

//For CoreData
- (void)configureForColorObject:(NSArray *)array
{
    self.secondColor.backgroundColor = [array objectAtIndex:1];
    self.thirdColor.backgroundColor  = [array objectAtIndex:2];
    self.fourthColor.backgroundColor = [array objectAtIndex:3];
    self.fifthColor.backgroundColor  = [array objectAtIndex:4];
}

@end
