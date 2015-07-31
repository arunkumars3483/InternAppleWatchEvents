//
//  DetailsViewController.h
//  First
//
//  Created by Arun Kumar on 15/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Event.h"
#import <CoreLocation/Corelocation.h>
@interface DetailsViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{
}
-(IBAction)dismisswindow;
@property (nonatomic, strong) IBOutlet UILabel *recipeLabel;

@property (strong) NSMutableArray *devices;
@property (nonatomic, weak) IBOutlet UIView *bc;
@property (nonatomic, weak) IBOutlet UILabel *loc;
@property (nonatomic, weak) IBOutlet UILabel *addr;
@property (nonatomic, weak) IBOutlet UILabel *dat;
@property (nonatomic, weak) IBOutlet UILabel *tim;
@property (nonatomic, weak) IBOutlet UIImageView *star1;
@property (nonatomic, weak) IBOutlet UIImageView *star2;
@property (nonatomic, weak) IBOutlet UIImageView *star3;
@property (nonatomic, weak) IBOutlet UIImageView *star4;
@property (nonatomic, weak) IBOutlet UIImageView *star5;
@property (nonatomic, weak) IBOutlet UILabel *des;


@property (nonatomic, strong) Event *deta;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationmanager;
@property (nonatomic, strong) NSArray *places;
@property (nonatomic, strong) NSArray *mapItemList;
@property (nonatomic, assign) MKCoordinateRegion boundingRegion;

@end
