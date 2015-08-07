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
    NSPredicate *searchFilter =  [NSPredicate predicateWithFormat:@"%K == %@",FeedServerAttributes.serverUrl, url];
    [request setPredicate:searchFilter];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if(!results) NSLog(@"%@",error);
    return results.lastObject;
}


-(NSString*) findServerIconInternetPath
{
    NSString *str;
    str = [self.serverImageUrl stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}

@end
