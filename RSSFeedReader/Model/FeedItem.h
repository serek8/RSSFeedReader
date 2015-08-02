#import "_FeedItem.h"

@interface FeedItem : _FeedItem {}
// Custom logic goes here.


+(BOOL) isSetItemWithGUID :(NSString*)guid
                 inContext: (NSManagedObjectContext*) context;

-(NSData*) getItemIcon;
-(NSData*) getItemImage;
+(void) deleteOldFeedItemsInContext: (NSManagedObjectContext*) context;
-(NSString*) findIconInternetPath;
-(NSString*) findImageInternetPath;
@end
