//
//  ViewController.h
//  LayerTest
//
//  Created by Al Wold on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) CALayer *layer;

- (IBAction)go:(id)sender;
- (IBAction)fancier:(id)sender;

@end
