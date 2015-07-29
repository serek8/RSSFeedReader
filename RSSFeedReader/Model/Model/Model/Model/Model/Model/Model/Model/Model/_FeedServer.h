// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FeedServer.h instead.

#import <CoreData/CoreData.h>

extern const struct FeedServerAttributes {
	 NSString *serverImageUrl;
	 NSString *serverName;
	 NSString *serverUrl;
} FeedServerAttributes;

extern const struct FeedServerRelationships {
	 NSString *feedItemRelationship;
} FeedServerRelationships;

@class FeedItem;

@interface FeedServerID : NSManagedObjectID {}
@end

@interface _FeedServer : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FeedServerID* objectID;

@property (nonatomic, retain) NSString* serverImageUrl;

//- (BOOL)validateServerImageUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* serverName;

//- (BOOL)validateServerName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* serverUrl;

//- (BOOL)validateServerUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSSet *feedItemRelationship;

- (NSMutableSet*)feedItemRelationshipSet;

@end

@interface _FeedServer (FeedItemRelationshipCoreDataGeneratedAccessors)
- (void)addFeedItemRelationship:(NSSet*)value_;
- (void)removeFeedItemRelationship:(NSSet*)value_;
- (void)addFeedItemRelationshipObject:(FeedItem*)value_;
- (void)removeFeedItemRelationshipObject:(FeedItem*)value_;

@end

@interface _FeedServer (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveServerImageUrl;
- (void)setPrimitiveServerImageUrl:(NSString*)value;

- (NSString*)primitiveServerName;
- (void)setPrimitiveServerName:(NSString*)value;

- (NSString*)primitiveServerUrl;
- (void)setPrimitiveServerUrl:(NSString*)value;

- (NSMutableSet*)primitiveFeedItemRelationship;
- (void)setPrimitiveFeedItemRelationship:(NSMutableSet*)value;

@end
