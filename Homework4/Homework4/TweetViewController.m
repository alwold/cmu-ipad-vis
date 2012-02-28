//
//  TweetViewController.m
//  Homework4
//
//  Created by Al Wold on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TweetViewController.h"
#import "AppDelegate.h"
#import "Tweet.h"
#import "TwitterUser.h"
#import <CoreData/CoreData.h>

@implementation TweetViewController
@synthesize tableView;
@synthesize fetchedResultsController = _fetchedResultsController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self.tableView reloadData];
	
	AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *managedObjectContext = [delegate managedObjectContext];

	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Tweet"];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];

	[fetchRequest setSortDescriptors:sortDescriptors];
	
	self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];

	NSError *error;
	BOOL success = [self.fetchedResultsController performFetch:&error];
}

- (void)viewDidUnload
{
	[self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//	NSUInteger count = [[self.fetchedResultsController sections] count];
//	NSLog(@"numberOfSections: %d", count);
//	return count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSUInteger count = [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
	NSLog(@"numberofRows: %d", count);
	return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"cellforRow");
	static NSString *cellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (!cell) {
		NSLog(@"No cell, getting one");
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
	}
	Tweet *tweet = [self.fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = [[tweet user] username];
	cell.detailTextLabel.text = [tweet content];
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *title = [[[self.fetchedResultsController sections] objectAtIndex:section] name];
	NSLog(@"titleForHeader: %@", title);
	return title;
}

@end
