//
//  ViewController.m
//  First
//
//  Created by Arun Kumar on 14/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import "ViewController.h"
#import "SimpleTableCell.h"
#import "DetailsViewController.h"
#import <CoreData/CoreData.h>
@interface ViewController ()

@end

@implementation ViewController
@synthesize tableView;

-(void)deleteEverything{

    NSManagedObjectContext *myContext=[self managedObjectContext];
    NSFetchRequest *allCars = [[NSFetchRequest alloc] init];
    [allCars setEntity:[NSEntityDescription entityForName:@"Events" inManagedObjectContext:myContext]];
    [allCars setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error = nil;
    NSArray *cars = [myContext executeFetchRequest:allCars error:&error];
        //error handling goes here
    for (NSManagedObject *car in cars) {
        [myContext deleteObject:car];
    }
    NSError *saveError = nil;
    [myContext save:&saveError];
    //more error handling here

}

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



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    /*
    
    
    
    NSError *error=nil;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Events" inManagedObjectContext:context];
    [newDevice setValue:@"I am the third index" forKey:@"name"];
    
    
    error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else{
        NSLog(@"successsss");
    }
    [self deleteEverything]; */
    /*
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Events"];
    self.devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    
    NSManagedObject *device = [self.devices objectAtIndex:0];
    NSLog(@"get it : %@",[device valueForKey:@"name"]);
    */
    events=[[NSMutableArray alloc] init];
    
    
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

            
            
            
            [events addObject:details];
            
            

            NSLog(@"name=%@",[arrayResult objectForKey:@"Name"]);
            
        }
          }
   
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView delegate methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [events count];
}


- (UITableViewCell *)tableView:(UITableView *)tablView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       static NSString *simpleTableIdentifier = @"RecipeCell";
    
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    SimpleTableCell *cell = (SimpleTableCell *)[tablView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[SimpleTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Event *tmp=[[Event alloc] init];
    tmp=[events objectAtIndex:indexPath.row];
    //cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.nameLabel.text = tmp.name;
    cell.time.text=tmp.time;
    cell.venue.text=tmp.location;
    cell.date.text=tmp.date;
   

    
    
    int x = [  tmp.rating intValue];
    NSLog(@"%i",x);//cell.thumbnailImageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    //cell.prepTimeLabel.text = [prepTime objectAtIndex:indexPath.row];
    switch (x) {
        case 1:
            cell.star1.image = [UIImage imageNamed:@"selected"];
            cell.star2.image = [UIImage imageNamed:@"notselected"];
            cell.star3.image = [UIImage imageNamed:@"notselected"];
            cell.star4.image = [UIImage imageNamed:@"notselected"];
            cell.star5.image = [UIImage imageNamed:@"notselected"];
            break;
        case 2:
            cell.star1.image = [UIImage imageNamed:@"selected"];
            cell.star2.image = [UIImage imageNamed:@"selected"];
            cell.star3.image = [UIImage imageNamed:@"notselected"];
            cell.star4.image = [UIImage imageNamed:@"notselected"];
            cell.star5.image = [UIImage imageNamed:@"notselected"];

            break;
        case 3:
            
            cell.star1.image = [UIImage imageNamed:@"selected"];
            cell.star2.image = [UIImage imageNamed:@"selected"];
            cell.star3.image = [UIImage imageNamed:@"selected"];
            cell.star4.image = [UIImage imageNamed:@"notselected"];
            cell.star5.image = [UIImage imageNamed:@"notselected"];

            break;
        case 4:
            
            cell.star1.image = [UIImage imageNamed:@"selected"];
            cell.star2.image = [UIImage imageNamed:@"selected"];
            cell.star3.image = [UIImage imageNamed:@"selected"];
            cell.star4.image = [UIImage imageNamed:@"selected"];
            cell.star5.image = [UIImage imageNamed:@"notselected"];

            break;
        case 5:
            
            cell.star1.image = [UIImage imageNamed:@"selected"];
            cell.star2.image = [UIImage imageNamed:@"selected"];
            cell.star3.image = [UIImage imageNamed:@"selected"];
            cell.star4.image = [UIImage imageNamed:@"selected"];
            cell.star5.image = [UIImage imageNamed:@"selected"];
            

            break;
            
            
        default:
            cell.star1.image = [UIImage imageNamed:@"notselected"];
            cell.star2.image = [UIImage imageNamed:@"notselected"];
            cell.star3.image = [UIImage imageNamed:@"notselected"];
            cell.star4.image = [UIImage imageNamed:@"notselected"];
            cell.star5.image = [UIImage imageNamed:@"notselected"];

            break;
    }
cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell"] ] ;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailsViewController *destViewController = segue.destinationViewController;
        
        
        destViewController.deta=[events objectAtIndex:indexPath.row];
        
        
        
    }
}

@end
