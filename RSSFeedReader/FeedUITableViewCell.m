//
//  FeedUITableViewCell.m
//  RSSReader
//
//  Created by Jan Seredynski on 27/07/15.
//  Copyright (c) 2015 Jan Seredynski. All rights reserved.
//

#import "FeedUITableViewCell.h"

@implementation FeedUITableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)dealloc {
    [_buttonWithImage release];
    [_titleLabel release];
    [_imageView2 release];
    [super dealloc];
}
@end
