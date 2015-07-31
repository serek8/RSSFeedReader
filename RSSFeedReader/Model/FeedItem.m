#import "FeedItem.h"
#import "FeedImage.h"
#include "NSString+MD5.h"
#include "FeedServer.h"

@interface FeedItem ()

// Private interface goes here.

@end

@implementation FeedItem

// Custom logic goes here.

+(BOOL) isSetItemWithGUID :(NSString*)guid
                 inContext: (NSManagedObjectContext*) context;
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:super.entityName];
    NSPredicate *searchFilter =  [NSPredicate predicateWithFormat:@"itemGuid == %@", [guid md5]];
    [request setPredicate:searchFilter];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if(results.count == 0) // if such item not exits in database
        return NO;
    else
        return YES;
}


+(void) deleteOldFeedItemsInContext: (NSManagedObjectContext*) context;
{
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *threeDaysAgoDate;
    threeDaysAgoDate = [calendar dateByAddingUnit:NSCalendarUnitDay
                                             value:-3
                                            toDate:[NSDate date]
                                           options:kNilOptions];
    
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"itemPublicationDate < %@", threeDaysAgoDate ];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:super.entityName];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    for(int i=0; i<results.count; i++)
    {
        [context deleteObject: ((FeedItem*)[results objectAtIndex:i])];
    }

}




-(NSData*) getItemIcon
{
    NSArray *icons = self.feedImageRelationship.allObjects;
    int iconID=-1;
    int square=((FeedImage*)[icons firstObject]).imageWidth.intValue *
        ((FeedImage*)[icons firstObject]).imageHeight.intValue;
    // I am looking for the smallest icon
    for (int i=0; i<icons.count; i++)
    {
        if(square <=
           ((FeedImage*)[icons objectAtIndex:i]).imageWidth.intValue *
           ((FeedImage*)[icons objectAtIndex:i]).imageHeight.intValue)
        {
            iconID = i;
            square = ((FeedImage*)[icons objectAtIndex:i]).imageWidth.intValue *
                    ((FeedImage*)[icons objectAtIndex:i]).imageHeight.intValue;
        }
        
    }
    // if article doesn't have any itemImage
    if(iconID == -1)
    {
        NSData* retData = [self.feedServerRelationship getServerIcon];
        return retData;
    }
    NSData* retData = [FeedImage downloadItemImageWithInternetPath:
        ((FeedImage*)[icons objectAtIndex:iconID]).imageUrl];
    
    return retData;
}

//
-(NSData*) getItemImage
{
    NSArray *icons = self.feedImageRelationship.allObjects;
    int iconID=-1;
    int square=((FeedImage*)[icons firstObject]).imageWidth.intValue * ((FeedImage*)[icons firstObject]).imageHeight.intValue;
    // I am looking for the smallest icon
    for (int i=0; i<icons.count; i++)
    {
        if(square >=
           ((FeedImage*)[icons objectAtIndex:i]).imageWidth.intValue *
           ((FeedImage*)[icons objectAtIndex:i]).imageHeight.intValue)
        {
            iconID = i;
            square = ((FeedImage*)[icons objectAtIndex:i]).imageWidth.intValue *
            ((FeedImage*)[icons objectAtIndex:i]).imageHeight.intValue;
        }
        
    }
    // if article doesn't have any image
    if(iconID == -1)
    {
        return [self getItemIcon];
    }
    NSData* retData = [FeedImage downloadItemImageWithInternetPath:
                       ((FeedImage*)[icons objectAtIndex:iconID]).imageUrl];

    return retData;
}

@end
