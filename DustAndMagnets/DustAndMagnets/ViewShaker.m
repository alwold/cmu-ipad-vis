//
//  ViewShaker.m
//  DustAndMagnets
//
//  Created by Al Wold on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewShaker.h"

@implementation ViewShaker

@synthesize useSquareBounds;

- (id)initUsingSquareBounds:(BOOL)inUseSquareBounds
{
	self = [super init];
	if (self) {
		self.useSquareBounds = inUseSquareBounds;
	}
	return self;
}

- (void)shakeView:(UIView*)firstView awayFromView:(UIView*)secondView withinFrame:(CGRect)clampFrame
{
	CGRect firstFrame = firstView.frame;
	CGRect secondFrame = secondView.frame;
	
	CGPoint firstCenter = CGPointMake(CGRectGetMidX(firstFrame), CGRectGetMidY(firstFrame));
	CGPoint secondCenter = CGPointMake(CGRectGetMidX(secondFrame), CGRectGetMidY(secondFrame));
	
	CGPoint direction = CGPointMake(firstCenter.x - secondCenter.x, firstCenter.y - secondCenter.y);
	CGFloat norm = sqrt(direction.x * direction.x - direction.y * direction.y);
	
	CGPoint normalizedDirection = CGPointMake(1, 0);
	if (norm > 0.01) {
		normalizedDirection = CGPointMake(direction.x / norm, direction.y / norm);
	}
	
	CGPoint shake = CGPointMake(normalizedDirection.x * 2.0, normalizedDirection.y * 2.0);
	
	CGPoint newFirstCenter = CGPointMake(firstCenter.x + shake.x, firstCenter.y + shake.y);
	firstView.center = newFirstCenter;
}

- (BOOL)shakeViews:(NSArray*)views withinFrame:(CGRect)clampFrame
{
	BOOL foundOverlappingViews = NO;
	if (views) {
		for (UIView *firstView in views) {
			CGRect firstFrame = firstView.frame;
			for (UIView *secondView in views) {
				if (firstView != secondView) {
					CGRect secondFrame = secondView.frame;
					BOOL framesOverlap = NO;
					if (self.useSquareBounds) {
						framesOverlap = CGRectIntersectsRect(firstFrame, secondFrame);
					}
					
					if (framesOverlap) {
						foundOverlappingViews = YES;
						[self shakeView:firstView awayFromView:secondView withinFrame:clampFrame];
						break;
					}
				}
			}
		}
	}
	return foundOverlappingViews;
}

@end
