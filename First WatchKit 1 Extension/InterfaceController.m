//
//  InterfaceController.m
//  First WatchKit 1 Extension
//
//  Created by Arun Kumar on 23/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import "InterfaceController.h"
#import "Event.h"
#import "Cell.h"

@interface InterfaceController()
{
    NSMutableArray *events;
}
@end


@implementation InterfaceController

@synthesize ev;
@synthesize table;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
        // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
    NSArray *sd=@[@"Dollar", @"Euro", @"Pound",@"dfgdfg",@"fgdfgdfgf", @"Pound", @"Pound", @"Pound", @"Pound", @"Pound", @"Pound", @"Pound", @"Pound", @"Pound", @"Pound", @"Pound", @"Pound"];
    
    //events=[[NSMutableArray alloc] init];
    
    Event *details;
    events=[[NSMutableArray alloc]init];

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"details" ofType:@"txt" ];
    NSString* content = [NSString stringWithContentsOfFile:filePath  encoding:NSUTF8StringEncoding error:NULL];
    
    NSData* myData = [content dataUsingEncoding:NSUTF8StringEncoding];
    if (myData) {
        // do something useful
        
        id publicTimeline = [NSJSONSerialization JSONObjectWithData:myData options:0 error:nil];
        
        for (int i=0; i<[publicTimeline count]; i++) {
            NSDictionary *arrayResult = [publicTimeline objectAtIndex:i];
            //NSLog(@"name=%@",[arrayResult objectForKey:@"colorName"]);
            
            details=[[Event alloc] init];
            details.name=[arrayResult objectForKey:@"Name"];
            details.date=[arrayResult objectForKey:@"Date"];
            details.location=[arrayResult objectForKey:@"Location"];
            details.time=[arrayResult objectForKey:@"Time"];
            details.rating=[arrayResult objectForKey:@"Rating"];
            details.ID=[arrayResult objectForKey:@"Id"];
            details.desc=[arrayResult objectForKey:@"Description"];
            details.address=[arrayResult objectForKey:@"Address"];
            
            
           // ev.text=details.name;
            
            [events addObject:details];
            
            
            
            NSLog(@"name=%@",[arrayResult objectForKey:@"Name"]);
            
        }
    }
    [self configureTableWithData:events];
    
    
    
}



- (void)configureTableWithData:(NSMutableArray *)dataObjects {
    [self.table setNumberOfRows:[dataObjects count] withRowType:@"mainRowType"];
    for (NSInteger i = 0; i < self.table.numberOfRows; i++) {
        Cell* theRow = [self.table rowControllerAtIndex:i];
       //[dataObjects objectAtIndex:i];
        Event *tmp=[dataObjects objectAtIndex:i];
        [theRow.rowDescription setText:tmp.name];
        
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)table:(WKInterfaceTable * ) table
didSelectRowAtIndex:(NSInteger)rowIndex{

    NSLog(@"selectsc  : %ld",(long)rowIndex);
    [self pushControllerWithName:@"second" context: [events objectAtIndex:rowIndex]];

}



@end



