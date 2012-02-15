//
//  ViewController.m
//  Homework3
//
//  Created by Al Wold on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

#define LATITUDE 33.306389
#define LONGITUDE -112.013333

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
	self.mapView.delegate = self;
//	MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
//	annotation.coordinate = CLLocationCoordinate2DMake(LATITUDE, LONGITUDE);
//	annotation.title = @"My House";
//	[self.mapView addAnnotation:annotation];
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

- (IBAction)userTappedMap:(UITapGestureRecognizer *)sender {
	if (sender.state == UIGestureRecognizerStateEnded) {
		CGPoint point = [sender locationInView:self.mapView];
		CLLocationCoordinate2D location = [mapView convertPoint:point toCoordinateFromView:mapView];
		MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
		annotation.coordinate = location;
		[self.mapView addAnnotation:annotation];
		NSLog(@"tap! %f %f", location.latitude, location.longitude);
	 }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
	MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
	
	if (!pin) {
		pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
		pin.canShowCallout = YES;
	} else {
		pin.annotation = annotation;
	}
	return pin;
}
- (IBAction)clearPoints:(id)sender {
	[self.mapView removeOverlays:[self.mapView overlays]];
	[self.mapView removeAnnotations:[self.mapView annotations]];
}

- (IBAction)connectPoints:(id)sender {
	NSLog(@"Allocate space for %d points", self.mapView.annotations.count);
	CLLocationCoordinate2D *points = malloc(sizeof(CLLocationCoordinate2D)*self.mapView.annotations.count);
	int i = 0;
	for (id point in self.mapView.annotations) {
		CLLocationCoordinate2D coordinate = [((MKPointAnnotation *) point) coordinate];
		points[i].latitude = coordinate.latitude;
		points[i].longitude = coordinate.longitude;
		i++;
	}
	MKPolyline *line = [MKPolyline polylineWithCoordinates:points count:i];
	[self.mapView addOverlay:line];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
	if ([overlay isKindOfClass:[MKPolyline class]]) {
		MKPolylineView *view = [[MKPolylineView alloc] initWithPolyline:(MKPolyline *)overlay];
		view.strokeColor = [UIColor blueColor];
		view.lineWidth = 2;
		return view;
	}
	return nil;
	
}
@end
