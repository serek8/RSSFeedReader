//
//  Stack.h
//  RSSReader
//
//  Created by Jan Seredynski on 21/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

- (id)showTop;
- (void)push:(id)anObject;
- (id)pop;
- (void)clear;
- (void)printFromBottom;

@end