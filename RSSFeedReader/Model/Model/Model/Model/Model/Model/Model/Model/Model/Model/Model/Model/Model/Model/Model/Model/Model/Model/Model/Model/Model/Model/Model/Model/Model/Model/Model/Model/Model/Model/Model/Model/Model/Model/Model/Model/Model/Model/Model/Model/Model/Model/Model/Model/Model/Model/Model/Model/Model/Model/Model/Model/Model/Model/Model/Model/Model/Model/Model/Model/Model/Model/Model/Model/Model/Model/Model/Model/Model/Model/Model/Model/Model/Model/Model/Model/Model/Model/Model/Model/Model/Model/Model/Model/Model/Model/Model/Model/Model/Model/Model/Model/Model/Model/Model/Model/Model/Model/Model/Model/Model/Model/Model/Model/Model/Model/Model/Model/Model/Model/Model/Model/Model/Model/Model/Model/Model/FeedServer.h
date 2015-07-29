#import "_FeedServer.h"
#import "NSString+MD5.h"

@interface FeedServer : _FeedServer {}
// Custom logic goes here.

+(BOOL) isSetFeedServer :(FeedServer*)server
           inContext: (NSManagedObjectContext*) context;


+(FeedServer*) getFeedServerWithURL :(NSString*)url
                   inContext: (NSManagedObjectContext*) context;


-(NSData*) getServerIcon;


@end
