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
@synthesize annotations = _annotations;

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

	[self reloadTweets];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSUInteger count = [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
	NSLog(@"numberofRows: %d", count);
	return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"cellforRow");
	static NSString *cellIdentifier = @"TweetCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	Tweet *tweet = [self.fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = tweet.user.username;
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", tweet.content, tweet.timestamp];
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString *title = [[[self.fetchedResultsController sections] objectAtIndex:section] name];
	NSLog(@"titleForHeader: %@", title);
	return title;
}

- (IBAction)filterEntered:(UITextField *)sender {
	NSLog(@"filterEntered");
	if (sender.text.length == 0) {
		// no filter
		[[self.fetchedResultsController fetchRequest] setPredicate:nil];
	} else {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"content like[cd] %@", [[@"*" stringByAppendingString:sender.text] stringByAppendingString:@"*"]];
		[[self.fetchedResultsController fetchRequest] setPredicate:predicate];
	}
	[self reloadTweets];
}

- (IBAction)sortChanged:(UISegmentedControl *)sender {
	if (sender.selectedSegmentIndex == 0) {
		// newest
		self.fetchedResultsController.fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO]];
	} else {
		// oldest
		self.fetchedResultsController.fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES]];
	}
	[self reloadTweets];
}

- (IBAction)batchSizeChanged:(UISlider *)sender {
	[self.fetchedResultsController.fetchRequest setFetchBatchSize:sender.value];
	[self reloadTweets];
}

- (IBAction)filterByMap {
	MKMapView *mapView = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).mapView;
	CLLocationDegrees minLat = mapView.centerCoordinate.latitude - (mapView.region.span.latitudeDelta/2);
	CLLocationDegrees minLon = mapView.centerCoordinate.longitude - (mapView.region.span.longitudeDelta/2);
	CLLocationDegrees maxLat = mapView.centerCoordinate.latitude + (mapView.region.span.latitudeDelta/2);
	CLLocationDegrees maxLon = mapView.centerCoordinate.longitude + (mapView.region.span.longitudeDelta/2);
	
	NSLog(@"Bounding rect: %f, %f - %f, %f", minLat, minLon, maxLat, maxLon);
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"latitude >= %f and latitude <= %f and longitude >= %f and longitude <= %f", minLat, maxLat, minLon, maxLon];
	[self.fetchedResultsController.fetchRequest setPredicate:predicate];
	[self reloadTweets];
}

- (void)reloadTweets {
	AppDelegate *delegate = [[UIApplication sharedApplication] delegate];

	NSError *error;
	[self.fetchedResultsController performFetch:&error];
	[self.tableView reloadData];
	
	// add pins for first 100 tweets
	[delegate.mapView removeAnnotations:delegate.mapView.annotations];
	self.annotations = [NSMutableSet setWithCapacity:100];
	NSUInteger tweetCount = [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
	for (int i = 0; i < 100 && i < tweetCount; i++) {
		Tweet *tweet = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		if (tweet.latitude && tweet.longitude) {
			MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
			annotation.coordinate = CLLocationCoordinate2DMake([tweet.latitude doubleValue], [tweet.longitude doubleValue]);
			[delegate.mapView addAnnotation:annotation];
			[self.annotations addObject:annotation];
		}
	}

}
@end
