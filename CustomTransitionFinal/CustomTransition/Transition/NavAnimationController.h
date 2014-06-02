//
//  NavAnimationController.h
//  CustomTransition
//
//  Created by Eric Cerney on 5/1/14.
//  Copyright (c) 2014 Eric Cerney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL reverse;

@end
