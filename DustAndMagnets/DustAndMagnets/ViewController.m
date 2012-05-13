//
//  ViewController.m
//  DustAndMagnets
//
//  Created by Al Wold on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "MagnetView.h"
#import "DustView.h"
#import "ParticleModel.h"
#import "ViewShaker.h"

#define MAGNET_SIZE 50
#define DUST_SIZE 10
#define MAGNET_LAYOUT_CENTER_X 200
#define MAGNET_LAYOUT_CENTER_Y 200
#define MAGNET_LAYOUT_RADIUS 100
#define DUST_LAYOUT_CENTER_X 200
#define DUST_LAYOUT_CENTER_Y 500
#define DUST_LAYOUT_RADIUS 100.
#define DUST_MIN_RADIUS 10.
#define DUST_MAX_RADIUS 40.
#define MAX_ZOOM_SCALE 4.

@interface ViewController () 

@property (nonatomic, retain) DustView *selectedDust;
@property (nonatomic, strong) MagnetView *selectedMagnet;
@property (nonatomic, assign) CGRect dustDataTableDesiredFrame;
@property (nonatomic, assign) CGRect nativeBoardFrame;
@property (nonatomic, assign) CGFloat boardScale;

@end

@implementation ViewController

@synthesize boardView;
@synthesize physicsEngine;
@synthesize dustLabel;
@synthesize dustDataTable;
@synthesize dustDisplay;
@synthesize selectedDust;
@synthesize selectedMagnet;
@synthesize dustDataTableDesiredFrame;
@synthesize dustViews;
@synthesize magnitudeSlider;
@synthesize repulsionSlider;
@synthesize repulsionMinLabel;
@synthesize repulsionMaxLabel;
@synthesize magnetLabel;
@synthesize radiusAttribute;
@synthesize boardScrollView;
@synthesize nativeBoardFrame;
@synthesize boardScale;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self initializeModel];

	self.nativeBoardFrame = self.boardView.frame;
    self.boardScale = 1.;

	magnetViewForParticle = [NSMutableDictionary dictionary];
	dustViewForParticle = [NSMutableDictionary dictionary];
	
	self.boardView.clipsToBounds = YES;
	
	[particleSystem.magnetParticles enumerateObjectsUsingBlock:^(ParticleModel *magnet, NSUInteger idx, BOOL *stop) {
		MagnetView *magnetView = [[MagnetView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
		magnetView.particle = magnet;
		[magnetView setTextLabel:magnet.name];
		[magnetViewForParticle setValue:magnetView forKey:magnet.name];
		[self.boardView addSubview:magnetView];
		
		[magnetView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMagnetTap:)]];
		UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMagnetDoubleTap:)];
		doubleTap.numberOfTapsRequired = 2;
		[magnetView addGestureRecognizer:doubleTap];
		[magnetView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMagnetPan:)]];
	}];
	
	self.dustViews = [NSMutableArray arrayWithCapacity:particleSystem.dustParticles.count];
	[particleSystem.dustParticles enumerateObjectsUsingBlock:^(ParticleModel *dust, NSUInteger idx, BOOL *stop) {
		DustView *dustView = [[DustView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
		dustView.particle = dust;
		[dustView setTextLabel:dust.name];
		dustView.label.hidden = YES;
		[dustViewForParticle setValue:dustView forKey:dust.name];
		[self.boardView addSubview:dustView];
		[self.dustViews addObject:dustView];
		
		[dustView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDustTap:)]];
	}];
	
	[self initialLayout];
	[self initialPositioning];
	dustDataTable.dataSource = self;
}

