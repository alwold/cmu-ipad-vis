//
//  ViewController.m
//  LayerTest
//
//  Created by Al Wold on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewController

@synthesize layer;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	layer = [[CALayer alloc] init];
	layer.bounds = CGRectMake(0, 0, 100, 100);
	layer.position = CGPointMake(60, 200);
	layer.backgroundColor = [UIColor redColor].CGColor;
	
	[self.view.layer addSublayer:layer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)go:(id)sender {
	layer.position = CGPointMake(200, 200);
}
- (IBAction)fancier:(id)sender {
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
	animation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
	animation.duration = 1;
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	
	[layer addAnimation:animation forKey:@"position"];
}
@end
