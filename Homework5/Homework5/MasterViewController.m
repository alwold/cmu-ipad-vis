//
//  MasterViewController.m
//  Homework5
//
//  Created by Al Wold on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AppDelegate.h"

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;
@synthesize tableView = _tableView;
@synthesize datePicker = _datePicker;
@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize timerRunning = _timerRunning;
@synthesize dispatchSource = _dispatchSource;

- (void)awakeFromNib
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
	    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	}
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)updateTweetFilter
{
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit) fromDate:[NSDate date]];
	NSDate *startDate = [calendar dateFromComponents:comps];
	NSLog(@"startDate = %@", startDate);
	[comps setHour:comps.hour+1];
	NSDate *endDate = [calendar dateFromComponents:comps];
	NSLog(@"endDate = %@", endDate);
	[self.fetchedResultsController.fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"timestamp BETWEEN { %@, %@ }", startDate, endDate]];
	NSError *error;
	[self.fetchedResultsController performFetch:&error];
	[self.tableView reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
	
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tweet"];
	NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
	AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
	NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
	self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:nil];
	[self updateTweetFilter];
}

- (void)viewDidUnload
{
	[self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSUInteger count = [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
	NSLog(@"Cell count: %d", count);
	return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Tweet"];
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	cell.textLabel.text = [managedObject valueForKey:@"content"];
	return cell;
}
- (IBAction)dateChanged:(UIDatePicker *)sender {
	[self updateTweetFilter];
}

- (IBAction)startStopTimer:(UIButton *)sender {
	if (self.timerRunning) {
		//stop it
		dispatch_source_cancel(self.dispatchSource);
		self.timerRunning = NO;
		[sender setTitle:@"Start" forState:UIControlStateNormal];
	} else {
		// start it
		NSLog(@"starting. ref date = %@", self.datePicker.date);
		self.dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
		dispatch_source_set_event_handler(self.dispatchSource, ^{
			// advance the date by an hour
			NSLog(@"timer event fired");
			NSDate *date = self.datePicker.date;
			NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
			NSDateComponents *comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit) fromDate:date];
			[comps setHour:comps.hour+1];
			self.datePicker.date = [calendar dateFromComponents:comps];
		});
		dispatch_source_set_timer(self.dispatchSource, DISPATCH_TIME_NOW,  1000000000 ,  1000000000);
		dispatch_resume(self.dispatchSource);
		self.timerRunning = YES;
		[sender setTitle:@"Stop" forState:UIControlStateNormal];
	}
	
}
@end
