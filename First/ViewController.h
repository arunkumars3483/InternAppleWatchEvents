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
   
   
    Event *details;
    NSMutableArray *events;
   

}

@property (nonatomic, weak) IBOutlet UITableView *tableView;


@end

