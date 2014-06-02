//
//  ViewController.m
//  CustomTransition
//
//  Created by Eric Cerney on 5/1/14.
//  Copyright (c) 2014 Eric Cerney. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "PhotoObject.h"
#import "FavoritesViewController.h"
#import "SwipeNavigationController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.500px.com/v1/photos?feature=popular&image_size[]=1&image_size[]=4&consumer_key=vW8Ns53y0F57vkbHeDfe3EsYFCatTJ3BrFlhgV3W"]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *photos = responseDict[@"photos"];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        for (NSDictionary *photoDict in photos) {
            PhotoObject *object = [[PhotoObject alloc] initWithDictionary:photoDict defaults:[NSUserDefaults standardUserDefaults]];
            
            [tempArray addObject:object];
        }
        
        self.dataArray = [NSArray arrayWithArray:tempArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    [task resume];
}


#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];
    UILabel *label1 = (UILabel *)[cell viewWithTag:2];
    
    PhotoObject *currentPhoto = self.dataArray[indexPath.row];
    
    label1.text = currentPhoto.name;
    imageView.image = nil;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:currentPhoto.thumbnailURLString]];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });
    
    return cell;
}


#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PhotoObject *currentPhoto = self.dataArray[indexPath.row];
    
    DetailViewController *detailVC = [[self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"] initWithPhotoObject:currentPhoto];

    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - IBActions

- (IBAction)favoritesPressed:(id)sender
{
    SwipeNavigationController *favoritesNavigationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FavoritesSwipeNavigationController"];
    favoritesNavigationVC.transitioningDelegate = favoritesNavigationVC;
    
    [self presentViewController:favoritesNavigationVC animated:YES completion:nil];
}

@end
