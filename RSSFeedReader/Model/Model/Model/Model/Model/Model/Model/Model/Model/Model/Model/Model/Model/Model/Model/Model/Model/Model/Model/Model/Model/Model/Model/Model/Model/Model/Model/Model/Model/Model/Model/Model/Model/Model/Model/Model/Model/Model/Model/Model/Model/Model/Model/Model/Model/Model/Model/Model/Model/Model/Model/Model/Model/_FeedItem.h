// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FeedItem.h instead.

#import <CoreData/CoreData.h>

extern const struct FeedItemAttributes {
	 NSString *itemDate;
	 NSString *itemDetail;
	 NSString *itemGuid;
	 NSString *itemLink;
	 NSString *itemPublicationDate;
	 NSString *itemTitle;
} FeedItemAttributes;

extern const struct FeedItemRelationships {
	 NSString *feedImageRelationship;
	 NSString *feedServerRelationship;
} FeedItemRelationships;

@class FeedImage;
@class FeedServer;

@interface FeedItemID : NSManagedObjectID {}
@end

@interface _FeedItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FeedItemID* objectID;

@property (nonatomic, retain) NSNumber* itemDate;

@property (atomic) double itemDateValue;
- (double)itemDateValue;
- (void)setItemDateValue:(double)value_;

//- (BOOL)validateItemDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* itemDetail;

//- (BOOL)validateItemDetail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* itemGuid;

//- (BOOL)validateItemGuid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* itemLink;

//- (BOOL)validateItemLink:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* itemPublicationDate;

//- (BOOL)validateItemPublicationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* itemTitle;

//- (BOOL)validateItemTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSSet *feedImageRelationship;

- (NSMutableSet*)feedImageRelationshipSet;

@property (nonatomic, retain) FeedServer *feedServerRelationship;

//- (BOOL)validateFeedServerRelationship:(id*)value_ error:(NSError**)error_;

@end

@interface _FeedItem (FeedImageRelationshipCoreDataGeneratedAccessors)
- (void)addFeedImageRelationship:(NSSet*)value_;
- (void)removeFeedImageRelationship:(NSSet*)value_;
- (void)addFeedImageRelationshipObject:(FeedImage*)value_;
- (void)removeFeedImageRelationshipObject:(FeedImage*)value_;

@end

@interface _FeedItem (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveItemDate;
- (void)setPrimitiveItemDate:(NSNumber*)value;

- (double)primitiveItemDateValue;
- (void)setPrimitiveItemDateValue:(double)value_;

- (NSString*)primitiveItemDetail;
- (void)setPrimitiveItemDetail:(NSString*)value;

- (NSString*)primitiveItemGuid;
- (void)setPrimitiveItemGuid:(NSString*)value;

- (NSString*)primitiveItemLink;
- (void)setPrimitiveItemLink:(NSString*)value;

- (NSString*)primitiveItemPublicationDate;
- (void)setPrimitiveItemPublicationDate:(NSString*)value;

- (NSString*)primitiveItemTitle;
- (void)setPrimitiveItemTitle:(NSString*)value;

- (NSMutableSet*)primitiveFeedImageRelationship;
- (void)setPrimitiveFeedImageRelationship:(NSMutableSet*)value;

- (FeedServer*)primitiveFeedServerRelationship;
- (void)setPrimitiveFeedServerRelationship:(FeedServer*)value;

@end
