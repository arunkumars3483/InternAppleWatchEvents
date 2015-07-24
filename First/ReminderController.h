//
//  ReminderController.h
//  First
//
//  Created by Arun Kumar on 24/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderController : UIViewController
{
    int k;

}
@property(nonatomic,weak) IBOutlet UILabel *time;
@property(nonatomic,weak) IBOutlet UIStepper *ti;
@property(nonatomic,weak) IBOutlet UIStepper *ho;
@property(nonatomic,weak) IBOutlet UILabel *hour;
@property(nonatomic,weak) IBOutlet UITextField *ret;
@end
