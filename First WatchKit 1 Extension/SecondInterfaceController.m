//
//  secondInterfaceController.m
//  First
//
//  Created by Arun Kumar on 31/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import "SecondInterfaceController.h"
#import "Event.h"
#import<CoreData/CoreData.h>
@interface SecondInterfaceController ()
{
    Event *t;


}
@end

@implementation SecondInterfaceController
@synthesize eventName;
@synthesize eventDate;
@synthesize eventLocation;
@synthesize eventTime;







- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
    t=(Event *)context;
    NSLog(@"%@",t.name);
    
    eventName.text=t.name;
    eventTime.text=t.time;
    eventLocation.text=t.location;
    eventDate.text=t.date;
    

}



- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
    
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


#pragma mark - IBAction  methods

- (IBAction)unsubscribe
{
    
    
    
    NSManagedObjectContext *managedObjectContext=[self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Events" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    // retrive the objects with a given value for a certain property
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"eventId == %@", t.ID];
    [request setPredicate:predicate];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"eventId" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    
    
    
    NSError *error = nil;
    NSArray *result = [managedObjectContext executeFetchRequest:request error:&error];
    NSManagedObject *device = [result objectAtIndex:0];
    NSLog(@"get it : %@",[device valueForKey:@"name"]);
    
    [managedObjectContext deleteObject:[result objectAtIndex:0]];
    
    error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
    
    [self popController];

    
}
@end



