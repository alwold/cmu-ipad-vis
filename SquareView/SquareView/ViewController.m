//
//  ViewController.m
//  SquareView
//
//  Created by Al Wold on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController {
	UILabel *mLabel;
	UIView *mSquareView;
}

- (void)loadView {
	CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
	
	self.view = [[UIView alloc] initWithFrame:applicationFrame];
	self.view.backgroundColor = [UIColor whiteColor];
	
	mSquareView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(applicationFrame) / 2 - 50, CGRectGetHeight(applicationFrame) / 2 - 50, 100, 100)];
	mSquareView.backgroundColor = [UIColor redColor];
	
	[self.view addSubview:mSquareView];
	mLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(applicationFrame), 50)];
	[self.view addSubview:mLabel];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	
	CGPoint touchLocation = [touch locationInView:self.view];
	
	if (CGRectContainsPoint(mSquareView.frame, touchLocation)) {
		mLabel.text = @"You touched a rectangle";
	} else {
		mLabel.text = @"You missed the rectangle";
	}
}

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
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
	    return YES;
	}
}

@end
