//
//  WebViewController.h
//  RSSReader
//
//  Created by Jan Seredynski on 26/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *url;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;


@end
