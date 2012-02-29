//
//  AppDelegate.h
//  Homework4
//
//  Created by Al Wold on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (weak, nonatomic) MKMapView *mapView;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSURL *)bundleDatabaseURL;
- (NSURL *)documentDatabaseURL;
- (void)initializeDatabase;
@end
