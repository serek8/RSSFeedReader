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

//+(NSArray*) getAllItemsWithSeverPrimaryKey :(NSInteger*)primaryKey
//                                  inContext: (NSManagedObjectContext*) context;
//{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:super.entityName];
//    NSPredicate *searchFilter =  [NSPredicate predicateWithFormat:@"server == %d", primaryKey];
//    [request setPredicate:searchFilter];
//    NSError *error = nil;
//    NSArray *results = [context executeFetchRequest:request error:&error];
//    return results;
//    
//}
//+(void) deleteOldItems :(NSInteger*)primaryKey
//                                  inContext: (NSManagedObjectContext*) context;
//{
//    - (NSPredicate *) predicateToRetrieveEventsForDate:(NSDate *)aDate {
//        
//        // start by retrieving day, weekday, month and year components for the given day
//        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//        NSDateComponents *todayComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:aDate];
//        NSInteger theDay = [todayComponents day];
//        NSInteger theMonth = [todayComponents month];
//        NSInteger theYear = [todayComponents year];
//        
//        // now build a NSDate object for the input date using these components
//        NSDateComponents *components = [[NSDateComponents alloc] init];
//        [components setDay:theDay];
//        [components setMonth:theMonth];
//        [components setYear:theYear];
//        NSDate *thisDate = [gregorian dateFromComponents:components];
//        [components release];
//        
//        // build a NSDate object for aDate next day
//        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
//        [offsetComponents setDay:1];
//        NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:thisDate options:0];
//        [offsetComponents release];
//        
//        [gregorian release];
//        
//        
//        // build the predicate
//        NSPredicate *predicate = [NSPredicate predicateWithFormat: @"startDate < %@ && endDate > %@", nextDate, thisDate];
//        
//        return predicate;
//        
//    }
//    
//    
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:super.entityName];
//    NSPredicate *searchFilter =  [NSPredicate predicateWithFormat:@"itemPublicationDate == %d", primaryKey];
//    [request setPredicate:searchFilter];
//    NSError *error = nil;
//    NSArray *results = [context executeFetchRequest:request error:&error];
//    return results;
//
//}




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
    
    
    NSString* path = [NSHomeDirectory() stringByAppendingString:
                      [NSString stringWithFormat:@"/Library/Caches/Images/%@",
                       [((FeedImage*)[icons objectAtIndex:iconID]).imageUrl md5]]];
    
    //if file is not yet downloaded from the internet we fetch it and store in core data
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:
         [NSHomeDirectory() stringByAppendingString: @"/Library/Caches/Images"]
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
        
        BOOL ok = [[NSFileManager defaultManager]
                   createFileAtPath: path
                   contents:nil
                   attributes:nil];
        if (!ok)
        {
            NSLog(@"Error creating file %@", path);
        }
        else
        {
            NSData* imgData =  [NSData dataWithContentsOfURL:
                                                         [NSURL URLWithString:((FeedImage*)[icons objectAtIndex:iconID]).imageUrl]];
            [imgData writeToFile:path
                      atomically:YES];
        }
    }
    
    // Now the image must be in core data so we fetch it
    
    NSData* retData = [NSData dataWithContentsOfFile:path];
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
    
    
    NSString* path = [NSHomeDirectory() stringByAppendingString:
                      [NSString stringWithFormat:@"/Library/Caches/Images/%@",
                       [((FeedImage*)[icons objectAtIndex:iconID]).imageUrl md5]]];
    
    //if file is not yet downloaded from the internet we fetch it and store in core data
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:
         [NSHomeDirectory() stringByAppendingString: @"/Library/Caches/Images"]
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
        
        BOOL ok = [[NSFileManager defaultManager]
                   createFileAtPath: path
                   contents:nil
                   attributes:nil];
        if (!ok)
        {
            NSLog(@"Error creating file %@", path);
        }
        else
        {
            NSData* imgData = [NSData dataWithContentsOfURL:                                                         [NSURL URLWithString:((FeedImage*)[icons objectAtIndex:iconID]).imageUrl]];
                    [imgData writeToFile:path atomically:YES];
        }
    }
    
    // Now the image must be in core data so we fetch it
    NSData* retData = [NSData dataWithContentsOfFile:path];
    return retData;
}

@end
