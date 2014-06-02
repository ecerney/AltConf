//
//  NavSwipeInteractionController.m
//  CustomTransition
//
//  Created by Eric Cerney on 5/1/14.
//  Copyright (c) 2014 Eric Cerney. All rights reserved.
//

#import "NavSwipeInteractionController.h"

@interface NavSwipeInteractionController()

@property (nonatomic, assign) BOOL shouldCompleteTransition;

@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *leftSideGesture;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *rightSideGesture;

@end

@implementation NavSwipeInteractionController

- (id)init
{
    if (self = [super init]) {
        self.leftSideGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftGesture:)];
        self.leftSideGesture.edges = UIRectEdgeLeft;
        
        self.rightSideGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightGesture:)];
        self.rightSideGesture.edges = UIRectEdgeRight;
    }
    
    return self;
}

- (void)setDelegate:(UIViewController<NavSwipeInteractionControllerDelegate> *)delegate
{
    _delegate = delegate;
    
    [self.delegate.view addGestureRecognizer:self.leftSideGesture];
    [self.delegate.view addGestureRecognizer:self.rightSideGesture];
}

- (CGFloat)completionSpeed
{
    return 1 - self.percentComplete;
}

- (void)handleLeftGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:recognizer.view];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            self.interactionInProgress = YES;
            
            if ([self.delegate respondsToSelector:@selector(swipeControllerDidSwipeBack)]) {
                [self.delegate swipeControllerDidSwipeBack];
            }
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGFloat fraction = (location.x / recognizer.view.frame.size.width);
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);

            self.shouldCompleteTransition = (fraction > 0.5);
            [self updateInteractiveTransition:fraction];
            
            break;
        }
        case UIGestureRecognizerStateEnded: {
            self.interactionInProgress = NO;
            
            CGPoint velocity = [recognizer velocityInView:recognizer.view];
            
            if (self.shouldCompleteTransition) {
                [self finishInteractiveTransition];
            }
            else {
                if (velocity.x > 100) {
                    [self finishInteractiveTransition];
                }
                else {
                    [self cancelInteractiveTransition];
                }
            }
            
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            self.interactionInProgress = NO;
            
            [self cancelInteractiveTransition];
            break;
        }
        default:
            break;
    }
}

- (void)handleRightGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:recognizer.view];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            self.interactionInProgress = YES;

            if ([self.delegate respondsToSelector:@selector(swipeControllerDidSwipeForward)]) {
                [self.delegate swipeControllerDidSwipeForward];
            }
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGFloat fraction = ((recognizer.view.frame.size.width - location.x) / recognizer.view.frame.size.width);
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.shouldCompleteTransition = (fraction > 0.5);
            [self updateInteractiveTransition:fraction];
            
            break;
        }
        case UIGestureRecognizerStateEnded: {
            self.interactionInProgress = NO;
            
            CGPoint velocity = [recognizer velocityInView:recognizer.view];
                        
            if (self.shouldCompleteTransition) {
                [self finishInteractiveTransition];
            }
            else {
                if (velocity.x < -100) {
                    [self finishInteractiveTransition];
                }
                else {
                    [self cancelInteractiveTransition];
                }
            }
            
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            self.interactionInProgress = NO;
            
            [self cancelInteractiveTransition];
            break;
        }
        default:
            break;
    }
}

@end
