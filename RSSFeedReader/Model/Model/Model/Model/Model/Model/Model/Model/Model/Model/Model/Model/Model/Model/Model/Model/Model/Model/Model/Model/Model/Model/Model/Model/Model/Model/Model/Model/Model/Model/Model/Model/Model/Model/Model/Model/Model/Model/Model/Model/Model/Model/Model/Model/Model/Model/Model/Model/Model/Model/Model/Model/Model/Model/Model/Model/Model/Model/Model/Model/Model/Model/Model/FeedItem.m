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
        return nil;
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
    return [NSData dataWithContentsOfURL: [NSURL URLWithString: path ]];
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
    return [NSData dataWithContentsOfURL: [NSURL URLWithString:path]];
}

@end
