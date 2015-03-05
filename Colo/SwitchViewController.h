//
//  SwitchViewController.h
//  Colo
//
//  Created by Wongzigii on 15/3/5.
//  Copyright (c) 2015年 Wongzigii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagerViewController.h"

@class ModalViewController;

//protocol had defined in XHTwitterPaggingViewer
@protocol ModalViewControllerDelegate <NSObject>

-(void) modalViewControllerDidClickedDismissButton:(ModalViewController *)viewController;

@end


@interface SwitchViewController : PagerViewController
@property (nonatomic, weak) id<ModalViewControllerDelegate> delegate;

@end
