#import "FeedImage.h"
#import "NSString+MD5.h"

@interface FeedImage ()

// Private interface goes here.

@end

@implementation FeedImage

// Custom logic goes here.
-(NSData*) downloadItemImageWithInternetPath:(NSString*)imageInternetPath
{

    NSString* path = [NSHomeDirectory() stringByAppendingString:
                      [NSString stringWithFormat:@"/Library/Caches/Images/%@",
                       [imageInternetPath md5]]];
    
    //if file is not yet downloaded from the internet we fetch it and store in core data
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        
        
        NSData* imgData =  [NSData dataWithContentsOfURL:
                            [NSURL URLWithString:imageInternetPath]];
        [imgData writeToFile:path
                  atomically:YES];
        
    }
    
    // Now the image must be in core data so we fetch it
    
    NSData* retData = [NSData dataWithContentsOfFile:path];
    return retData;
}
@end
