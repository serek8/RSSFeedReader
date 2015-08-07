#import "_FeedServer.h"
#import "NSString+MD5.h"
#import "ImageDisplayManager.h"

@interface FeedServer : _FeedServer {}
// Custom logic goes here.



+(FeedServer*) getFeedServerWithURL :(NSString*)url
                   inContext: (NSManagedObjectContext*) context;



-(NSString*) findServerIconInternetPath;

@end
