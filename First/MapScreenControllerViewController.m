//
//  MapScreenControllerViewController.m
//  First
//
//  Created by Arun Kumar on 16/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import "MapScreenControllerViewController.h"
#import "PlaceAnnotation.h"
@interface MapScreenControllerViewController ()

@end

@implementation MapScreenControllerViewController

@synthesize boundingRegion;
@synthesize mapItem;
@synthesize mapView;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSLog(@"%@",mapItem.name);
    
    
    // adjust the map to zoom/center to the annotations we want to show
    [self.mapView setRegion:self.boundingRegion];
    
    
    
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



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
