//
//  secondInterfaceController.m
//  First
//
//  Created by Arun Kumar on 31/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import "secondInterfaceController.h"
#import "Event.h"
@interface secondInterfaceController ()
{
    Event *t;


}
@end

@implementation secondInterfaceController
@synthesize eventName;
- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    t=(Event *)context;
    NSLog(@"%@",t.name);
    
    eventName.text=t.name;
    

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



