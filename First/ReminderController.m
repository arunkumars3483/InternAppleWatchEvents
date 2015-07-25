//
//  ReminderController.m
//  First
//
//  Created by Arun Kumar on 24/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import "ReminderController.h"

@interface ReminderController ()
{
int k;
}
@end

@implementation ReminderController

@synthesize  time;
@synthesize  ti;
@synthesize ret;
@synthesize ho;
@synthesize hour;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    k=0;
   
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // [dateFormatter setLocale:formatterLocale];
    [dateFormatter setDateFormat:@"mm"];
    int minute = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    [dateFormatter setDateFormat:@"hh"];
    int hh = [[dateFormatter stringFromDate:[NSDate date]] intValue];
    
    ho.value=hh;
    [hour setText:[NSString stringWithFormat:@"%d", (int)hh]];

    
    ti.value=(double)minute;
    [time setText:[NSString stringWithFormat:@"%d", (int)minute]];
    

}

#pragma mark - IBAction Methods

- (IBAction)valueChanged:(UIStepper *)sender {
    double value = [sender value];
    
    [time setText:[NSString stringWithFormat:@"%d", (int)value]];
}


- (IBAction)activateReminder
{
    NSString *od=@"25-07-2015";
    NSString *ot=@"14:44";
    
    NSString *str = [NSString stringWithFormat: @"%@T%@:00",od,ot];
   // NSString *dd=@"25-07-2015T14:39:00";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"dd-MM-yyyy'T'HH:mm:ss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:str];
    NSLog(@"Date : %@",dateFromString);
    //NSString *stringFromDate = [dateFormatter stringFromDate:dateFromString];
    //NSLog(@"stringFromDate: %@", stringFromDate);
    UIAlertView *helloWorldAlert = [[UIAlertView alloc]
                                    initWithTitle:@"Reminder Set" message:ret.text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    // Display the  Message
    [helloWorldAlert show];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    /*
    NSDateComponents *comp = [[NSDateComponents alloc] init];
    [comp setDay:25];
    [comp setMonth:7];
    [comp setYear:2015];
    NSDate *d = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate: dateFromString];
    //k=12;
    [comps setHour:(((int)(ho.value))%12)+k];
    [comps setMinute:ti.value];
    [comps setSecond:0];
    
    
    NSDate *dateFromComps = [calendar dateFromComponents:comps];
    */
    localNotification.fireDate= dateFromString;//dateFromComps;
    localNotification.alertBody = ret.text;
    localNotification.alertTitle=@"reminder";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotification.alertAction = @"go back";
    
    //localNotification.repeatInterval= NSCalendarUnitDay ;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    
    localNotification.applicationIconBadgeNumber = 1;    localNotification.category = @"myCategory";
    localNotification.userInfo=@{@"title" : @"reminder", @"body" : ret.text, @"key3" : @"value3"};
    
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}


- (IBAction)valueChanged2:(UIStepper *)sender {
    double value = [sender value];
    
    [hour setText:[NSString stringWithFormat:@"%d", (int)value]];
}

- (IBAction)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
       
         k=0;
         NSLog(@"am");

    }
    else{
        
         k=12;
         NSLog(@"pm");
        
        }
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
