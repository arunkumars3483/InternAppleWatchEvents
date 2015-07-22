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



@synthesize  console, opperator;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    stack = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction Methods

- (IBAction)one:(id)sender {
    [self addnumber:1];
}
- (IBAction)two:(id)sender {
    [self addnumber:2];
}
- (IBAction)three:(id)sender {
    [self addnumber:3];
}
- (IBAction)four:(id)sender {
    [self addnumber:4];
}
- (IBAction)five:(id)sender {
    [self addnumber:5];
}
- (IBAction)six:(id)sender {
    [self addnumber:6];
}
- (IBAction)seven:(id)sender {
    [self addnumber:7];
}
- (IBAction)eight:(id)sender {
    [self addnumber:8];
}
- (IBAction)nine:(id)sender {
    [self addnumber:9];
}
- (IBAction)zero:(id)sender {
    [self addnumber:0];
}
- (IBAction)remove:(id)sender {
    [self addnumber:-1];
}

- (IBAction)dot:(id)sender {
    [self addpoint];
}

- (IBAction)equals:(id)sender {
    [self logic:0];
}
- (IBAction)addition:(id)sender {
    [self logic:1];
}
- (IBAction)subtraction:(id)sender {
    [self logic:2];
}
- (IBAction)multiply:(id)sender {
    [self logic:3];
}
- (IBAction)division:(id)sender {
    [self logic:4];
    
}
- (IBAction)cancel:(id)sender {
    stack = @"0";
    result = 0.0;
    optype = -1;
    [console setText:stack];
    stack = @"";

    [opperator setText:@""];
}

-(void)addpoint{
    stack = [NSString stringWithFormat:@"%1$@.", stack];
    [console setText:stack];
}

-(void)logic:(int)type{
    if(type == 0){ // Equals
        if(optype == 1){
            stack = [NSString stringWithFormat:@"%f", [stack doubleValue]+result];
        }else if(optype == 2){
            stack = [NSString stringWithFormat:@"%f", result-[stack doubleValue]];
            
        }else if(optype == 3){
            stack = [NSString stringWithFormat:@"%f", [stack doubleValue]*result];
            
        }else if(optype == 4){
            stack = [NSString stringWithFormat:@"%f", result/[stack doubleValue]];
            
        }
        [console setText:stack];
        [opperator setText:@"="];
    }else{
        if(type == 1){ // addition
            [opperator setText:@"+"];
            
        }else if(type == 2){ // subtraction
            [opperator setText:@"-"];
        }else if(type == 3){ // multiply
            [opperator setText:@"*"];
        }else if(type == 4){ // division
            [opperator setText:@"/"];
        }
        optype = type;
        result = [stack doubleValue];
        stack = @"0";
        [console setText:stack];
        stack = @"";

        
    }
}

-(void)addnumber:(int)number{
    
    if(stack == NULL){
        stack = @"";
    }
    
    if(number > -1){
        stack = [NSString stringWithFormat:@"%1$@%2$d", stack, number];
    }else if([stack length] > 0){
        stack = [stack substringToIndex:[stack length]+number];
    }
    
    if([stack length] <= 0){
        stack = @"";
    }
    
    [console setText:stack];
    
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
