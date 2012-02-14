//
//  WeaponAnnotation.m
//  ZombieDemo
//
//  Created by Al Wold on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WeaponAnnotation.h"

#define CMU_LAT 40.4435037
#define CMU_LONG -79.9415706

@implementation WeaponAnnotation
@synthesize type;

- (id) init {
	if (self = [super init]) {
		type = [self randomWeapon];
	}
	return self;
}

- (CLLocationCoordinate2D) coordinate {
	double rlat = (double)(rand() % 1000 - 500)/10000.0;
	double rlong = (double)(rand() % 1000 - 500)/10000.0;
	
	return CLLocationCoordinate2DMake(CMU_LAT+rlat, CMU_LONG+rlong);
}

- (NSString *) title {
	return type;
}

- (NSString *) subtitle {
	int r = rand() % 4 + 1;
	return [NSString stringWithFormat:@"%d available.", r];
}

- (NSString *) randomWeapon {
	int r = rand() * 4;
	
	switch (r) {
		case 0:
			return @"Shotguns";
			break;
		case 1:
			return @"bats";
			break;
		case 2:
			return @"Plants";
			break;
		case 3:
			return @"Meds";
			break;
		default:
			return @"Shotguns";
	}
}

@end
