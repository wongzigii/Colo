//
//  Parser.h
//  Colo
//
//  Created by Wongzigii on 12/10/14.
//  Copyright (c) 2014 Wongzigii. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ColorModel.h"

@interface Parser : NSObject

+ (NSMutableArray *)parseWithHTMLString:(NSString *)webContent;

+ (NSMutableArray *)parsewithTitle:(NSString *)webContent;

+ (NSMutableArray *)parsewithLikes:(NSString *)webContent;

+ (NSMutableArray *)groupedTheArray:(NSMutableArray *)array andTitleArray:(NSMutableArray *)title andLikeArray:(NSMutableArray *)like;

@end
