// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FeedItem.m instead.

#import "_FeedItem.h"

const struct FeedItemAttributes FeedItemAttributes = {
	.itemDate = @"itemDate",
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

	if ([key isEqualToString:@"itemDateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"itemDate"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic itemDate;

- (double)itemDateValue {
	NSNumber *result = [self itemDate];
	return [result doubleValue];
}

- (void)setItemDateValue:(double)value_ {
	[self setItemDate:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveItemDateValue {
	NSNumber *result = [self primitiveItemDate];
	return [result doubleValue];
}

- (void)setPrimitiveItemDateValue:(double)value_ {
	[self setPrimitiveItemDate:[NSNumber numberWithDouble:value_]];
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

