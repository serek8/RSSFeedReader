//
//  MainTableViewController.h
//  RSSReader
//
//  Created by Jan Seredynski on 23/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "AppDelegate.h"
#import "FeedItem.h"
#import "FeedUITableViewCell.h"
#import "ImageBrowserViewController.h"
#import "SettingsManager.h"
#import "ParserManager.h"
#import "ImageDisplayManager.h"
#import "Reachability.h"
#import "PopoverViewController.h"

@interface MainTableViewController : UITableViewController

-(void)hidePopover;

@end