- (void)viewDidUnload
{
	[self setDustDataTable:nil];
	[self setDustLabel:nil];
	[self setDustDisplay:nil];
	[self setMagnitudeSlider:nil];
	[self setRepulsionSlider:nil];
	[self setRepulsionMinLabel:nil];
	[self setRepulsionMaxLabel:nil];
	[self setMagnetLabel:nil];
	[self setBoardScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)initializeModel
{
	if (!particleSystem) {
        particleSystem = [[ParticleSystem alloc] initWithDataFilename:@"CerealData"];
		self.physicsEngine = [[PhysicsEngine alloc] init];
        self.physicsEngine.targetMins = particleSystem.dustMin;
        self.physicsEngine.targetMaxes = particleSystem.dustMax;
        self.physicsEngine.targetThresholds = particleSystem.dustThreshold;
    }
}

- (void)initialLayout
{
	// Initial sizes.
    [particleSystem.magnetParticles enumerateObjectsUsingBlock:^(ParticleModel *magnet, NSUInteger magnetIdx, BOOL *stop) {
        UIView *view = [magnetViewForParticle objectForKey:magnet.name];
        view.frame = CGRectMake(0, 0, MAGNET_SIZE, MAGNET_SIZE);
    }];
	
    [particleSystem.dustParticles enumerateObjectsUsingBlock:^(ParticleModel *dust, NSUInteger dustIdx, BOOL *stop) {
        UIView *view = [dustViewForParticle objectForKey:dust.name];
        view.frame = CGRectMake(0, 0, DUST_SIZE, DUST_SIZE);
    }];

}

- (void)initialPositioning
{
	CGPoint magnetsCenter = CGPointMake(self.boardScale * MAGNET_LAYOUT_CENTER_X, self.boardScale * MAGNET_LAYOUT_CENTER_Y);
	NSUInteger magnetCount = particleSystem.magnetParticles.count;
	[particleSystem.magnetParticles enumerateObjectsUsingBlock:^(ParticleModel *magnet, NSUInteger idx, BOOL *stop) {
		UIView *view = [magnetViewForParticle objectForKey:magnet.name];
		view.center = [self pointOnCircleAtCenter:magnetsCenter radius:MAGNET_LAYOUT_RADIUS theta:(2*M_PI*idx/magnetCount)];
	}];
	
	CGPoint dustCenter = CGPointMake(self.boardScale * DUST_LAYOUT_CENTER_X, self.boardScale * DUST_LAYOUT_CENTER_Y);
	NSUInteger dustCount = particleSystem.dustParticles.count;
	[particleSystem.dustParticles enumerateObjectsUsingBlock:^(ParticleModel *dust, NSUInteger idx, BOOL *stop) {
		UIView *view = [dustViewForParticle objectForKey:dust.name];
		view.center = [self pointOnCircleAtCenter:dustCenter radius:DUST_LAYOUT_RADIUS theta:(2*M_PI*idx/dustCount)];
	}];
}

- (CGPoint)pointOnCircleAtCenter:(CGPoint)circleCenter radius:(CGFloat)radius theta:(float)theta
{
	CGPoint position = CGPointMake(circleCenter.x + radius * cos(theta), circleCenter.y + radius * sin(theta));
    return position;
}

- (void)handleMagnetPan:(UIPanGestureRecognizer*)panGR
{
	if (panGR.state == UIGestureRecognizerStateBegan || panGR.state == UIGestureRecognizerStateChanged) {
		ParticleView *view = (ParticleView *)panGR.view;
		CGPoint translation = [panGR translationInView:view.superview];
		CGPoint newCenter = CGPointMake(view.center.x + translation.x, view.center.y + translation.y);
		newCenter = [self clampToView:newCenter];
		[view setCenter:newCenter];
		[panGR setTranslation:CGPointZero inView:view.superview];
		
		if (view.enabled) {
			float duration = sqrt(pow(translation.x, 2) + pow(translation.y, 2));
			[self stepWithDuration:duration];
		}
	}
}

- (IBAction)handleResetButton:(id)sender {
	[UIView animateWithDuration:1 animations:^() {
		[self initialPositioning];
	}];
}

- (void)handleMagnetDoubleTap:(UITapGestureRecognizer*)tapGR
{
	NSLog(@"magnet double tapped");
	MagnetView *magnetView = (MagnetView *)tapGR.view;
	magnetView.enabled = !magnetView.enabled;
	NSLog(@"magnet enabled status: %d", magnetView.enabled);
}

- (void)handleMagnetTap:(UITapGestureRecognizer*)tapGR
{
	NSLog(@"magnet tapped");
	MagnetView *magnetView = (MagnetView *)tapGR.view;
	self.selectedMagnet = magnetView;
	[self reloadMagnetDisplay];
}

- (CGPoint)clampToView:(CGPoint)point
{
    CGPoint result = point;
    CGSize limits = self.boardView.bounds.size;
    result.x = MIN(limits.width, MAX(0, point.x));
    result.y = MIN(limits.height, MAX(0, point.y));
    return result;
}

- (void)stepWithDuration:(double)duration
{
	NSLog(@"stepWithDuration");
	double durationScale = 0.0001;
	double scaledDuration = durationScale * duration;
	for (ParticleModel *dust in particleSystem.dustParticles) {
		DustView *dustView = [dustViewForParticle objectForKey:dust.name];
		CGPoint dustCenter = dustView.center;
		
		CGPoint delta = CGPointZero;
		for (ParticleModel *magnet in particleSystem.magnetParticles) {
			MagnetView *magnetView = [magnetViewForParticle objectForKey:magnet.name];
			CGPoint magnetCenter = magnetView.center;
			double attraction = [self.physicsEngine attractionBetweenSource:magnet andTarget:dust];
			delta = CGPointMake(delta.x + attraction * (magnetCenter.x - dustCenter.x),
								delta.y + attraction * (magnetCenter.y - dustCenter.y));
		}
		
		dustCenter = CGPointMake(dustCenter.x + scaledDuration * delta.x, dustCenter.y + scaledDuration * delta.y);
		dustCenter = [self clampToView:dustCenter];
		dustView.center = dustCenter;
	}
}

- (void)handleDustTap:(UITapGestureRecognizer*)tapGR
{
	NSLog(@"handleDustTap");
	DustView *dustView = (DustView*)tapGR.view;
	[self selectDust:dustView];
}

- (void)resizeDustTable
{
	
}

- (void)selectDust:(DustView*)dustView
{
	NSLog(@"selectDust");
	BOOL tappedSelected = self.selectedDust != nil && dustView == self.selectedDust;
	if (tappedSelected || dustView == nil) {
		[self.selectedDust highlight:NO];
		self.selectedDust= nil;
		self.dustDisplay.hidden = YES;
	} else {
		[self.selectedDust highlight:NO];
		self.selectedDust = dustView;
		[self.selectedDust highlight:YES];
		NSLog(@"reload data");
		[self.dustDataTable reloadData];
		
		[self performSelector:@selector(resizeDustTable) withObject:self afterDelay:0.];
		self.dustLabel.text = dustView.particle.name;
		self.dustDisplay.hidden = NO;
	}
	NSLog(@"selectDust done");
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
	NSLog(@"numberOfRows");
	NSInteger numberOfRowsInSection = 0;
	if (self.selectedDust) {
		NSLog(@"a dust is selected");
		ParticleModel *dustModel = self.selectedDust.particle;
		numberOfRowsInSection = dustModel.strengthByAttribute.count;
		NSLog(@"%d rows", numberOfRowsInSection);
	}
	return numberOfRowsInSection;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"cellForRow %@", indexPath);
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
	if (self.selectedDust) {
		if (cell == nil) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];
		}
		ParticleModel *dustModel = self.selectedDust.particle;
		NSArray *attributes = dustModel.attributes;
		NSLog(@"attributes size: %d", attributes.count);
		NSString *attribute =[attributes objectAtIndex:indexPath.row];
		NSString *strength = @"";
		NSLog(@"attribute: %@", attribute);
		if (attribute) {
			NSNumber *valueNum = [dustModel.strengthByAttribute objectForKey:attribute];
			strength = [NSString stringWithFormat:@"%0.2f", valueNum.doubleValue];
			
			cell.textLabel.text = attribute;
			cell.detailTextLabel.text = strength;
		}
	} else {
		NSLog(@"attempted to create data display for %d when no dust selected", indexPath.row);
		cell.textLabel.text = @"?";
		cell.detailTextLabel.text = @"?";
	}
	
	return cell;
}

