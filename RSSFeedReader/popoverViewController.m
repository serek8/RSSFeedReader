//
//  popoverViewController.m
//  RSSFeedReader
//
//  Created by Jan Seredynski on 03/08/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "popoverViewController.h"
#import "MainTableViewController.h"

@interface popoverViewController ()
@property (retain, nonatomic) IBOutlet UIButton *goBackButton;
@property (retain, nonatomic) IBOutlet UIButton *openInBrowserButton;

@property (retain, nonatomic) IBOutlet UITextView *descriptionPopover;

@end



@implementation popoverViewController


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
    self.goBackButton.titleLabel.text = NSLocalizedString(@"Go back", nil);
    self.openInBrowserButton.titleLabel.text = NSLocalizedString(@"Open in browser", nil);
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{

    self.descriptionPopover.text = self.itemDetail;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBackToFeedsAction:(id)sender {
    [((MainTableViewController*)self.parentViewController) setSrcollableForTableView:YES];
    [((MainTableViewController*)self.parentViewController).containerView removeFromSuperview];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([segue.identifier isEqualToString:@"webBrowseerSegue"])
    {
        [((MainTableViewController*)self.parentViewController) setSrcollableForTableView:YES];
        ((WebViewController*)[segue destinationViewController]).url = self.itemLink;
        [((MainTableViewController*)self.parentViewController).containerView removeFromSuperview];
    }
    
}


@end
