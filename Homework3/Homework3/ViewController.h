//
//  ViewController.h
//  Homework3
//
//  Created by Al Wold on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate>
- (IBAction)userTappedMap:(UITapGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)clearPoints:(id)sender;
- (IBAction)connectPoints:(id)sender;

@end
