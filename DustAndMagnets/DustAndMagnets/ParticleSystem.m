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
@synthesize dustMax;
@synthesize dustMin;
@synthesize dustThreshold;
@synthesize attributes;

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

- (id)initWithDataFilename:(NSString*)filename
{
	self = [super init];
	if (self) {
		self.dustParticles = [self dustModelWithJSON:[self JSONFromFile:filename]];
		[self processDustParticles];
		self.magnetParticles = [self magnetModelFromDustModel:self.dustParticles];
	}
	return self;
}

- (NSMutableArray *)dustModelWithJSON:(NSData*)json
{
	NSMutableArray *result = [NSMutableArray array];
	NSError *error = nil;
	NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:&error];
	
	if (!jsonArray) {
		NSLog(@"Error parsing JSON: %@", json);
	} else {
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		formatter.numberStyle = NSNumberFormatterDecimalStyle;
		
		for (NSDictionary *dustData in jsonArray) {
			NSString *particleName = [dustData objectForKey:@"name"];
			NSMutableDictionary *strengthByAttribute = [NSMutableDictionary dictionaryWithCapacity:dustData.count - 1];
			
			[dustData enumerateKeysAndObjectsUsingBlock:^(NSString *attributeName, NSString *stringValue, BOOL *stop) {
				if (![attributeName isEqualToString:@"name"]) {
					NSNumber *value = [formatter numberFromString:stringValue];
					[strengthByAttribute setValue:value forKey:attributeName];
				}
			}];
			[result addObject:[ParticleModel particleModelWithName:particleName strengthByAttribute:strengthByAttribute]];
		}
	}
	return result;
}

- (NSMutableArray*)magnetModelFromDustModel:(NSArray*)dustModel
{
	NSMutableArray *magnetModel = [NSMutableArray arrayWithCapacity:self.knownAttributes.count];
    for (NSString *attributeName in self.knownAttributes) {
        [magnetModel addObject:[ParticleModel particleModelWithName:attributeName strengthByAttribute:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                                                                       [NSNumber numberWithDouble:1.], attributeName,
                                                                                                       nil]]];
    }
    return magnetModel;
}

- (NSData*)JSONFromFile:(NSString*)filename
{
	NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
	NSError *error = nil;
	NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
	NSData *jsonData = [contents dataUsingEncoding:NSUTF8StringEncoding];
	return jsonData;
}


- (void)processDustParticles
{
    NSMutableSet *dustAttributeNames = [NSMutableSet setWithCapacity:self.dustParticles.count];
    ParticleModel *dustMin = [ParticleModel particleModelWithName:@"min" strengthByAttribute:[NSMutableDictionary dictionaryWithCapacity:self.dustParticles.count]];
    ParticleModel *dustMax = [ParticleModel particleModelWithName:@"max" strengthByAttribute:[NSMutableDictionary dictionaryWithCapacity:self.dustParticles.count]];
	ParticleModel *dustThreshold = [ParticleModel particleModelWithName:@"threshold" strengthByAttribute:[NSMutableDictionary dictionaryWithCapacity:self.dustParticles.count]];

    
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
                    [dustThreshold.strengthByAttribute setObject:[NSNumber numberWithDouble:curValue] forKey:attributeName];
                }
                if (!maxNum || curValue > maxNum.doubleValue) {
                    [dustMax.strengthByAttribute setObject:[NSNumber numberWithDouble:curValue] forKey:attributeName];
                }
            }
        }];
    }
    self.knownAttributes = dustAttributeNames;
    self.attributes = [self.knownAttributes.allObjects sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];

    self.dustMin = dustMin;
    self.dustMax = dustMax;
    self.dustThreshold = dustThreshold;
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
