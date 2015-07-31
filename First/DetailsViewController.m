//
//  DetailsViewController.m
//  First
//
//  Created by Arun Kumar on 15/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import "DetailsViewController.h"
#import "PlaceAnnotation.h"
#import "AppDelegate.h"
#import "MapScreenControllerViewController.h"
#import <CoreData/CoreData.h>
@interface DetailsViewController ()
@property (nonatomic, strong) PlaceAnnotation *annotation;



@property (nonatomic, strong) MKLocalSearch *localSearch;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D userLocation;




@end

@implementation DetailsViewController
@synthesize  devices;
@synthesize places;
@synthesize recipeLabel;
@synthesize bc;
@synthesize mapView;
@synthesize boundingRegion;
@synthesize loc;
@synthesize addr;
@synthesize dat;
@synthesize tim;
@synthesize star1;
@synthesize star2;
@synthesize star3;
@synthesize star4;
@synthesize star5;
@synthesize des;
@synthesize locationmanager;
@synthesize  mapItemList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    recipeLabel.text = self.deta.name;
    loc.text=self.deta.location;
    addr.text=self.deta.address;
    dat.text=self.deta.date;
    tim.text=self.deta.time;
    int x = [self.deta.rating intValue];
    
    NSLog(@"%@",self.deta.ID);
    //cell.thumbnailImageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    //cell.prepTimeLabel.text = [prepTime objectAtIndex:indexPath.row];
    switch (x) {
        case 1:
            star1.image = [UIImage imageNamed:@"selected"];
            star2.image = [UIImage imageNamed:@"notselected"];
            star3.image = [UIImage imageNamed:@"notselected"];
            star4.image = [UIImage imageNamed:@"notselected"];
            star5.image = [UIImage imageNamed:@"notselected"];
            break;
        case 2:
            star1.image = [UIImage imageNamed:@"selected"];
            star2.image = [UIImage imageNamed:@"selected"];
            star3.image = [UIImage imageNamed:@"notselected"];
            star4.image = [UIImage imageNamed:@"notselected"];
            star5.image = [UIImage imageNamed:@"notselected"];
            
            break;
        case 3:
            star1.image = [UIImage imageNamed:@"selected"];
            star2.image = [UIImage imageNamed:@"selected"];
            star3.image = [UIImage imageNamed:@"selected"];
            star4.image = [UIImage imageNamed:@"notselected"];
            star5.image = [UIImage imageNamed:@"notselected"];
            
            break;
        case 4:
            star1.image = [UIImage imageNamed:@"selected"];
            star2.image = [UIImage imageNamed:@"selected"];
            star3.image = [UIImage imageNamed:@"selected"];
            star4.image = [UIImage imageNamed:@"selected"];
            star5.image = [UIImage imageNamed:@"notselected"];
            
            break;
        case 5:
            star1.image = [UIImage imageNamed:@"selected"];
            star2.image = [UIImage imageNamed:@"selected"];
            star3.image = [UIImage imageNamed:@"selected"];
            star4.image = [UIImage imageNamed:@"selected"];
            star5.image = [UIImage imageNamed:@"selected"];
            break;
            
            
        default:
            star1.image = [UIImage imageNamed:@"selected"];
            star2.image = [UIImage imageNamed:@"notselected"];
            star3.image = [UIImage imageNamed:@"notselected"];
            star4.image = [UIImage imageNamed:@"notselected"];
            star5.image = [UIImage imageNamed:@"notselected"];
            break;
    }

    
    des.text=self.deta.desc;
    self.mapView.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"detback.png"]];
    
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


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = self.userLocation.latitude;
    newRegion.center.longitude = self.userLocation.longitude;
    
    // setup the area spanned by the map region:
    // we use the delta values to indicate the desired zoom level of the map,
    //      (smaller delta values corresponding to a higher zoom level)
    //
    newRegion.span.latitudeDelta = 0.3;
    newRegion.span.longitudeDelta = 0.3;
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    
    request.naturalLanguageQuery = self.deta.location;  //location String Queries
    request.region = newRegion;
    
    MKLocalSearchCompletionHandler completionHandler = ^(MKLocalSearchResponse *response, NSError *error)
    {
                    self.places = [response mapItems];
            
            // used for later when setting the map's region in "prepareForSegue"
            self.boundingRegion = response.boundingRegion;
            
           //perform action here
        MKMapItem *mapItem = [self.places objectAtIndex:0];
        NSLog(@"%@",mapItem.name);
        
        
        // adjust the map to zoom/center to the annotations we want to show
        [self.mapView setRegion:self.boundingRegion];
        
        mapItem = [self.places objectAtIndex:0];
        
       // self.title = mapItem.name;
        
        // add the single annotation to our map
        PlaceAnnotation *annotation = [[PlaceAnnotation alloc] init];
        annotation.coordinate = mapItem.placemark.location.coordinate;
        annotation.title = mapItem.name;
        annotation.url = mapItem.url;
        [self.mapView addAnnotation:annotation];
        
        // we have only one annotation, select it's callout
        [self.mapView selectAnnotation:[self.mapView.annotations objectAtIndex:0] animated:YES];
        
        // center the region around this map item's coordinate
        self.mapView.centerCoordinate = mapItem.placemark.coordinate;
        
        
    };
    
    if (self.localSearch != nil)
    {
        self.localSearch = nil;
    }
    
    self.localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    
    [self.localSearch startWithCompletionHandler:completionHandler];

       
}

