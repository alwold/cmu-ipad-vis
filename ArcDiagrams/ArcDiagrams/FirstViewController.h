//
//  FirstViewController.h
//  ArcDiagrams
//
//  Created by Al Wold on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *urlField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)loadPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
