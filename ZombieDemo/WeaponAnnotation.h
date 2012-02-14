//
//  WeaponAnnotation.h
//  ZombieDemo
//
//  Created by Al Wold on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface WeaponAnnotation : NSObject <MKAnnotation>

@property (strong) NSString* type;

- (NSString *) randomWeapon;

@end
