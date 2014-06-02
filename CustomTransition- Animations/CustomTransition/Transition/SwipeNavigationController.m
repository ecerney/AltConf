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

@property (nonatomic, strong) NavAnimationController *navAnimationController;
@property (nonatomic, strong) NavSwipeInteractionController *navSwipeController;

@property (nonatomic, strong) ModalAnimationController *modalAnimationController;

@property (nonatomic, strong) UIViewController *currentTopVC;
@property (nonatomic, strong) UIViewController *lastPoppedVC;

@end

@implementation SwipeNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navAnimationController = [NavAnimationController new];
    self.navSwipeController = [NavSwipeInteractionController new];
    self.navSwipeController.delegate = self;
    
    self.delegate = self;
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
    self.navAnimationController.reverse = operation == UINavigationControllerOperationPop;
    
    return self.navAnimationController;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.navSwipeController.interactionInProgress ? self.navSwipeController : nil;
}


#pragma mark - UIViewControllerTransitioning Delegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.modalAnimationController = [ModalAnimationController new];
    self.modalAnimationController.reverse = NO;
    
    return self.modalAnimationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.modalAnimationController.reverse = YES;
    return self.modalAnimationController;
}

@end
