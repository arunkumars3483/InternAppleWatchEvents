//
//  SimpleTableCell.h
//  First
//
//  Created by Arun Kumar on 14/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *prepTimeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end
