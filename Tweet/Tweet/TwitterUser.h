//
//  TwitterUser.h
//  Tweet
//
//  Created by Al Wold on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tweet.h"

@interface TwitterUser : NSObject
@property (readwrite,strong) NSCountedSet* tweets;
@property (readwrite,strong) NSCountedSet* followers;
@property (readwrite,strong) NSCountedSet* following;
- (void) addFollower:(NSString *)follower;
- (void) removeFollower:(NSString *)follower;
- (void) addTweet:(Tweet *)tweet;
@end
