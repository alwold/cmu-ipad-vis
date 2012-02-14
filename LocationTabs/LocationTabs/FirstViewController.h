//
//  FirstViewController.h
//  LocationTabs
//
//  Created by Al Wold on 2/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

@interface FirstViewController : UIViewController <CLLocationManagerDelegate>
- (IBAction)startTrackingLocation;
- (IBAction)stopTrackingLocation;
@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (strong, nonatomic) CLLocationManager *locationManager;
@end
