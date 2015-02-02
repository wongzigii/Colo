//
//  Parser.m
//  Colo
//
//  Created by Wongzigii on 12/10/14.
//  Copyright (c) 2014 Wongzigii. All rights reserved.

#import "TFHpple.h"
#import "Parser.h"

@implementation Parser

//Color Array
+ (NSMutableArray *)parseWithHTMLString:(NSString *)webContent
{
//    NSString *string = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSString *content = [[NSString  alloc] initWithContentsOfFile:string encoding:NSUTF8StringEncoding error:nil];
    
    //伪造数据
    NSData *data = [webContent dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *parser = [TFHpple hppleWithData:data isXML:NO];
    
    //Color Array
    NSString *XpathQueryColorHexString = @"//div[@class='content']/div/div";
    NSArray *ColorStringNodes = [parser searchWithXPathQuery:XpathQueryColorHexString];
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in ColorStringNodes) {

        //background: #D93D59
        
        NSString *str = [element.attributes objectForKey:@"style"];
        
        NSRange range = [str rangeOfString:@"background: "];
        if (range.location != NSNotFound) {
            str = [str substringWithRange:NSMakeRange(range.location + 12, 7)];
        }
        
        //translate into UIColor
        UIColor *color = [self translateStringToColor:str];
        [resultArray addObject:color];
    }
    
    //Title
    return resultArray;
}

//Title
+ (NSMutableArray *)parsewithTitle:(NSString *)webContent
{
//    NSString *string = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSString *content = [[NSString  alloc] initWithContentsOfFile:string encoding:NSUTF8StringEncoding error:nil];
    
    //伪造数据
    NSData *data = [webContent dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *parser = [TFHpple hppleWithData:data isXML:NO];
    
    NSString *XpathQueryColorTitle = @"//a[@class='ctooltip']";
    NSArray *colorTitleNodes = [parser searchWithXPathQuery:XpathQueryColorTitle];
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in colorTitleNodes) {
        
        NSString *string = [element content];
        [resultArray addObject:string];
    }
    return resultArray;
}

//Likes
+ (NSMutableArray *)parsewithLikes:(NSString *)webContent
{
//    NSString *string = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//    NSString *content = [[NSString  alloc] initWithContentsOfFile:string encoding:NSUTF8StringEncoding error:nil];
    
    //伪造数据
    NSData *data = [webContent dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *parser = [TFHpple hppleWithData:data isXML:NO];
    
    NSString *XpathQueryColorLikes = @"//li[@class='likes-count']";
    NSArray *colorLikesNodes = [parser searchWithXPathQuery:XpathQueryColorLikes];
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in colorLikesNodes) {
        
        NSString *string = [element content];
        [resultArray addObject:string];
    }
    return resultArray;
}

//grouped
+ (NSMutableArray *)groupedTheArray:(NSMutableArray *)array
{
    NSMutableArray *outer = [[NSMutableArray alloc] init];
    NSMutableArray *inner = [[NSMutableArray alloc] initWithCapacity:5];
    int i = 0;
    for (id object in array)
    {
        if (inner == nil) {
            inner = [[NSMutableArray alloc] init];
        }
        [inner addObject:object];
        i ++;
        if (i % 5 == 0) {
            ColorModel *model = [[ColorModel alloc] initWithArray:inner andTitle:nil andStars:nil andFavoutite:nil];
            [outer addObject:model];
            inner = nil;
            i = 0;
        }
    }
    return outer;
    ///(lldb) po [[[outer objectAtIndex:0] colorArray] objectAtIndex:0]
}

//translate string into color
+ (UIColor *)translateStringToColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red, green, blue;
    NSRange range = NSMakeRange(1, 2);
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location += 2;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location += 2;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color = [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:1];
    return color;
}

@end
