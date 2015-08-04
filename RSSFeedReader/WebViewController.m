//
//  WebViewController.m
//  RSSReader
//
//  Created by Jan Seredynski on 26/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//
#import "MainTableViewController.h"
#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@end

@implementation WebViewController

- (void)dealloc
{
    self.url = nil;
    [_webView release];
    [_indicator release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.delegate=self;
    self.url = [self.url stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.url = [self.url stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSURL *websiteUrl = [NSURL URLWithString:self.url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.webView loadRequest:urlRequest];
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.indicator stopAnimating];
}

@end
