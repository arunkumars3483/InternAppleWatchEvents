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
@synthesize time = _time;
@synthesize  venue= _venue;
@synthesize date = _date;
@synthesize ti = _ti;
@synthesize cl = _cal;
@synthesize star1;
@synthesize star2;
@synthesize star3;
@synthesize star4;
@synthesize star5;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
