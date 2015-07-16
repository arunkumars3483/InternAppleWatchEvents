//
//  DetailsViewController.m
//  First
//
//  Created by Arun Kumar on 15/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import "DetailsViewController.h"
#import "PlaceAnnotation.h"
#import "MapTouchView.h"
@interface DetailsViewController ()
@property (nonatomic, strong) PlaceAnnotation *annotation;



@property (nonatomic, strong) MKLocalSearch *localSearch;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D userLocation;




@end

@implementation DetailsViewController

@synthesize places;
@synthesize recipeLabel;
@synthesize recipeName;
@synthesize ID;
@synthesize Description;
@synthesize Time;
@synthesize Date;
@synthesize Location;
@synthesize Address;
@synthesize Rating;
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
    recipeLabel.text = recipeName;
    loc.text=Location;
    addr.text=Address;
    dat.text=Date;
    tim.text=Time;
    rat.text=Rating;
    des.text=Description;
    self.mapView.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"detback.png"]];
     [self.view insertSubview:mapTouchView aboveSubview:mapView];
   // mapTouchView = [[MapTouchView alloc] initWithBlockForTouchesBegan:^(NSSet *touches, UIEvent *event) {
   //     [self displayFullMap];
   // }];
    
}

- (id)init {
    self=[super init];
    mapTouchView = [[MapTouchView alloc] initWithBlockForTouchesBegan:^(NSSet *touches, UIEvent *event) {
        [self displayFullMap];
        NSLog(@"user has tapped the map");
    }];
    
    return self;
}
- (void)displayFullMap {
    NSLog(@"user has tapped the map");
    
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
    newRegion.span.latitudeDelta = 0.2;
    newRegion.span.longitudeDelta = 0.2;
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    
    request.naturalLanguageQuery = @"trivandrum";
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


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  
    mapTouchView.frame = mapView.frame;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", [locations lastObject]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 80, 80);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
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
