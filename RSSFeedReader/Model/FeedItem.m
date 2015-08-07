#import "FeedItem.h"
#import "FeedImage.h"
#import "NSString+MD5.h"
#import "FeedServer.h"

@interface FeedItem ()

// Private interface goes here.

@end

@implementation FeedItem

// Custom logic goes here.

+(BOOL) isSetItemWithGUID :(NSString*)guid
                 inContext: (NSManagedObjectContext*) context;
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:super.entityName];
    NSPredicate *searchFilter =  [NSPredicate predicateWithFormat:@"%K == %@",
                                  FeedItemAttributes.itemGuid,
                                  [guid md5]];
    [request setPredicate:searchFilter];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if(!results)
    {
     NSLog(@"%@",error);
    }
    // if such item exits in database
    if(results.count) return YES;
    return false;
}


+(void) deleteOldFeedItemsInContext: (NSManagedObjectContext*) context;
{
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *threeDaysAgoDate;
    threeDaysAgoDate = [calendar dateByAddingUnit:NSCalendarUnitDay
                                             value:-3
                                            toDate:[NSDate date]
                                           options:kNilOptions];
    
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"%K < %@",
                              FeedItemAttributes.itemPublicationDate,
                              threeDaysAgoDate ];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:super.entityName];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if(!results) NSLog(@"%@",error);
    for(int i=0; i<results.count; i++)
    {
        for(FeedImage *feedImage in ((FeedItem*)[results objectAtIndex:i]).feedImageRelationship)
        {
            if([[NSFileManager defaultManager] fileExistsAtPath:feedImage.imageUrl])
            {
                NSError *error;
                
                if(![[NSFileManager defaultManager] removeItemAtPath:feedImage.imageUrl error:&error]) NSLog(@"%@",error);
                
            }

        }
                [context deleteObject: ((FeedItem*)[results objectAtIndex:i])];
    }

}

-(NSString*) findIconInternetPath
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
        return [self.feedServerRelationship findServerIconInternetPath];
    }
    
    return ((FeedImage*)[icons objectAtIndex:iconID]).imageUrl;
    
}






-(NSString*) findImageInternetPath
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
    if(iconID == -1)
    {
        return [self findIconInternetPath];
    }
    return ((FeedImage*)[icons objectAtIndex:iconID]).imageUrl;
}




@end
