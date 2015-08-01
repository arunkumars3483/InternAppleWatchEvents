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
#import<CoreData/CoreData.h>
@interface InterfaceController()
{
    NSMutableArray *events;
    Event *details;

}
@end


@implementation InterfaceController

@synthesize ev;
@synthesize table;

@synthesize devices;



- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
        // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Events"];
    self.devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    
    NSManagedObject *device = [self.devices objectAtIndex:0];
    NSLog(@"get it : %@",[device valueForKey:@"name"]);
    
    ev.text=[NSString stringWithFormat:@"MY EVENTS (%lu)",(unsigned long)[self.devices count]];

    
    events=[[NSMutableArray alloc]init];
    
    
        [self configureTableWithData:events];
    
    
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
#pragma mark - CoreData methods

- (NSManagedObjectContext *)managedObjectContext {
    // NSManagedObjectContext *context = nil;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"First" withExtension:@"momd"];
    NSManagedObjectModel * managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    
    
    NSURL *storeURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.qburst.watch"];
    storeURL = [storeURL URLByAppendingPathComponent:@"First.sqlite"];
    
    NSPersistentStore *store = nil;
    NSPersistentStoreCoordinator *coordinator=[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    NSError *error=nil;
    store = [coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                      configuration:nil
                                                URL:storeURL
                                            options:nil
                                              error:&error];
    
    NSManagedObjectContext * managedObjectContext = [[NSManagedObjectContext alloc] init];
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return managedObjectContext;
}
#pragma mark - WKInterface Table methods


- (void)configureTableWithData:(NSMutableArray *)dataObjects {
    [self.table setNumberOfRows:[self.devices count] withRowType:@"mainRowType"];
    for (NSInteger i = 0; i < self.table.numberOfRows; i++) {
        Cell* theRow = [self.table rowControllerAtIndex:i];
       //[dataObjects objectAtIndex:i];
        //Event *tmp=[dataObjects objectAtIndex:i];
        NSManagedObject *device = [self.devices objectAtIndex:i];
         details=[[Event alloc] init];
        details.name=[device valueForKey:@"name"];
        details.date=[device valueForKey:@"date"];
        details.location=[device valueForKey:@"location"];
        details.time=[device valueForKey:@"time"];
        details.ID=[device valueForKey:@"eventId"];

        [events addObject:details];
        [theRow.eventDate setText:[device valueForKey:@"date"]];
        [theRow.rowDescription setText:[device valueForKey:@"name"]];
        
    }
}

#pragma mark - WKInterface Table row selection handling methods

- (void)table:(WKInterfaceTable * ) table
didSelectRowAtIndex:(NSInteger)rowIndex{

    NSLog(@"selectsc  : %ld",(long)rowIndex);
    Event *tmp=[events objectAtIndex:rowIndex];
    
   // NSManagedObject *dev = [self.devices objectAtIndex:rowIndex];
   //[dev valueForKey:@"name"];
   
    
    //tmp.name=t;

    [self pushControllerWithName:@"second" context: tmp];
    

}



@end



