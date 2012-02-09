//
//  TweetTests.m
//  TweetTests
//
//  Created by Al Wold on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TweetTests.h"
#import "Tweet.h"
#import "TwitterUser.h"

@implementation TweetTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testInitializers
{
	Tweet* tweet = [[Tweet alloc] initWithContents:@"Hello world"];
	STAssertNotNil(tweet, @"Tweet was nil!");
	STAssertEquals(@"Hello world", tweet.contents, @"Tweet contents not set properly");
	STAssertEquals(0.0f, tweet.latitude, @"Latitude not zero!");
	STAssertEquals(0.0f, tweet.longitude, @"Longitude not zero!");
	NSDate *date = [[NSDate alloc] init];
	STAssertTrue([tweet.timestamp timeIntervalSinceDate:date] <= 0, @"Timestamp not in past!");
	
	tweet = [[Tweet alloc] initWithContents:@"Hello 2" andLatitude:100.0f andLongitude:100.0f andTimestamp:[[NSDate alloc] initWithTimeIntervalSinceNow:10000]];
	STAssertNotNil(tweet, @"Tweet was nil!");
	STAssertEquals(@"Hello 2", tweet.contents, @"Tweet contents not set properly");
	STAssertEquals(100.0f, tweet.latitude, @"Latitude not right!");
	STAssertEquals(100.0f, tweet.longitude, @"Longitude not right!");
	STAssertTrue([tweet.timestamp timeIntervalSinceDate:date] > 0, @"Timestamp not in future!");
	
	tweet.contents = @"Short and sweet";
	STAssertEquals(@"Short and sweet", tweet.contents, @"Contents not set");
	tweet.contents = @"Four score and seven years ago our fathers brought forth on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal.";
	STAssertEquals(@"Short and sweet", tweet.contents, @"Contents can be set to > 140 chars");
	
	tweet.latitude = 90.0f;
	STAssertEquals(90.0f, tweet.latitude, @"Couldn't set latitude");
	tweet.latitude = 91.0f;
	STAssertEquals(90.0f, tweet.latitude, @"Latitude could be set to invalid value!");
	
	tweet.longitude = 180.0f;
	STAssertEquals(180.0f, tweet.longitude, @"Couldn't set longitude");
	tweet.longitude = 181.0f;
	STAssertEquals(180.0f, tweet.longitude, @"Longitude set to invalid value!");
	
}

- (void)testTwitterUser
{
	TwitterUser* user = [[TwitterUser alloc] init];
	[user addFollower:@"alwold"];
	STAssertEquals([NSNumber numberWithInt:[user.followers countForObject:@"alwold"]], [NSNumber numberWithInt:1], @"User not addded to followers");
	STAssertEquals([NSNumber numberWithInt:[user.followers countForObject:@"bla"]], [NSNumber numberWithInt:0], @"Random user found in followers");
	[user removeFollower:@"alwold"];
	STAssertEquals([NSNumber numberWithInt:[user.followers countForObject:@"alwold"]], [NSNumber numberWithInt:0], @"User not removed from followers");
	
	STAssertEquals((NSUInteger) 0, [user.tweets count], @"Tweets not empty");
	[user addTweet:[[Tweet alloc] initWithContents:@"Hello world"]];
	
	
}

@end
