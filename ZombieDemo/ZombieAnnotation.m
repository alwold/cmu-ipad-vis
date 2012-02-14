//
//  ZombieAnnotation.m
//  ZombieDemo
//
//  Created by Al Wold on 2/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ZombieAnnotation.h"

#define UPITT_LAT 40.444089
#define UPITT_LONG -79.953389

@implementation ZombieAnnotation

- (NSString *) title {
	return [self randomZombieNoise];
}

- (NSString *) subtitle {
	int r = rand()%50;
	return [NSString stringWithFormat:@"Risk Level: %d", r];
}

- (CLLocationCoordinate2D) coordinate {
	double rlat = (double)(rand() % 1000 - 500)/30000.0;
	double rlong = (double)(rand() % 1000 - 500)/30000.0;
	
	return CLLocationCoordinate2DMake(UPITT_LAT+rlat, UPITT_LONG+rlong);
}

- (NSString *) randomZombieNoise {
	int r = rand() % 6;
	
	switch (r) {
		case 0:
			return @"BRAAAINS";
		case 1:
			return @"NNNNGH";
		case 2:
			return @"BRAINS";
		case 3:
			return @"NOMMMMM";
		case 4:
			return @"NOMMMMM";
		case 5:
			return @"NNNNGH";
		default:
			return @"BRAINS!";
			
	}
}

@end
