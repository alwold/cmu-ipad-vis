//
//  ViewController.h
//  DustAndMagnets
//
//  Created by Al Wold on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParticleSystem.h"
#import "PhysicsEngine.h"

@interface ViewController : UIViewController <UITableViewDataSource, UIPickerViewDataSource>
{
	ParticleSystem *particleSystem;
	
	UIView *boardView;
	NSMutableDictionary *magnetViewForParticle;
	NSMutableDictionary *dustViewForParticle;
}

@property (nonatomic, retain) IBOutlet UIView *boardView;
@property (nonatomic, retain) PhysicsEngine *physicsEngine;
@property (weak, nonatomic) IBOutlet UILabel *dustLabel;
@property (weak, nonatomic) IBOutlet UITableView *dustDataTable;
@property (weak, nonatomic) IBOutlet UIView *dustDisplay;
@property (nonatomic, strong) NSMutableArray *dustViews;
@property (weak, nonatomic) IBOutlet UISlider *magnitudeSlider;
@property (weak, nonatomic) IBOutlet UISlider *repulsionSlider;
@property (weak, nonatomic) IBOutlet UILabel *repulsionMinLabel;
@property (weak, nonatomic) IBOutlet UILabel *repulsionMaxLabel;
@property (weak, nonatomic) IBOutlet UILabel *magnetLabel;
@property (nonatomic, strong) NSString *radiusAttribute;

- (void)initializeModel;
- (void)initialLayout;
- (void)handleMagnetPan:(UIPanGestureRecognizer*)panGR;
- (IBAction)handleResetButton:(id)sender;
@end
