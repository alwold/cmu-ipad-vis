//
//  Tweet.h
//  Homework5
//
//  Created by Al Wold on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Tweet : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSData * location;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSDate * timestamp;
//@property (nonatomic, retain) NSSet *hashtags;
//@property (nonatomic, retain) NSSet *mentions;
//@property (nonatomic, retain) Tweet *replyTo;
//@property (nonatomic, retain) TwitterUser *user;
@end

@interface Tweet (CoreDataGeneratedAccessors)

//- (void)addHashtagsObject:(HashTag *)value;
//- (void)removeHashtagsObject:(HashTag *)value;
//- (void)addHashtags:(NSSet *)values;
//- (void)removeHashtags:(NSSet *)values;

//- (void)addMentionsObject:(TwitterUser *)value;
//- (void)removeMentionsObject:(TwitterUser *)value;
//- (void)addMentions:(NSSet *)values;
//- (void)removeMentions:(NSSet *)values;

@end
