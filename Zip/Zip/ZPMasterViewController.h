//
//  ZPMasterViewController.h
//  Zip
//
//  Created by Al Wold on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZPDetailViewController;

@interface ZPMasterViewController : UITableViewController

@property (strong, nonatomic) ZPDetailViewController *detailViewController;
@property (strong, nonatomic) NSDictionary *statesAndZipsDictionary;

@end
