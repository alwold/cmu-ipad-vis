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
		[source.strengthByAttribute enumerateKeysAndObjectsUsingBlock:^(NSString* attributeName, NSNumber *sourceStrengthNum, BOOL *stop) {
			double targetStrength = [self normalizedStrengthForTarget:target forAttributeName:attributeName];
			attraction += sourceStrengthNum.doubleValue * targetStrength;
		}];
		attraction *= source.scaleFactor;
	}
	return attraction;
}

- (double)normalizedStrengthForTarget:(ParticleModel*)target forAttributeName:(NSString*)attributeName
{
	NSNumber *targetStrengthNum = [target.strengthByAttribute valueForKey:attributeName];
	double targetStrength = targetStrengthNum.doubleValue;
	double normalizedStrength = 1;
	
	if (self.targetThresholds) {
		double span = [self.targetMaxes strengthForAttribute:attributeName] - [self.targetMins strengthForAttribute:attributeName];
		if (span != 0) {
			double threshold = [self.targetThresholds strengthForAttribute:attributeName];
			normalizedStrength = (targetStrength - threshold) / span;
		}
	}
	
	return normalizedStrength;
}
@end
