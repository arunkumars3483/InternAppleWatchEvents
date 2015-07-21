//
//  CalController.h
//  First
//
//  Created by Arun Kumar on 21/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalController : UIViewController


-(IBAction)sum;
-(IBAction)subtract;
-(IBAction)multiply;
-(IBAction)divide;
@property (nonatomic, weak)  UITextField *tt;
@property (nonatomic, weak) UILabel *ll;
@property (nonatomic, weak)  UITextField *l2;

@end
