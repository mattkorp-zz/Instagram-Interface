//
//  PopularMediaViewController.m
//  InstApp
//
//  Created by Matthew Korporaal on 11/24/13.
//  Copyright (c) 2013 Matthew Korporaal. All rights reserved.
//

#import "PopularMediaViewController.h"
#import "MediaManager.h"
#import "MediaObject.h"

@interface PopularMediaViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) MediaManager *mediaManager;
@property (nonatomic, strong) NSArray *mediaObjects;
@end

@implementation PopularMediaViewController

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
    // Do any additional setup after loading the view from its nib.
    self.title = @"Media";
    
    // same as [NSArray[alloc init]];
    self.mediaObjects = [NSArray array];
    
    self.mediaManager = [[MediaManager alloc] init];
    [self updateContent];
    
    // self.view.backgroundColor = [UIColor orangeColor];

}

- (void)updateContent
{
    [self.mediaManager fetchPopularMediaWithCompletionBlock:^(NSArray *media, NSError *error) {
        NSLog(@"Media: %@", media);
    
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (media) {
                NSLog(@"%@",media);
                self.mediaObjects = media;
                [self.tableView reloadData];
            } else {
                NSLog(@"%@",error);
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Uh Oh!" message:@"An error occurred" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
            }
        });
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// called when row tapped in tableView
#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// makes cell templates and reuses or "dequeues" the cell.
#pragma mark = UITableView Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // if we cant dequeue a cell, make another, there are several types of cell, identifier is used
    // for getting the cell later
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // UILabel add text and '>' disclosure indicator
    MediaObject *mediaObject = self.mediaObjects[indexPath.row];
    cell.textLabel.text = mediaObject.username;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

// number of row in the section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mediaObjects count];
}

@end
