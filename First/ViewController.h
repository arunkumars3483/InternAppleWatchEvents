//
//  ViewController.h
//  First
//
//  Created by Arun Kumar on 14/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UILabel *mytext;
   
    Event *details;
    NSMutableArray *events;
   

}
    -(IBAction)showMessage;

@property (nonatomic, weak) IBOutlet UITableView *tableView;


@end

