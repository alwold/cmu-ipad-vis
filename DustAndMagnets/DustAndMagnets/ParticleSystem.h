//
//  ParticleSystem.h
//  DustAndMagnets
//
//  Created by Al Wold on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParticleSystem : NSObject

@property (nonatomic, retain) NSMutableArray *magnetParticles;
@property (nonatomic, retain) NSMutableArray *dustParticles;
@property (nonatomic, retain) NSSet *knownAttributes;

- (id)initWithTestData;
- (id)initWithRicherTestData;
- (void)processDustParticles;
- (NSMutableArray*)testMagnetModel;
- (NSMutableArray*)testDustModel;

@end
