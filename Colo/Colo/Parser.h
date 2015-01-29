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

+ (NSMutableArray *)parseWithHTMLString;

+ (NSMutableArray *)parsewithTitle;

+ (NSMutableArray *)groupedTheArray:(NSMutableArray *)array;

+ (NSMutableArray *)parsewithLikes;

@end
