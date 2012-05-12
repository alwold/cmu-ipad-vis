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

#define MAX_POINTS 100

@implementation ViewController
@synthesize connectButton;
@synthesize polygonButton;
@synthesize mapView;
@synthesize coordinates;
@synthesize coordinateCount;

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
	self.coordinates = malloc(sizeof(CLLocationCoordinate2D)*MAX_POINTS);
	self.coordinateCount = 0;
}

- (void)viewDidUnload
{
	[self setMapView:nil];
	[self setConnectButton:nil];
	[self setPolygonButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	free(coordinates);
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
	if (sender.state == UIGestureRecognizerStateEnded && coordinateCount < MAX_POINTS) {
		CGPoint point = [sender locationInView:self.mapView];
		CLLocationCoordinate2D location = [mapView convertPoint:point toCoordinateFromView:mapView];
		MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
		annotation.coordinate = location;
		[self.mapView addAnnotation:annotation];
		self.coordinates[coordinateCount++] = location;
		if (coordinateCount > 1) {
			[self.connectButton setEnabled:YES];
		}
		if (coordinateCount > 2) {
			[self.polygonButton setEnabled:YES];
		}
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
	coordinateCount = 0;
	[self.connectButton setEnabled:NO];
	[self.polygonButton setEnabled:NO];
}

- (IBAction)connectPoints:(id)sender {
	MKPolyline *line = [MKPolyline polylineWithCoordinates:coordinates count:coordinateCount];
	[self.mapView addOverlay:line];
	coordinateCount = 0;
	[self.connectButton setEnabled:NO];
	[self.polygonButton setEnabled:NO];
}

- (IBAction)makePolygon:(id)sender {
	MKPolygon *polygon = [MKPolygon polygonWithCoordinates:coordinates count:coordinateCount];
	[self.mapView addOverlay:polygon];
	coordinateCount = 0;
	[self.connectButton setEnabled:NO];
	[self.polygonButton setEnabled:NO];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
	if ([overlay isKindOfClass:[MKPolyline class]]) {
		MKPolylineView *view = [[MKPolylineView alloc] initWithPolyline:(MKPolyline *)overlay];
		view.strokeColor = [UIColor blueColor];
		view.lineWidth = 2;
		return view;
	} else if ([overlay isKindOfClass:[MKPolygon class]]) {
		MKPolygonView *view = [[MKPolygonView alloc] initWithPolygon:(MKPolygon *)overlay];
		view.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.3];
		view.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
		view.lineWidth = 2;
		return view;
	}
	return nil;
	
}
@end
