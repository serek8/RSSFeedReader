//
//  MainTableViewController.m
//  RSSReader
//
//  Created by Jan Seredynski on 23/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//
#import "WebViewController.h"
#import "MainTableViewController.h"
#import "AppDelegate.h"
#import "FeedItem.h"
#import "FeedUITableViewCell.h"
#import "ImageBrowserViewController.h"
#import "SettingsManager.h"
#import "ParserManager.h"

@interface MainTableViewController () <NSFetchedResultsControllerDelegate>


@property (nonatomic, retain) NSManagedObjectContext* context;
@property (nonatomic,retain) NSFetchedResultsController* resultsController;

@end

@implementation MainTableViewController

// I set to nil every pointer I used.
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.context = nil;
    NSLog(@"dealloc");
    [super dealloc];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // I will use that context only for readingnfrom UITableView on the main thread
    self.context = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;

    // Create notification observer which chcecks id another context is writing data to it
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contextChanged:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"EnterApplicationForegroundNotification"
                                               object:nil];
    


    NSLog(@"load");
    // Start NSFetchResultController
    NSError* error;
    [self.resultsController performFetch:&error];
    
    [[ParserManager sharedInstance] parse:[SettingsManager sharedInstance].serverURL];
    

}

- (void) receiveTestNotification:(NSNotification *) notification
{
    
        NSLog (@"Successfully received the test notification!");

    NSError* error;
    [self.resultsController.fetchRequest setPredicate:
     [NSPredicate predicateWithFormat:
      @"server.url contains[cd] %@", [SettingsManager sharedInstance].serverURL]];
     
    [self.resultsController performFetch:&error];
    [self.tableView reloadData];
}


// The callback for changing context value
-(void)contextChanged:(NSNotification*)notification
{
    dispatch_async(dispatch_get_main_queue(), ^
    {
        // Merging changes to persistant store
        [self.context mergeChangesFromContextDidSaveNotification:notification];
    });
}



-(NSFetchedResultsController*)resultsController
{
    if (_resultsController != nil)
        return _resultsController;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:FeedItem.entityName
                                   inManagedObjectContext:self.context];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"itemPublicationDate"
                              ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"feedServerRelationship.serverUrl contains[cd] %@", [SettingsManager sharedInstance].serverURL];
    [fetchRequest setPredicate:predicate];

    [NSFetchedResultsController deleteCacheWithName:@"Root"];
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.context
                                          sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    
    self.resultsController = theFetchedResultsController;
    _resultsController.delegate = self;
    
    return _resultsController;
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
    FeedItem* dat = [self.resultsController objectAtIndexPath:indexPath];
    
    //
    FeedUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedTableCell"
                                                                forIndexPath:indexPath];


    cell.titleLabel.text = dat.itemTitle;
    

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        // Download or get images here
        UIImage *cellImage = [UIImage imageWithData:[dat getItemIcon]];
        
        // Use main thread to update the view. View changes are always handled through main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            // Refresh image view here
            cell.imageView2.image=cellImage;
            [cell setNeedsLayout ];
        });
    });

    
    return cell;
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
    NSError* error;
    [self.context save:&error];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if([segue.identifier isEqualToString:@"webBrowseerSegue"])
    {
//        [self.tableView indexPathForCell:sender];
    ((WebViewController*)[segue destinationViewController]).url =
    ((FeedItem*)[self.resultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow]).itemLink;
    }
    else if([segue.identifier isEqualToString:@"browseImageSeque"])
    {
        UIView* chk = nil;
        for(chk = sender; chk; chk=chk.superview)
            if ([chk isKindOfClass:[FeedUITableViewCell class]])
                break;
        assert(chk); // shit happens!!!
        NSIndexPath* sel = [self.tableView indexPathForCell:(UITableViewCell*)chk];
        FeedItem* curItem = [self.resultsController objectAtIndexPath:sel];
        ImageBrowserViewController* im =[segue destinationViewController];
        im.image =   [UIImage imageWithData:[curItem getItemIcon]];
    }
}


@end
