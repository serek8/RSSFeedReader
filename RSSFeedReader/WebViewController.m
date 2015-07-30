//
//  WebViewController.m
//  RSSReader
//
//  Created by Jan Seredynski on 26/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>


@end

@implementation WebViewController

- (void)dealloc
{
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.indicator stopAnimating];
}


@end
