//
//  DetailViewController.h
//  CustomTransition
//
//  Created by Eric Cerney on 5/31/14.
//  Copyright (c) 2014 Eric Cerney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoObject.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) PhotoObject *photoObject;

- (instancetype)initWithPhotoObject:(PhotoObject *)object;

@end
