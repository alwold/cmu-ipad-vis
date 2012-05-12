//
//  DustView.m
//  DustAndMagnets
//
//  Created by Al Wold on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DustView.h"

@implementation DustView

- (void)updateRendering
{
    self.backgroundColor = UIColor.clearColor;
	[self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self updateRendering];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, self.baseColor.CGColor);
	CGContextAddEllipseInRect(context, self.bounds);
	CGContextFillPath(context);
}

@end
