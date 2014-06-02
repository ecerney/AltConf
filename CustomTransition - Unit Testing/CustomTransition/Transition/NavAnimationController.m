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
    return 0.2;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // Get Viewcontrollers and final frame
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    
    // Set initial frame of toView
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect toInitialFrame = CGRectOffset(finalFrame, self.reverse ? -50 : screenBounds.size.width, 0);
    toVC.view.frame = toInitialFrame;
    toVC.view.alpha = 1.0;
    
    // 4. add the view
    [containerView addSubview:toVC.view];
    
    if (self.reverse) {
        [containerView sendSubviewToBack:toVC.view];
        toVC.view.alpha = 0.6;
        [self addShadowToUIView:fromVC.view];
    }
    else {
        [self addShadowToUIView:toVC.view];
    }
    
    // 1. Determine the intermediate and final frame for the from view
    CGRect fromFinalFrame = CGRectOffset(finalFrame, self.reverse ? screenBounds.size.width : -50, 0);
    
    // animate with keyframes
    UIViewKeyframeAnimationOptions options = 0;
    if ([transitionContext isInteractive])
        options = UIViewKeyframeAnimationOptionCalculationModeLinear | UIViewAnimationOptionCurveLinear;
    else
        options = UIViewKeyframeAnimationOptionCalculationModeCubic | UIViewAnimationOptionCurveEaseInOut;
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext]
                                   delay:0.0
                                 options:options
                              animations:^{
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0 animations:^{
                                      if (self.reverse) {
                                          toVC.view.alpha = 1.0;
                                      }
                                      else {
                                          fromVC.view.alpha = 0.6;
                                      }
                                      
                                      toVC.view.frame = finalFrame;
                                      fromVC.view.frame = fromFinalFrame;
                                  }];
                              }
                              completion:^(BOOL finished) {
                                  fromVC.view.alpha = 1.0;
                                  toVC.view.alpha = 1.0;
                                  
                                  if (self.reverse)
                                      [self removeShadowFromUIView:fromVC.view];
                                  else
                                      [self removeShadowFromUIView:toVC.view];
                                  
                                  [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                              }];
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
