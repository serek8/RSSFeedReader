//
//  ParserManager.h
//  RSSReader
//
//  Created by Jan Seredynski on 28/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserManager : NSObject

-(void)parse: (NSString*) url;
+(instancetype)sharedInstance;

@end
