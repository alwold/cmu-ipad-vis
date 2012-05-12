//
//  ViewShaker.h
//  DustAndMagnets
//
//  Created by Al Wold on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewShaker : NSObject

@property (nonatomic) BOOL useSquareBounds;

- (id)initUsingSquareBounds:(BOOL)useSquareBounds;
- (BOOL)shakeViews:(NSArray*)views withinFrame:(CGRect)clampFrame;

@end
