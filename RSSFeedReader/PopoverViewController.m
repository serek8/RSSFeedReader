//
//  popoverViewController.m
//  RSSFeedReader
//
//  Created by Jan Seredynski on 03/08/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "PopoverViewController.h"
#import "MainTableViewController.h"

@interface PopoverViewController ()

@property (retain, nonatomic) IBOutlet UIButton *goBackButton;
@property (retain, nonatomic) IBOutlet UIButton *openInBrowserButton;
@property (retain, nonatomic) IBOutlet UITextView *descriptionPopover;

@end



@implementation PopoverViewController


-(void)dealloc
{
    self.itemDetail = nil;
    self.itemLink = nil;
    [_descriptionPopover release];
    [_goBackButton release];
    [_openInBrowserButton release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.goBackButton setTitle:NSLocalizedString(@"GoBack", nil) forState:UIControlStateNormal];
    [self.openInBrowserButton setTitle:NSLocalizedString(@"OpenInBrowser", nil) forState:UIControlStateNormal];
}

-(void)viewDidAppear:(BOOL)animated
{

    self.descriptionPopover.text = self.itemDetail;
    
}


- (IBAction)goBackToFeedsAction:(id)sender {
    [((MainTableViewController*)self.parentViewController) hidePopover];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([segue.identifier isEqualToString:@"webBrowseerSegue"])
    {
        ((WebViewController*)[segue destinationViewController]).url = self.itemLink;
        [((MainTableViewController*)self.parentViewController) hidePopover];
    }
    
}


@end
