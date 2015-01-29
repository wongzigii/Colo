//
//  SwipeUpInteractionTransition.m
//  Colo
//
//  Created by Wongzigii on 1/9/15.
//  Copyright (c) 2015 Wongzigii. All rights reserved.
//

#import "SwipeUpInteractionTransition.h"

@interface SwipeUpInteractionTransition()
@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *presentingVC;

@end

@implementation SwipeUpInteractionTransition

- (void)wireToViewController:(UIViewController *)viewController
{
    self.presentingVC = viewController;
    [self prepareGestureRecognizerInView:self.presentingVC.view];
}

- (void)prepareGestureRecognizerInView:(UIView *)view
{
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpGesture:)];
    [view addGestureRecognizer:gesture];
}

-(CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handleSwipeUpGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            self.interacting = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        }

        case UIGestureRecognizerStateChanged:{
            CGFloat fraction = translation.y / 400;
            CGFloat percent = fminf(fmaxf(fraction, 0), 1.0);
            self.shouldComplete = percent > 0.5;
            [self updateInteractiveTransition:fraction];
            break;
        }
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:{
            self.interacting = NO;
            if (!self.shouldComplete || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            }else{
                [self finishInteractiveTransition];
            }
            break;
        }
            
        default:
            break;
    }
}

@end
