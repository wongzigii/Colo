//
//  SwipeUpInteractionTransition.h
//  Colo
//
//  Created by Wongzigii on 1/9/15.
//  Copyright (c) 2015 Wongzigii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeUpInteractionTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) BOOL interacting;
- (void)wireToViewController:(UIViewController *)viewController;

@end
