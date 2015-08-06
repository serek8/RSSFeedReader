//
//  AnyImageDisplayOperation.m
//  RSSFeedReader
//
//  Created by Jan Seredynski on 04/08/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "AnyImageDisplayOperation.h"



@interface AnyImageDisplayOperation()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) NSString *internetPath;
@property (nonatomic, copy) compBlock block;
@property(nonatomic, retain) UIImage *image;

@end


@implementation AnyImageDisplayOperation

-(void)dealloc
{
    self.image = nil;
    self.imageView = nil;
    self.internetPath = nil;
    self.block = nil;
    [super dealloc];
}


-(instancetype)initWithInternetPath:(NSString*)internetPath
                withCopletionBlock:(compBlock)completionBlock
{
    self = [super init];
    if(!self) return nil;
    self.block = completionBlock;
    self.internetPath = internetPath;
    return self;
    
}

-(void)main
{
    
    [ImageDisplayManager downloadItemImageWithInternetPath:self.internetPath
                                      withCopmpletionBlock:^(NSData *imageData)
    {
        self.image = [UIImage imageWithData:imageData];
        self.block(self.image);
    }];
    
}


@end
