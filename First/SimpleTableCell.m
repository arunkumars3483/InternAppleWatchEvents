//
//  SimpleTableCell.m
//  First
//
//  Created by Arun Kumar on 14/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell


@synthesize nameLabel = _nameLabel;
@synthesize prepTimeLabel = _prepTimeLabel;
@synthesize thumbnailImageView = _thumbnailImageView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
