//
//  TwitterUser.m
//  Tweet
//
//  Created by Al Wold on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TwitterUser.h"

@implementation TwitterUser
@synthesize tweets=_tweets, followers=_followers, following=_following;
- (id) init {
	if (self = [super init]) {
		_tweets = [[NSCountedSet alloc] init];
		_followers = [[NSCountedSet alloc] init];
		_following = [[NSCountedSet alloc] init];
	}
	return self;
}

- (void) addFollower:(NSString *)follower {
	[_followers addObject:follower];
}

- (void) removeFollower:(NSString *) follower {
	[_followers removeObject:follower];
}

- (void) addTweet:(Tweet *) tweet {
	[_tweets addObject:tweet];
}

@end
