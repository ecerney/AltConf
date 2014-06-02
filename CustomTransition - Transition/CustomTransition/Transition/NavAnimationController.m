//
//  AnimationController.m
//  CustomTransition
//
//  Created by Eric Cerney on 5/1/14.
//  Copyright (c) 2014 Eric Cerney. All rights reserved.
//

#import "NavAnimationController.h"

@implementation NavAnimationController

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    /*
    // Get Viewcontrollers and final frame
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    
    // Set initial frame of toView
    
    // Add the toView, set starting alphas, and add shadow
    [containerView addSubview:toVC.view];
    
    // Determine the final frame for the from view
    
    // animate with keyframes
   
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
     */
}


#pragma mark - Internal Helper Methods

- (void)addShadowToUIView:(UIView *)view
{
    view.layer.masksToBounds = NO;
    view.layer.shadowPath = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    view.layer.shadowOffset = CGSizeMake(-5, 0);
    view.layer.shadowRadius = 3.0;
    view.layer.shadowOpacity = 0.2f;
}

- (void)removeShadowFromUIView:(UIView *)view
{
    view.layer.shadowPath = nil;
    view.layer.shadowRadius = 0.0;
    view.layer.shadowOpacity = 0.0;
    view.layer.shadowColor = nil;
}

@end
