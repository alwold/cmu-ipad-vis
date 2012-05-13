//
//  ParticleSystem.h
//  DustAndMagnets
//
//  Created by Al Wold on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParticleModel.h"

@interface ParticleSystem : NSObject

@property (nonatomic, retain) NSMutableArray *magnetParticles;
@property (nonatomic, retain) NSMutableArray *dustParticles;
@property (nonatomic, retain) NSSet *knownAttributes;
@property (nonatomic, strong) ParticleModel *dustMin;
@property (nonatomic, strong) ParticleModel *dustMax;
@property (nonatomic, strong) ParticleModel *dustThreshold;
@property (nonatomic, strong) NSArray *attributes;

- (id)initWithTestData;
- (id)initWithDataFilename:(NSString*)filename;
- (void)processDustParticles;
- (NSMutableArray*)testMagnetModel;
- (NSMutableArray*)testDustModel;

@end
