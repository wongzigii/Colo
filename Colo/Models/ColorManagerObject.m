//
//  ColorManagerObject.m
//  Colo
//
//  Created by Wongzigii on 15/3/4.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import "ColorManagerObject.h"
#import "Parser.h"
@implementation ColorManagerObject
//Setter
- (void)setFirstColor:(UIColor *)firstColor
{
    [self setValue:firstColor forKey:@"firstColor"];
}

- (void)setSecondColor:(UIColor *)secondColor
{
    [self setValue:secondColor forKey:@"secondColor"];
}

- (void)setThirdColor:(UIColor *)thirdColor
{
    [self setValue:thirdColor forKey:@"thirdColor"];
}

- (void)setFourthColor:(UIColor *)fourthColor
{
    [self setValue:fourthColor forKey:@"fourthColor"];
}

- (void)setFifthColor:(UIColor *)fifthColor
{
    [self setValue:fifthColor forKey:@"fifthColor"];
}

//Getter
- (UIColor *)firstColor
{
    NSString *string = [super valueForKey:@"firstColor"];
    return [Parser translateStringToColor:string];
}

- (UIColor *)secondColor
{
    NSString *string = [self valueForKey:@"secondColor"];
    return [Parser translateStringToColor:string];
}

- (UIColor *)thirdColor
{
    NSString *string = [self valueForKey:@"thirdColor"];
    return [Parser translateStringToColor:string];
}

- (UIColor *)fourthColor
{
    NSString *string = [self valueForKey:@"fourthColor"];
    return [Parser translateStringToColor:string];
}

- (UIColor *)fifthColor
{
    NSString *string = [self valueForKey:@"fifthColor"];
    return [Parser translateStringToColor:string];
}

@end
