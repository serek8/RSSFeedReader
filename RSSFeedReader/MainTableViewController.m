//
//  MainTableViewController.m
//  RSSReader
//
//  Created by Jan Seredynski on 23/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "MainTableViewController.h"
#import "popoverViewController.h"

@interface MainTableViewController () <NSFetchedResultsControllerDelegate, UISearchBarDelegate>
{
        NetworkStatus networkStatus;
}

@property (nonatomic, retain) NSManagedObjectContext* mainContext;
@property (nonatomic, retain) NSFetchedResultsController* resultsController;


@property (retain, nonatomic) NSIndexPath *cellIndexForPopover;


@end

@implementation MainTableViewController


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.mainContext = nil;
    self.resultsController = nil;
    [_containerView release];
    [super dealloc];
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    

    self.mainContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(settingsChanged:)
                                                 name:SettingsUpdatedNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectionStatusDidChange:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];

    [[ParserManager sharedInstance] parse:[SettingsManager sharedInstance].serverURL];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self connectionStatusDidChange:nil];
}

-(void)connectionStatusDidChange:(NSNotification *) notification
{
    if([[ParserManager sharedInstance] currentNetworkStatus] == NotReachable)
    {
        
        self.title = NSLocalizedString(@"ConnectionLost", nil);
        //self.title = @"Connection Lost";
    }
    else
    {
        self.title = NSLocalizedString(@"Feeds", nil);
    }
}
- (void) settingsChanged:(NSNotification *) notification
{

    NSError* error;
    
    [self.resultsController.fetchRequest setPredicate:
     [NSPredicate predicateWithFormat:
      @"feedServerRelationship.serverUrl contains[cd] %@", [SettingsManager sharedInstance].serverURL]];
     [[ParserManager sharedInstance] parse:[SettingsManager sharedInstance].serverURL];
    [self.resultsController performFetch:&error];
    [self.tableView reloadData];
}



-(NSFetchedResultsController*)resultsController
{
    if (_resultsController != nil)
        return _resultsController;
    
    NSFetchRequest *fetchRequest = [[[NSFetchRequest alloc] init] autorelease];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:FeedItem.entityName
                                   inManagedObjectContext:self.mainContext];
    
    [fetchRequest setEntity:entity];
    //[fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sort = [[[NSSortDescriptor alloc]
                              initWithKey:@"itemPublicationDate"
                              ascending:NO] autorelease];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"feedServerRelationship.serverUrl contains[cd] %@", [SettingsManager sharedInstance].serverURL];
    [fetchRequest setPredicate:predicate];

    
    NSFetchedResultsController *theFetchedResultsController =
    [[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.mainContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil] autorelease];
    
    self.resultsController = theFetchedResultsController;
    _resultsController.delegate = self;
    
    return _resultsController;
}

-(void)setSrcollableForTableView: (BOOL)scrollableBool
{
    self.tableView.scrollEnabled = scrollableBool;
}

#pragma mark - NSFetchedResultsControllerDelegate



- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    
    UITableView *tableView = self.tableView;
    
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    
    id  sectionInfo = [self.resultsController.sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedItem* feedItem = [self.resultsController objectAtIndexPath:indexPath];
    FeedUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedTableCell"
                                                                forIndexPath:indexPath];

       cell.titleLabel.text = feedItem.itemTitle;
    cell.summaryLabel.text = feedItem.itemDetail;
    
    [[ImageDisplayManager sharedInstance] queueDisplayImageOfFeedItem:feedItem
                                                     inImageView:cell.imageView2];

    
    return cell;
}

-(BOOL)searchBar:(UISearchBar *)searchBar
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    NSPredicate *predicate = nil;
    if ([searchBar.text length])
    {
        
        // full text, in my implementation.  Other scope button titles are "Author", "Title"
        predicate = [NSPredicate predicateWithFormat:@"feedServerRelationship.serverUrl contains[cd] %@ AND itemTitle CONTAINS[c] %@", [SettingsManager sharedInstance].serverURL, [NSString stringWithFormat:@"%@%@", searchBar.text, text]];
        [self.resultsController.fetchRequest setPredicate:predicate];
        NSError* error;
        [self.resultsController performFetch:&error];
        [self.tableView reloadData];
    }
    else
    {
        // full text, in my implementation.  Other scope button titles are "Author", "Title"
        predicate = [NSPredicate predicateWithFormat:@"feedServerRelationship.serverUrl contains[cd] %@", [SettingsManager sharedInstance].serverURL];
        [self.resultsController.fetchRequest setPredicate:predicate];
        NSError* error;
        [self.resultsController performFetch:&error];
        [self.tableView reloadData];
    }
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cellIndexForPopover = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.tableView addSubview:self.containerView];
    self.containerView.frame = self.view.superview.bounds;
    self.containerView.frame = CGRectMake(self.view.superview.bounds.origin.x,
                                          self.tableView.contentOffset.y,
                                          self.view.superview.bounds.size.width,
                                          self.view.superview.bounds.size.height);
    //self.containerView.frame.origin.y = self.tableView.contentOffset.y;
    self.tableView.scrollEnabled = NO;
    
    for(UIViewController* ctrl in self.childViewControllers)
        if ([ctrl isKindOfClass:[popoverViewController class]])
        {
            
            ((popoverViewController*)ctrl).itemLink = ((FeedItem*)[self.resultsController objectAtIndexPath:indexPath]).itemLink;
            ((popoverViewController*)ctrl).itemDetail = ((FeedItem*)[self.resultsController objectAtIndexPath:indexPath]).itemDetail;
            break;
        }
}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if([segue.identifier isEqualToString:@"webBrowseerSegue"])
    {
        [self.containerView removeFromSuperview];
    ((WebViewController*)[segue destinationViewController]).url =
    ((FeedItem*)[self.resultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow]).itemLink;
    }
    else if([segue.identifier isEqualToString:@"browseImageSeque"])
    {
        UIView* chk = nil;
        for(chk = sender; chk; chk=chk.superview)
            if ([chk isKindOfClass:[FeedUITableViewCell class]])
                break;
        NSIndexPath* sel = [self.tableView indexPathForCell:(UITableViewCell*)chk];
        FeedItem* curItem = [self.resultsController objectAtIndexPath:sel];
        ImageBrowserViewController* im =[segue destinationViewController];
        im.item =   curItem;
    }
}


@end
