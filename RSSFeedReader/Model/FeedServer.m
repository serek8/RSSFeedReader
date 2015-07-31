#import "FeedServer.h"

@interface FeedServer ()

// Private interface goes here.

@end

@implementation FeedServer

// Custom logic goes here.

+(FeedServer*) getFeedServerWithURL :(NSString*)url
                   inContext: (NSManagedObjectContext*) context;
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:super.entityName];
    NSPredicate *searchFilter =  [NSPredicate predicateWithFormat:@"serverUrl == %@", url];
    [request setPredicate:searchFilter];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    return results.lastObject;
}

+(BOOL) isSetFeedServer :(FeedServer*)server
           inContext: (NSManagedObjectContext*) context;
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:super.entityName];
    NSPredicate *searchFilter =  [NSPredicate predicateWithFormat:@"itemName == %@", server.serverName];
    [request setPredicate:searchFilter];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if(results.count == 0) // if such server not exits in database
        return NO;
    else
        return YES;
}
-(NSData*) getServerIcon
{
    NSString *str;
    str = [self.serverImageUrl stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString* path = [NSHomeDirectory() stringByAppendingString:
                      [NSString stringWithFormat:@"/Library/Caches/Images/%@",
                       [str md5]]];
    
    //if file is not yet downloaded from the internet we fetch it and store in core data
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        
        NSError *error;
            NSData* imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]
                                  options:NSDataReadingUncached
                                    error:&error];
            //NSData* imgData =[NSData dataWithContentsOfURL: [NSURL URLWithString:str]];
            [imgData writeToFile:path
                      atomically:YES];
        
    }
    
    // Now the image must be in core data so we fetch it
    NSData* retData = [NSData dataWithContentsOfFile:path];
    return retData;
}


@end
