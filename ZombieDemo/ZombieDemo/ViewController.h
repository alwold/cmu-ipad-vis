//
//  ViewController.h
//  ZombieDemo
//
//  Created by Al Wold on 2/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (void) loadQuarantineZone;
- (NSArray *) loadZombies;
- (NSArray *) loadWeapons;

@end
