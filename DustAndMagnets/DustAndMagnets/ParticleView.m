//
//  ParticleView.m
//  DustAndMagnets
//
//  Created by Al Wold on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParticleView.h"

@implementation ParticleView

@synthesize particle;
@synthesize baseColor;
@synthesize effectiveColor;
@synthesize disabledColor;
@synthesize enabled;
@synthesize label;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.baseColor = UIColor.redColor;
        self.disabledColor = [UIColor colorWithRed:1. green:0. blue:0. alpha:0.6];
        self.backgroundColor = self.baseColor;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0., 0., frame.size.width, frame.size.height)];
        self.label.clipsToBounds = NO;
        self.label.textAlignment = UITextAlignmentCenter;
        self.label.textColor = UIColor.whiteColor;
        self.label.backgroundColor = UIColor.clearColor;
        [self addSubview:self.label];
    }
    return self;
}

- (void)updateRendering
{
    self.backgroundColor = self.effectiveColor;
	self.label.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
	[self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)inEnabled
{
    self.particle.enabled = inEnabled;
    [self updateRendering];
}

- (BOOL)enabled
{
    return self.particle.enabled;
}

- (UIColor*)effectiveColor
{
    return self.particle.enabled ? self.baseColor : self.disabledColor;
}

- (void)setTextLabel:(NSString *)text
{
    self.label.text = text;
    CGRect labelFrame = self.label.frame;
    CGSize desiredSize = [text sizeWithFont:self.label.font];
    labelFrame.size = desiredSize;
    self.label.frame = labelFrame;
    self.label.center = self.center;
}


@end
