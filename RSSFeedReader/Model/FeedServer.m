#import "FeedServer.h"
#import "FeedImage.h"
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

-(NSString*) findServerIconInternetPath
{
    NSString *str;
    str = [self.serverImageUrl stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}

-(NSData*) getServerIcon
{
    NSString *str;
    str = [self.serverImageUrl stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSData* retData =  [ImageDisplayManager downloadItemImageWithInternetPath:str];
    
    return retData;
}


@end
