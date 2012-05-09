//
//  ViewController.h
//  DustAndMagnets
//
//  Created by Al Wold on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParticleSystem.h"

@interface ViewController : UIViewController
{
	ParticleSystem *particleSystem;
	
	UIView *boardView;
	NSMutableDictionary *magnetViewForParticle;
	NSMutableDictionary *dustViewForParticle;
}

@property (nonatomic, retain) IBOutlet UIView *boardView;
@end
