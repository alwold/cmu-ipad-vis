//
//  ParticleSystem.m
//  DustAndMagnets
//
//  Created by Al Wold on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParticleSystem.h"
#import "ParticleModel.h"

@implementation ParticleSystem

@synthesize magnetParticles;
@synthesize dustParticles;
@synthesize knownAttributes;

- (id)initWithTestData
{
    self = [super init];
    if (self) {
        self.magnetParticles = [self testMagnetModel];
        self.dustParticles = [self testDustModel];
        [self processDustParticles];
		
    }
    return self;
}

- (void)processDustParticles
{
    NSMutableSet *dustAttributeNames = [NSMutableSet setWithCapacity:self.dustParticles.count];
    ParticleModel *dustMin = [ParticleModel particleModelWithName:@"min" strengthByAttribute:[NSMutableDictionary dictionaryWithCapacity:self.dustParticles.count]];
    ParticleModel *dustMax = [ParticleModel particleModelWithName:@"max" strengthByAttribute:[NSMutableDictionary dictionaryWithCapacity:self.dustParticles.count]];
    
    for (ParticleModel *dust in self.dustParticles) {
        [dust.strengthByAttribute enumerateKeysAndObjectsUsingBlock:^(NSString *attributeName, NSNumber *value, BOOL *stop) {
            if (value /* value is NSNumberClass */) {
                //NSLog(@"%@, add attributeName=%@", dust.name, attributeName);
                [dustAttributeNames addObject:attributeName];
                
                double curValue = value.doubleValue; 
                NSNumber *minNum = [dustMin.strengthByAttribute objectForKey:attributeName];
                NSNumber *maxNum = [dustMax.strengthByAttribute objectForKey:attributeName];
                if (!minNum || curValue < minNum.doubleValue) {
                    [dustMin.strengthByAttribute setObject:[NSNumber numberWithDouble:curValue] forKey:attributeName];
                }
                if (!maxNum || curValue > maxNum.doubleValue) {
                    [dustMax.strengthByAttribute setObject:[NSNumber numberWithDouble:curValue] forKey:attributeName];
                }
            }
        }];
    }
    self.knownAttributes = dustAttributeNames;
}

- (NSMutableArray*)testMagnetModel
{
    NSMutableArray *result = [NSMutableArray array];
    
    [result addObject:[ParticleModel particleModelWithName:@"m1a" strengthByAttribute:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                                       [NSNumber numberWithDouble:1.00], @"alpha",
                                                                                       nil]]];
    
    [result addObject:[ParticleModel particleModelWithName:@"m2b" strengthByAttribute:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                                       [NSNumber numberWithDouble:1.00], @"beta",
                                                                                       nil]]];
    
    [result addObject:[ParticleModel particleModelWithName:@"m3g" strengthByAttribute:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                                       [NSNumber numberWithDouble:1.00], @"gamma",
                                                                                       nil]]];
    
    return result;
}

- (NSMutableArray*)testDustModel
{
    NSMutableArray *result = [NSMutableArray array];
    
    [result addObject:[ParticleModel particleModelWithName:@"d11" strengthByAttribute:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                                       [NSNumber numberWithDouble:0.20], @"alpha",
                                                                                       [NSNumber numberWithDouble:0.30], @"beta",
                                                                                       nil]]];
    
    [result addObject:[ParticleModel particleModelWithName:@"d12" strengthByAttribute:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                                       [NSNumber numberWithDouble:0.50], @"alpha",
                                                                                       [NSNumber numberWithDouble:0.70], @"beta",
                                                                                       nil]]];
    
    [result addObject:[ParticleModel particleModelWithName:@"d13" strengthByAttribute:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                                       [NSNumber numberWithDouble:1.00], @"alpha",
                                                                                       nil]]];
    
    [result addObject:[ParticleModel particleModelWithName:@"d14" strengthByAttribute:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                                       [NSNumber numberWithDouble:1.00], @"beta",
                                                                                       nil]]];
    
    [result addObject:[ParticleModel particleModelWithName:@"d15" strengthByAttribute:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                                       [NSNumber numberWithDouble:0.30], @"alpha",
                                                                                       [NSNumber numberWithDouble:0.80], @"beta",
                                                                                       nil]]];
    
    [result addObject:[ParticleModel particleModelWithName:@"d16" strengthByAttribute:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                                       [NSNumber numberWithDouble:0.20], @"alpha",
                                                                                       [NSNumber numberWithDouble:0.20], @"beta",
                                                                                       nil]]];
    
    return result;
}

@end
