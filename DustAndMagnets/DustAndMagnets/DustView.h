//
//  DustView.h
//  DustAndMagnets
//
//  Created by Al Wold on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParticleView.h"

@interface DustView : ParticleView

- (void)highlight:(BOOL)wantsHighlighting;
- (void)setRadius:(CGFloat)radius;
@end