- (void)shakeDustUntilDoneWithMaxIterationCount:(NSUInteger)maxIterationCount
{
	ViewShaker *shaker = [[ViewShaker alloc] initUsingSquareBounds:YES];

	BOOL done = NO;
	for (NSUInteger iteration = 0; !done && iteration < maxIterationCount; ++iteration) {
		BOOL changed = [shaker shakeViews:self.dustViews withinFrame:self.boardView.frame];
		done = !changed;
	}
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent*)event
{
	if (event.type == UIEventSubtypeMotionShake) {
		[self shakeDustUntilDoneWithMaxIterationCount:100];
	}
}

- (BOOL)canBecomeFirstResponder
{
	return YES;
}

- (IBAction)shakeOnce:(id)sender {
	[self shakeDustUntilDoneWithMaxIterationCount:1];
}
- (IBAction)handleMagnetRepulsionChanged:(UISlider*)slider {
    MagnetView *magnetView = self.selectedMagnet;
    ParticleModel *magnetModel = magnetView.particle;
	
    NSArray *magnetAttributes = [magnetModel attributes];
    if (magnetAttributes.count > 0) {  // should be 1
        NSString *attribute = (NSString*)[magnetAttributes objectAtIndex:0];
        NSNumber *thresholdStrengthNum = [NSNumber numberWithDouble:slider.value];
        [particleSystem.dustThreshold.strengthByAttribute setObject:thresholdStrengthNum forKey:attribute];
    }
}
- (IBAction)handleMagnetMagnitudeChanged:(UISlider*)slider {
    self.selectedMagnet.particle.scaleFactor = slider.value;
}

