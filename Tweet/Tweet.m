//
//  Tweet.m
//  Tweet
//
//  Created by Al Wold on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet
@synthesize contents=_contents;
@synthesize latitude=_latitude;
@synthesize longitude=_longitude;
@synthesize timestamp=_timestamp;

- (id) initWithContents:(NSString*) contents
andLatitude:(float) latitude
andLongitude:(float) longitude
andTimestamp:(NSDate*) timestamp {
	if (self = [super init]) {
		if (contents.length > 140) {
			return nil;
		}
		_contents = contents;
		_latitude = latitude;
		_longitude = longitude;
		_timestamp = timestamp;
	}
	return self;
}

- (id) initWithContents:(NSString *) contents {
	return [self initWithContents:contents andLatitude:0.0f andLongitude:0.0f andTimestamp:[[NSDate alloc] init]];
}

- (void) setContents:(NSString *)contents {
	if (contents.length <= 140) {
		_contents = contents;
	}
}

- (void) setLatitude:(float) latitude {
	if (latitude >= -90.0f && latitude <= 90.0f) {
		_latitude = latitude;
	}
}

- (void) setLongitude:(float) longitude {
	if (longitude >= -180.0f && longitude <= 180.0f) {
		_longitude = longitude;
	}
}
@end
