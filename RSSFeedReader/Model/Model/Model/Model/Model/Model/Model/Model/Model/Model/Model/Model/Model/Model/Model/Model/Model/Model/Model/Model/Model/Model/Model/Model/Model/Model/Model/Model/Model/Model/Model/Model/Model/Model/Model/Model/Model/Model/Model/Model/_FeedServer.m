// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FeedServer.m instead.

#import "_FeedServer.h"

const struct FeedServerAttributes FeedServerAttributes = {
	.serverImageUrl = @"serverImageUrl",
	.serverName = @"serverName",
	.serverUrl = @"serverUrl",
};

const struct FeedServerRelationships FeedServerRelationships = {
	.feedItemRelationship = @"feedItemRelationship",
};

@implementation FeedServerID
@end

@implementation _FeedServer

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FeedServer" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FeedServer";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FeedServer" inManagedObjectContext:moc_];
}

- (FeedServerID*)objectID {
	return (FeedServerID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic serverImageUrl;

@dynamic serverName;

@dynamic serverUrl;

@dynamic feedItemRelationship;

- (NSMutableSet*)feedItemRelationshipSet {
	[self willAccessValueForKey:@"feedItemRelationship"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"feedItemRelationship"];

	[self didAccessValueForKey:@"feedItemRelationship"];
	return result;
}

@end

