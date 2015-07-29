// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FeedImage.m instead.

#import "_FeedImage.h"

const struct FeedImageAttributes FeedImageAttributes = {
	.imageHeight = @"imageHeight",
	.imageUrl = @"imageUrl",
	.imageWidth = @"imageWidth",
};

const struct FeedImageRelationships FeedImageRelationships = {
	.feedItemRelationship = @"feedItemRelationship",
};

@implementation FeedImageID
@end

@implementation _FeedImage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FeedImage" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FeedImage";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FeedImage" inManagedObjectContext:moc_];
}

- (FeedImageID*)objectID {
	return (FeedImageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"imageHeightValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"imageHeight"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"imageWidthValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"imageWidth"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic imageHeight;

- (int32_t)imageHeightValue {
	NSNumber *result = [self imageHeight];
	return [result intValue];
}

- (void)setImageHeightValue:(int32_t)value_ {
	[self setImageHeight:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveImageHeightValue {
	NSNumber *result = [self primitiveImageHeight];
	return [result intValue];
}

- (void)setPrimitiveImageHeightValue:(int32_t)value_ {
	[self setPrimitiveImageHeight:[NSNumber numberWithInt:value_]];
}

@dynamic imageUrl;

@dynamic imageWidth;

- (int32_t)imageWidthValue {
	NSNumber *result = [self imageWidth];
	return [result intValue];
}

- (void)setImageWidthValue:(int32_t)value_ {
	[self setImageWidth:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveImageWidthValue {
	NSNumber *result = [self primitiveImageWidth];
	return [result intValue];
}

- (void)setPrimitiveImageWidthValue:(int32_t)value_ {
	[self setPrimitiveImageWidth:[NSNumber numberWithInt:value_]];
}

@dynamic feedItemRelationship;

@end

