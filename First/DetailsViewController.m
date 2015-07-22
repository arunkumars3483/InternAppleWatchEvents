//
//  DetailsViewController.m
//  First
//
//  Created by Arun Kumar on 15/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import "DetailsViewController.h"
#import "PlaceAnnotation.h"
#import "MapScreenControllerViewController.h"
@interface DetailsViewController ()
@property (nonatomic, strong) PlaceAnnotation *annotation;



@property (nonatomic, strong) MKLocalSearch *localSearch;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D userLocation;




@end

@implementation DetailsViewController

@synthesize places;
@synthesize recipeLabel;
@synthesize bc;
@synthesize mapView;
@synthesize boundingRegion;
@synthesize loc;
@synthesize addr;
@synthesize dat;
@synthesize tim;
@synthesize rat;
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
           rat.image = [UIImage imageNamed:@"1star"];
            break;
        case 2:
            rat.image = [UIImage imageNamed:@"2star"];
            
            break;
        case 3:
            rat.image = [UIImage imageNamed:@"3star"];
            
            break;
        case 4:
           rat.image = [UIImage imageNamed:@"4star"];
            
            break;
        case 5:
            rat.image = [UIImage imageNamed:@"5star"];
            
            break;
            
            
        default:
            rat.image = [UIImage imageNamed:@"1star"];
            break;
    }

    
    des.text=self.deta.desc;
    self.mapView.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"detback.png"]];
    
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

- (IBAction)noti
{
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    localNotification.alertBody = @"new Blog Posted at iOScreator.com";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    localNotification.category = @"com.firstios.arun.First.watchkitapp";
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
