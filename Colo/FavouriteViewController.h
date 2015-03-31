//
//  FavouriteViewController.h
//  Colo
//
//  Created by Wongzigii on 15/3/7.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavouriteViewController : UIViewController
@property (nonatomic, readonly) NSMutableArray *favouriteArray;
- (void)passFavouriteArray:(NSMutableArray *)array;
@end

