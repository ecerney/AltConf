//
//  SwipeNavigationController.m
//  CustomTransition
//
//  Created by Eric Cerney on 5/2/14.
//  Copyright (c) 2014 Eric Cerney. All rights reserved.
//

#import "SwipeNavigationController.h"
#import "NavAnimationController.h"
#import "NavSwipeInteractionController.h"
#import "ModalAnimationController.h"

@interface SwipeNavigationController () <UINavigationControllerDelegate, NavSwipeInteractionControllerDelegate>
{
    NSUInteger currentCount;
}

// TODO Declare animation and interaction controller properties


// TODO Declare modal animation controller property

@property (nonatomic, strong) UIViewController *currentTopVC;
@property (nonatomic, strong) UIViewController *lastPoppedVC;

@end

@implementation SwipeNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
    // TODO Create Animation controller
    
    // TODO Create interaction controller and set delegate
}


#pragma mark - SwipeInteractionController Delegate

- (void)swipeControllerDidSwipeBack
{
    [self popViewControllerAnimated:YES];
}

- (void)swipeControllerDidSwipeForward
{
    if (self.lastPoppedVC)
        [self pushViewController:self.lastPoppedVC animated:YES];
}

#pragma mark - Navigation Delegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > currentCount) {
        // A push occurred
        self.lastPoppedVC = nil;
    }
    else if (self.viewControllers.count < currentCount) {
        // A pop occurred
        self.lastPoppedVC = self.currentTopVC;
    }
    
    self.currentTopVC = self.topViewController;
    currentCount = self.viewControllers.count;
}


#pragma mark - UINavigation Transitioning Delegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    // Set animation controller reverse property
    
    // return the animation controller
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    // Return interactive controller if in progress
    return nil;
}


#pragma mark - UIViewControllerTransitioning Delegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    // Create modal animation controller and set its reverse property
    
    // Return modal animation controller
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    // Set modal animation controller reverse property

    // Return modal animation controller
    return nil;
}

@end
