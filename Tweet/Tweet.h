//
//  Tweet.h
//  Tweet
//
//  Created by Al Wold on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject
@property (readwrite,strong,nonatomic) NSString* contents;
@property (readwrite,nonatomic) float latitude;
@property (readwrite,nonatomic) float longitude;
@property (readwrite,strong) NSDate* timestamp;
- (id) initWithContents:(NSString*) contents
			andLatitude:(float) latitude
		   andLongitude:(float) longitude
		   andTimestamp:(NSDate*) timestamp;
- (id) initWithContents:(NSString *) contents;
@end
