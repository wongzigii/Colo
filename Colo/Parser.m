//
//  Parser.m
//  Colo
//
//  Created by Wongzigii on 12/10/14.
//  Copyright (c) 2014 Wongzigii. All rights reserved.

#import "TFHpple.h"
#import "Parser.h"

@interface Parser()
@property (atomic) NSString *filePath;
@property (atomic) NSURL *url;
@property (nonatomic, readwrite) BOOL isExecuting;
@property (nonatomic, readwrite) BOOL isFinished;
@property (nonatomic, weak)      NSMutableArray *objectsArray;

@end

@implementation Parser

- (instancetype)initWithPath:(NSString *)path
{
    self = [super init];
    if (self) {
        if (path) {
            self.filePath = path;
            self.url = [NSURL fileURLWithPath:self.filePath];
        }
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                       reason:@"Must use initWithPath: instead."
                                     userInfo:nil];
    }
    return self;
}

- (void)startParse
{
    self.objectsArray = [self groupedTheArray:[self parseWithHTMLString] andTitleArray:nil andStarsArray:nil];
    //NSLog(@"%@",self.objectsArray);
}

- (NSMutableArray *)returnArray
{
    return self.objectsArray;
}

//Color Array
- (NSMutableArray *)parseWithHTMLString
{
    NSError *error;
    NSString *fetchData = [NSString stringWithContentsOfURL:self.url usedEncoding:nil error:&error];
    if (error) {
        NSLog(@"Can not load datas from local file while parsing color arrays");
    }
    
    NSData *data = [fetchData dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *parser = [TFHpple hppleWithData:data isXML:NO];
    
    //Color Array
    NSString *XpathQueryColorHexString = @"//div[@class='content']/div/div";
    NSArray *ColorStringNodes = [parser searchWithXPathQuery:XpathQueryColorHexString];
    
    //NSMutableArray *colorArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *strArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (TFHppleElement *element in ColorStringNodes) {

        //background: #D93D59
        
        NSString *str = [element.attributes objectForKey:@"style"];
        
        NSRange range = [str rangeOfString:@"background: "];
        if (range.location != NSNotFound) {
            str = [str substringWithRange:NSMakeRange(range.location + 12, 7)];
        }
        
        //translate into UIColor
        [strArray addObject:str];
        //UIColor *color = [self translateStringToColor:str];
        //[colorArray addObject:color];
    }
    
    //Title
    return strArray;
}

- (NSMutableArray *)parsewithTitle
{
    return nil;
}

- (NSMutableArray *)parsewithLikes
{
    return nil;
}

//Title
//- (NSMutableArray *)parsewithTitle
//{
//    NSError *error;
//    NSString *fetchData = [NSString stringWithContentsOfURL:self.url usedEncoding:nil error:&error];
//    if (error) {
//        NSLog(@"Can not load datas from local file while parsing like numbers while parsing titles");
//    }
//
//    NSData *data = [fetchData dataUsingEncoding:NSUTF8StringEncoding];
//    TFHpple *parser = [TFHpple hppleWithData:data isXML:NO];
//    
//    NSString *XpathQueryColorTitle = @"//a[@class='ctooltip']";
//    NSArray *colorTitleNodes = [parser searchWithXPathQuery:XpathQueryColorTitle];
//    
//    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:0];
//    for (TFHppleElement *element in colorTitleNodes) {
//        
//        NSString *string = [element content];
//        [resultArray addObject:string];
//    }
//    return resultArray;
//}

//Likes
//- (NSMutableArray *)parsewithLikes
//{
//    NSError *error;
//    NSString *fetchData = [NSString stringWithContentsOfURL:self.url usedEncoding:nil error:&error];
//    if (error) {
//        NSLog(@"Can not load datas from local file while parsing like numbers");
//    }
//
//    NSData *data = [fetchData dataUsingEncoding:NSUTF8StringEncoding];
//    TFHpple *parser = [TFHpple hppleWithData:data isXML:NO];
//    
//    NSString *XpathQueryColorLikes = @"//li[@class='likes-count']";
//    NSArray *colorLikesNodes = [parser searchWithXPathQuery:XpathQueryColorLikes];
//    
//    NSMutableArray *resultArray = [[NSMutableArray alloc] initWithCapacity:0];
//    for (TFHppleElement *element in colorLikesNodes) {
//        
//        NSString *string = [element content];
//        [resultArray addObject:string];
//    }
//    return resultArray;
//}

//grouped
- (NSMutableArray *)groupedTheArray:(NSMutableArray *)array andTitleArray:(NSMutableArray *)title andStarsArray:(NSMutableArray *)star
{
    NSMutableArray *outer = [[NSMutableArray alloc] init];
    NSMutableArray *inner = [[NSMutableArray alloc] initWithCapacity:5];
    int index = 0, count = 0;
    for (id object in array)
    {
        if (!inner) {
            inner = [[NSMutableArray alloc] init];
        }
        [inner addObject:object];
        index ++;
        if (index % 5 == 0) {
            NSString *titleStr = [title objectAtIndex:count];
            NSString *starNum = [star objectAtIndex:count];
            ColorModel *model = [[ColorModel alloc] initWithArray:inner andTitle:titleStr andStar:starNum andFavoutite:nil];
            [outer addObject:model];
            inner = nil;
            index = 0;
            count ++;
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

@implementation UIColor (Hex)

+ (UIColor *)translateWithHexString:(NSString *)str
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
