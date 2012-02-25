//
//  TwitterUser.h
//  Homework4
//
//  Created by Al Wold on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tweet;

@interface TwitterUser : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *tweets;
@end

@interface TwitterUser (CoreDataGeneratedAccessors)

- (void)addTweetsObject:(Tweet *)value;
- (void)removeTweetsObject:(Tweet *)value;
- (void)addTweets:(NSSet *)values;
- (void)removeTweets:(NSSet *)values;

@end
