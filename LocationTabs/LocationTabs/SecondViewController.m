//
//  SecondViewController.m
//  LocationTabs
//
//  Created by Al Wold on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController
@synthesize textView;

@synthesize locationManager;
@synthesize geocoder;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.geocoder = [[CLGeocoder alloc] init];
	self.locationManager = [[CLLocationManager alloc] init];
}

- (void)viewDidUnload
{
	[self setTextView:nil];
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
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)geocodeButtonPressed {
	CLLocation *lastKnownLocation = self.locationManager.location;
	
	if (lastKnownLocation) {
		[self.geocoder reverseGeocodeLocation:lastKnownLocation completionHandler:^(NSArray *placemarks, NSError *error)
		{
			if (placemarks.count > 0) {
				CLPlacemark *placemark = (CLPlacemark *)[placemarks objectAtIndex:0];
				self.textView.text = placemark.description;
			} else if (error) {
				self.textView.text = [NSString stringWithFormat:@"Geocoder returned error: %@", error];
			}
		}];
	} else {
		self.textView.text = @"Location manager has no last known location. Can't geocode.";
	}
}
@end