#pragma mark - IBAction Methods

- (IBAction)dismisswindow
{
    [self.navigationController popViewControllerAnimated:YES];

   
}

- (IBAction)notify
{
 /*
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    localNotification.alertBody = @"Notification Ready";
    localNotification.alertTitle=@"good";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotification.applicationIconBadgeNumber = 1;//[[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    localNotification.category = @"myCategory";
    localNotification.userInfo=@{@"key1" : @"Myevent", @"key2" : @"value2", @"key3" : @"value3"};
    
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName: @"com.firstios.First"];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
     appDelegate.dd=self.deta.ID;
    // Use the shared user defaults object to update the user's account
    [mySharedDefaults setObject:@"dfg" forKey:@"lastAccountName"];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
   */
    
    
    
    
    
    
    int subscribed =0;
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Events"];
    self.devices = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    //   [self.tableView reloadData];
    
    
    
   // dataObjects=[[NSMutableArray alloc]init];
    
    for (NSInteger i=0; i<self.devices.count; i++) {
        //  NSDictionary *arrayResult = [allKeys objectAtIndex:i]; */
        
        
        
        NSManagedObject *device = [self.devices objectAtIndex:i];
        //  [dataObjects addObject:[device valueForKey:@"eventName"]];
        // NSLog(@"%@",item.eventid);
        
        if([self.deta.ID isEqualToString:[device valueForKey:@"eventId"]])
        {
            subscribed =1;
            
            NSLog(@"Already Subscribed");
            break;
        }
    }
    
    if( subscribed ==0) {
        NSManagedObjectContext *context = [self managedObjectContext];
        
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Events" inManagedObjectContext:context];
        
        
        [newDevice setValue:self.deta.name forKey:@"name"];
        [newDevice setValue:self.deta.time forKey:@"time"];
        [newDevice setValue:self.deta.date forKey:@"date"];
        [newDevice setValue:self.deta.location forKey:@"location"];
        [newDevice setValue:self.deta.address forKey:@"address"];
        [newDevice setValue:self.deta.desc forKey:@"desc"];
        [newDevice setValue:self.deta.ID forKey:@"eventId"];
        [newDevice setValue:self.deta.rating forKey:@"rating"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);    }
        
        // NSLog(@"Event name;%@",[newDevice valueForKey:@"eventName"]);
    }
    
    
    
    
    
   
        NSString *od=self.deta.date;
        NSString *ot=self.deta.time;
        
        NSString *str = [NSString stringWithFormat: @"%@T%@:00",od,ot];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
        [dateFormatter setDateFormat:@"dd-MM-yyyy'T'HH:mm:ss"];
        NSDate *dateFromString = [[NSDate alloc] init];
    
        dateFromString = [dateFormatter dateFromString:str];
        NSLog(@"Date : %@",dateFromString);
        UIAlertView *helloWorldAlert = [[UIAlertView alloc]
                                        initWithTitle:@"Reminder Set" message:[NSString stringWithFormat: @"Reminder for Event - %@ is set and will be notified 1 hour before the scheduled time.",self.deta.name] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        // Display the  Message
        [helloWorldAlert show];
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
        NSDateComponents *dc = [[NSDateComponents alloc] init];
    
        [dc setHour:-1];
        NSDate *fire = [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:dateFromString options:0];
    
    
        localNotification.fireDate= fire;
        localNotification.alertBody = [NSString stringWithFormat: @"The Event - %@ is about to start at %@ %@",self.deta.name,self.deta.time,self.deta.date];
        localNotification.alertTitle=@"Reminder : ";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        
        localNotification.alertAction = @"go back";
        
        //localNotification.repeatInterval= NSCalendarUnitDay ;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        
        
        localNotification.applicationIconBadgeNumber = 1;
        localNotification.category = @"";
        localNotification.userInfo=@{@"title" : @"Reminder : ", @"body" : [NSString stringWithFormat: @"The Event - %@ is about to start at %@ %@",self.deta.name,self.deta.time,self.deta.date], @"key3" : @"value3"};
        
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    

    
    
    
    
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Fullscreen"]) {
        
        MapScreenControllerViewController *destt = segue.destinationViewController;
        destt.boundingRegion= self.boundingRegion;
        destt.mapItem=[self.places objectAtIndex:0];
        
                
        
    }
}
@end
