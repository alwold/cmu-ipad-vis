//
//  MagnetView.m
//  DustAndMagnets
//
//  Created by Al Wold on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MagnetView.h"

@implementation MagnetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.baseColor = [UIColor colorWithRed:0.5 green:0.5 blue:1. alpha:1.];
		self.disabledColor = [UIColor colorWithRed:0.5 green:0.5 blue:1. alpha:0.6];
		self.backgroundColor = self.baseColor;
		self.label.textColor = UIColor.whiteColor;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
