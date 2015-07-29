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
    
    NSString* path = [NSHomeDirectory() stringByAppendingString:
                      [NSString stringWithFormat:@"/Library/Caches/Images/%@",
                       [self.serverImageUrl md5]]];
    
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
            NSData* imgData =[NSData dataWithContentsOfURL: [NSURL URLWithString:self.serverImageUrl]];
            [imgData writeToFile:path
                      atomically:YES];
        }
    }
    
    // Now the image must be in core data so we fetch it
    return [NSData dataWithContentsOfURL: [NSURL URLWithString:path]];
}


@end
