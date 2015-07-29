// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FeedImage.h instead.

#import <CoreData/CoreData.h>

extern const struct FeedImageAttributes {
	 NSString *imageHeight;
	 NSString *imageUrl;
	 NSString *imageWidth;
} FeedImageAttributes;

extern const struct FeedImageRelationships {
	 NSString *feedItemRelationship;
} FeedImageRelationships;

@class FeedItem;

@interface FeedImageID : NSManagedObjectID {}
@end

@interface _FeedImage : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FeedImageID* objectID;

@property (nonatomic, retain) NSNumber* imageHeight;

@property (atomic) int32_t imageHeightValue;
- (int32_t)imageHeightValue;
- (void)setImageHeightValue:(int32_t)value_;

//- (BOOL)validateImageHeight:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* imageUrl;

//- (BOOL)validateImageUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSNumber* imageWidth;

@property (atomic) int32_t imageWidthValue;
- (int32_t)imageWidthValue;
- (void)setImageWidthValue:(int32_t)value_;

//- (BOOL)validateImageWidth:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) FeedItem *feedItemRelationship;

//- (BOOL)validateFeedItemRelationship:(id*)value_ error:(NSError**)error_;

@end

@interface _FeedImage (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveImageHeight;
- (void)setPrimitiveImageHeight:(NSNumber*)value;

- (int32_t)primitiveImageHeightValue;
- (void)setPrimitiveImageHeightValue:(int32_t)value_;

- (NSString*)primitiveImageUrl;
- (void)setPrimitiveImageUrl:(NSString*)value;

- (NSNumber*)primitiveImageWidth;
- (void)setPrimitiveImageWidth:(NSNumber*)value;

- (int32_t)primitiveImageWidthValue;
- (void)setPrimitiveImageWidthValue:(int32_t)value_;

- (FeedItem*)primitiveFeedItemRelationship;
- (void)setPrimitiveFeedItemRelationship:(FeedItem*)value;

@end
