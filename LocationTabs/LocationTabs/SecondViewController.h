//
//  SecondViewController.h
//  LocationTabs
//
//  Created by Al Wold on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SecondViewController : UIViewController
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *geocoder;
- (IBAction)geocodeButtonPressed;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
