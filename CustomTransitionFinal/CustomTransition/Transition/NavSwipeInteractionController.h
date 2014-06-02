//
//  NavSwipeInteractionController.h
//  CustomTransition
//
//  Created by Eric Cerney on 5/1/14.
//  Copyright (c) 2014 Eric Cerney. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwipeNavigationController;

@protocol NavSwipeInteractionControllerDelegate <NSObject>

- (void)swipeControllerDidSwipeBack;
- (void)swipeControllerDidSwipeForward;

@end

@interface NavSwipeInteractionController : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interactionInProgress;
@property (nonatomic, weak) UIViewController <NavSwipeInteractionControllerDelegate> *delegate;

@end
