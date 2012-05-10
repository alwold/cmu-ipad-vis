//
//  PhysicsEngine.m
//  DustAndMagnets
//
//  Created by Al Wold on 5/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PhysicsEngine.h"

@implementation PhysicsEngine

@synthesize targetMins;
@synthesize targetMaxes;
@synthesize targetThresholds;

- (double)attractionBetweenSource:(ParticleModel *)source andTarget:(ParticleModel *)target
{
	__block double attraction = 0;
	if (source.enabled && target.enabled) {
		[source.strengthByAttribute enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSNumber *sourceStrengthNum, BOOL *stop) {
			NSNumber *targetStrengthNum = [target.strengthByAttribute valueForKey:key];
			attraction += sourceStrengthNum.doubleValue * targetStrengthNum.doubleValue;
		}];
	}
	return attraction;
}
@end
