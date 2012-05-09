//
//  ParticleView.h
//  DustAndMagnets
//
//  Created by Al Wold on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParticleModel.h"

@interface ParticleView : UIView

@property (nonatomic, retain) ParticleModel *particle;
@property (nonatomic, retain) UIColor *baseColor;
@property (nonatomic, retain) UIColor *disabledColor;
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, readonly) UIColor *effectiveColor;
@property (nonatomic, retain) UILabel *label;

- (void)updateRendering;
- (void)setTextLabel:(NSString *)text;

@end
