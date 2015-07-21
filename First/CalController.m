//
//  CalController.m
//  First
//
//  Created by Arun Kumar on 21/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import "CalController.h"

@interface CalController ()

@end

@implementation CalController


@synthesize  tt;
@synthesize  ll;
@synthesize l2;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction Methods

- (IBAction)disp
{
    
   tt= (UITextField*)[self.view viewWithTag:1];
    l2= (UITextField*)[self.view viewWithTag:2];
    NSString *n1=tt.text;
    NSString *n2=l2.text;
    int sum=[n1 intValue]*[n2 intValue];
    
   ll.text= [NSString stringWithFormat:@"%d",sum];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
