//
//  FavoritesViewController.m
//  CustomTransition
//
//  Created by Eric Cerney on 6/1/14.
//  Copyright (c) 2014 Eric Cerney. All rights reserved.
//

#import "FavoritesViewController.h"
#import "PhotoObject.h"
#import "DetailViewController.h"

@interface FavoritesViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation FavoritesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *favoritesDictionary = [defaults objectForKey:@"favorites"];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (NSString *key in favoritesDictionary) {
        NSData *data = favoritesDictionary[key];
        
        PhotoObject *object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [tempArray addObject:object];
    }
    
    self.dataArray = [NSArray arrayWithArray:tempArray];
    
    [self.tableView reloadData];
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
    //detailVC.photoObject = currentPhoto;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - IBActions

- (IBAction)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