- (void)reloadMagnetDisplay
{
	if (self.selectedMagnet) {
		MagnetView *magnetView = self.selectedMagnet;
		ParticleModel *magnetModel = magnetView.particle;
		
		self.magnetLabel.text = magnetModel.name;
		self.magnitudeSlider.value = magnetModel.scaleFactor;
		
		NSArray *magnetAttributes = [magnetModel attributes];
		if (magnetAttributes.count > 0) {
			NSString *attribute = (NSString*)[magnetAttributes objectAtIndex:0];
			
			double minStrength = [particleSystem.dustMin strengthForAttribute:attribute];
			double maxStrength = [particleSystem.dustMax strengthForAttribute:attribute];
			double thresholdStrength = [particleSystem.dustThreshold strengthForAttribute:attribute];
			
			self.repulsionSlider.minimumValue = minStrength;
			self.repulsionSlider.maximumValue = maxStrength;
			self.repulsionSlider.value = thresholdStrength;
			
			self.repulsionMinLabel.text = [NSString stringWithFormat:@"%3.1f", minStrength];
			self.repulsionMaxLabel.text = [NSString stringWithFormat:@"%3.1f", maxStrength];
		}
	}
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return 1 + particleSystem.knownAttributes.count;
}

- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	if (row == 0) {
		self.radiusAttribute = nil;
	} else {
		self.radiusAttribute = [particleSystem.attributes objectAtIndex:row-1];
	}
	[self updateDustRadii];
}

- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (row == 0) {
		return @"(same)";
	} else {
		return [particleSystem.attributes objectAtIndex:row-1];
	}
}

- (void)updateDustRadii
{
	[UIView animateWithDuration:0.5 animations:^() {
		NSString *attribute = self.radiusAttribute;
		
		double minStrength = 0;
		double maxStrength = 0;
		if (attribute) {
			minStrength = [particleSystem.dustMin strengthForAttribute:attribute];
			maxStrength = [particleSystem.dustMax strengthForAttribute:attribute];
		}
		
		if (maxStrength > minStrength) {
			[self.dustViews enumerateObjectsUsingBlock:^(DustView* dustView, NSUInteger idx, BOOL *stop) {
				double strength = [dustView.particle strengthForAttribute:attribute];
				double fraction = (strength - minStrength) / (maxStrength - minStrength);
				double diameter = DUST_MIN_RADIUS + fraction * (DUST_MAX_RADIUS - DUST_MIN_RADIUS);
				[dustView setRadius:diameter/2.0];
			}];
		} else {
			[self.dustViews enumerateObjectsUsingBlock:^(DustView *dustView, NSUInteger idx, BOOL *stop) {
				[dustView setRadius:DUST_SIZE/2.0];
			}];
		}
	}];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
	NSLog(@"scrollViewDidEndZooming");
	self.boardView.transform = CGAffineTransformIdentity;
	
	CGRect newFrame = CGRectMake(0, 0, self.boardView.bounds.size.width * scale, self.boardView.bounds.size.height * scale);
	self.boardView.frame = newFrame;
	
	self.boardScale *= scale;
	self.boardScrollView.contentSize = self.boardView.bounds.size;
	self.boardScrollView.zoomScale = 1.0;
	self.boardScrollView.minimumZoomScale = self.nativeBoardFrame.size.height / self.boardView.bounds.size.height;
	self.boardScrollView.maximumZoomScale = MAX_ZOOM_SCALE  / self.boardScale;
	
	NSLog(@"scaling by %f", scale);
	[[magnetViewForParticle allValues] enumerateObjectsUsingBlock:^(MagnetView * magnetView, NSUInteger idx, BOOL *stop) {
		[self scaleView:magnetView forScale:scale];
		[magnetView updateRendering];
	}];
	
	[self.dustViews enumerateObjectsUsingBlock:^(DustView *dustView, NSUInteger idx, BOOL *stop) {
		[self scaleView:dustView forScale:scale];
		[dustView updateRendering];
	}];
}

- (void)scaleView:(UIView *)view forScale:(float)scale
{
	CGRect oldFrame = view.frame;
	CGRect newFrame = CGRectMake(oldFrame.origin.x * scale, oldFrame.origin.y * scale, oldFrame.size.width * scale, oldFrame.size.height * scale);
	view.frame = newFrame;
}

@end
