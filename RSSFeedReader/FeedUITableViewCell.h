//
//  FeedUITableViewCell.h
//  RSSReader
//
//  Created by Jan Seredynski on 27/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedUITableViewCell : UITableViewCell


@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

@property (retain, nonatomic) IBOutlet UIImageView *iconImageView;

@property (retain, nonatomic) IBOutlet UIButton *buttonWithImage;
@property (retain, nonatomic) IBOutlet UILabel *summaryLabel;
@end
