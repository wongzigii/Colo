//
//  DetailViewController.h
//  Colo
//
//  Created by Wongzigii on 1/11/15.
//  Copyright (c) 2015 Wongzigii. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModalViewController;
@protocol ModalViewControllerDelegate <NSObject>

-(void) modalViewControllerDidClickedDismissButton:(ModalViewController *)viewController;

@end


@interface DetailViewController : UIViewController

@property (nonatomic, weak) id<ModalViewControllerDelegate> delegate;

@end
