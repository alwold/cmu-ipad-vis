//
//  ParticleModel.h
//  DustAndMagnets
//
//  Created by Al Wold on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParticleModel : NSObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain, readonly) NSMutableDictionary *strengthByAttribute;
@property (nonatomic, readonly) NSArray *attributes;
@property (nonatomic) double scaleFactor;
@property (nonatomic, assign) BOOL enabled;

- (ParticleModel *)initWithName:(NSString *)name strengthByAttribute:(NSMutableDictionary *)strengthByAttribute;
- (double)strengthForAttribute:(NSString*)attribute;
+ (ParticleModel *)particleModelWithName:(NSString *)name strengthByAttribute:(NSMutableDictionary *)strengthByAttribute;
@end
