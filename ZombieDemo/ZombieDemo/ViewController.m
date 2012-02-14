//
//  ViewController.m
//  ZombieDemo
//
//  Created by Al Wold on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ZombieAnnotation.h"
#import "WeaponAnnotation.h"

#define CMU_LAT 40.4435037
#define CMU_LONG -79.9415706

#define UPITT_LAT 40.444089
#define UPITT_LONG -79.953389

#define MAX_WEAPONS 100
#define MAX_ZOMBIES 100

@implementation ViewController
@synthesize mapView;

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
	CLLocationCoordinate2D center = CLLocationCoordinate2DMake(CMU_LAT, CMU_LONG);
	[self.mapView setRegion:MKCoordinateRegionMake(center, MKCoordinateSpanMake(0.1, 0.1))];
	[self.mapView setShowsUserLocation:YES];
	[self.mapView setDelegate:self];
	[self loadQuarantineZone];
	
	NSMutableArray *annotationArray = [NSMutableArray arrayWithCapacity:MAX_WEAPONS+MAX_ZOMBIES];
	
	[annotationArray addObjectsFromArray:[self loadZombies]];
//	[annotationArray addObjectsFromArray:[self loadWeapons]];
	
	[self.mapView addAnnotations:annotationArray];
}

- (void)viewDidUnload
{
	[self setMapView:nil];
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
	return YES;
}

- (NSArray *) loadZombies {
	NSMutableArray *zombieArray = [NSMutableArray arrayWithCapacity:MAX_ZOMBIES];
	for (int zomCount = 0; zomCount < MAX_ZOMBIES; zomCount++) {
		ZombieAnnotation *za = [[ZombieAnnotation alloc] init];
		[zombieArray addObject:za];
	}
	return zombieArray;
}

- (NSArray *) loadWeapons {
	NSMutableArray *weaponArray = [NSMutableArray arrayWithCapacity:MAX_WEAPONS];
	for (int zomCount = 0; zomCount < MAX_WEAPONS; zomCount++) {
		WeaponAnnotation *za = [[WeaponAnnotation alloc] init];
		[weaponArray addObject:za];
	}
	return weaponArray;
}

- (void) loadQuarantineZone {
	MKCircle *quarantine = [MKCircle circleWithCenterCoordinate:CLLocationCoordinate2DMake(UPITT_LAT, UPITT_LONG) radius:1000];
	[self.mapView addOverlay:quarantine];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
	MKAnnotationView *aView = [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"map"];
	
	if (!aView) {
		aView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"map"];
	}
	aView.annotation = annotation;
	aView.canShowCallout = YES;
	
	if ([annotation isKindOfClass:[ZombieAnnotation class]]) {
		aView.image = [UIImage imageNamed:@"zombie"];
	}
//	
//	if ([annotation isKindOfClass:[WeaponAnnotation class]]) {
//		NSString *name = [aView.annotation title];
//		aView.image = [UIImage imageNamed:name];
//	}
	return aView;
}

- (MKOverlayView *) mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
	MKCircleView *circleView = [[MKCircleView alloc] initWithCircle:overlay];
	circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
	circleView.strokeColor = [UIColor redColor];
	return circleView;
}


@end
