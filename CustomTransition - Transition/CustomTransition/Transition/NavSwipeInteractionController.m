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
    //CGPoint location = [recognizer locationInView:recognizer.view];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            // Set interaction in progress
            
            // Notify delegate: Note - This is done through our custom delegate because we are
            // doing something special with a UINavigationController subclass
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            // Calculate the fraction its dragged between 0 and 1
            
            // Bonus - Set shouldCompleteTransition if past threshold
            
            // Update interactive transition with the fraction
            
            break;
        }
        case UIGestureRecognizerStateEnded: {
            // Disable interaction in progress
            
            // Either cancel or finish transition based off shouldCompleteTransition
            
            // Bonus - Calulate velocity and factor that into whether or not to finish
            
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            // Disable interaction in progress
            self.interactionInProgress = NO;
            
            // Cancel interactive transition
            break;
        }
        default:
            break;
    }
}

- (void)handleRightGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    //CGPoint location = [recognizer locationInView:recognizer.view];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan: {
            // Set interaction in progress

            // Notify delegate: Note - This is done through our custom delegate because we are
            // doing something special with a UINavigationController subclass
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            // Calculate the fraction its dragged between 0 and 1
            
            // Bonus - Set shouldCompleteTransition if past threshold
            
            // Update interactive transition with the fraction
            
            break;
        }
        case UIGestureRecognizerStateEnded: {
            // Disable interaction in progress
            
            // Either cancel or finish transition based off shouldCompleteTransition
            
            // Bonus - Calulate velocity and factor that into whether or not to finish
            
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            // Disable interaction in progress
            self.interactionInProgress = NO;
            
            // Cancel interactive transition
            break;
        }
        default:
            break;
    }
}

@end
