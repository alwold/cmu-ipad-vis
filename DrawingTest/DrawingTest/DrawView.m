//
//  DrawView.m
//  DrawingTest
//
//  Created by Al Wold on 3/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, nil, 0, 0);
	CGPathAddLineToPoint(path, nil, 100, 0);
	CGPathAddLineToPoint(path, nil, 100, 100);
	CGPathAddLineToPoint(path, nil, 0, 100);
	CGPathCloseSubpath(path);
	CGContextAddPath(ctx, path);
	CGContextStrokePath(ctx);
	CGPathRelease(path);
}

@end
