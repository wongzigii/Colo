//
//  MenuViewController.h
//  Colo
//
//  Created by Wongzigii on 15/3/7.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewControllerDelegate<NSObject>
- (NSString *)passValueFromMenuToCollectionViewController:(CGFloat)value;
@end

@interface MenuView : UIView
@property (nonatomic          ) NSString    *selectedCountry;
@property (nonatomic, readonly) BOOL        didOpenMenu;

- (void)handleHideOrShow;

@property (nonatomic, weak) id<MenuViewControllerDelegate> delegate;

@end


