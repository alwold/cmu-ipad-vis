//
//  FirstViewController.m
//  ArcDiagrams
//
//  Created by Al Wold on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize webView;
@synthesize urlField;
@synthesize activityIndicator;

- (void)viewDidLoad
{
    [super viewDidLoad];
	webView.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setUrlField:nil];
    [self setActivityIndicator:nil];
	[self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)loadPressed:(id)sender {
	NSURL *url = [NSURL URLWithString:urlField.text];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
	[activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	[activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	// TODO signal error
	NSLog(@"error was %@", error);
	[activityIndicator stopAnimating];
}
@end
