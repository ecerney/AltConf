//
//  DetailViewController.m
//  CustomTransition
//
//  Created by Eric Cerney on 5/31/14.
//  Copyright (c) 2014 Eric Cerney. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIButton *favoriteButton;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// add defaults here so we can unit test
- (instancetype)initWithPhotoObject:(PhotoObject *)object
{
    if (self) {
        self.photoObject = object;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateFavoriteButton];
}

- (void)setPhotoObject:(PhotoObject *)photoObject
{
    _photoObject = photoObject;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoObject.imageURLString]];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    });
    
    self.title = _photoObject.name;
    [self updateFavoriteButton];
}

- (IBAction)favoriteButtonPressed:(UIButton *)sender
{
    self.photoObject.favorite = !self.photoObject.favorite;
    
    [self updateFavoriteButton];
}
//Note - Problem setting title before button is set.. add unit test
- (void)updateFavoriteButton
{
    if (self.photoObject.isFavorite) {
        [self.favoriteButton setTitle:@"Remove Favorite" forState:UIControlStateNormal];
    }
    else {
        [self.favoriteButton setTitle:@"Favorite" forState:UIControlStateNormal];
    }
}

@end
