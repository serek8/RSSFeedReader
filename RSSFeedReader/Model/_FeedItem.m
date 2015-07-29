// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FeedItem.m instead.

#import "_FeedItem.h"

const struct FeedItemAttributes FeedItemAttributes = {
	.itemDetail = @"itemDetail",
	.itemGuid = @"itemGuid",
	.itemLink = @"itemLink",
	.itemPublicationDate = @"itemPublicationDate",
	.itemTitle = @"itemTitle",
};

const struct FeedItemRelationships FeedItemRelationships = {
	.feedImageRelationship = @"feedImageRelationship",
	.feedServerRelationship = @"feedServerRelationship",
};

@implementation FeedItemID
@end

@implementation _FeedItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FeedItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FeedItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FeedItem" inManagedObjectContext:moc_];
}

- (FeedItemID*)objectID {
	return (FeedItemID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic itemDetail;

@dynamic itemGuid;

@dynamic itemLink;

@dynamic itemPublicationDate;

@dynamic itemTitle;

@dynamic feedImageRelationship;

- (NSMutableSet*)feedImageRelationshipSet {
	[self willAccessValueForKey:@"feedImageRelationship"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"feedImageRelationship"];

	[self didAccessValueForKey:@"feedImageRelationship"];
	return result;
}

@dynamic feedServerRelationship;

@end

