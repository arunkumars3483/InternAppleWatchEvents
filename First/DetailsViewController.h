//
//  DetailsViewController.h
//  First
//
//  Created by Arun Kumar on 15/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/Corelocation.h>
@interface DetailsViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{
    IBOutlet UIView* mapTouchView;
}

@property (nonatomic, strong) IBOutlet UILabel *recipeLabel;
@property (nonatomic, strong) IBOutlet UIView *bc;
@property (nonatomic, strong) NSString *recipeName;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *Time;
@property (nonatomic, strong) NSString *Date;
@property (nonatomic, strong) NSString *Description;
@property (nonatomic, strong) NSString *Location;
@property (nonatomic, strong) NSString *Address;
@property (nonatomic, strong) NSString *Rating;
@property (nonatomic, strong) IBOutlet UILabel *loc;
@property (nonatomic, strong) IBOutlet UILabel *addr;
@property (nonatomic, strong) IBOutlet UILabel *dat;
@property (nonatomic, strong) IBOutlet UILabel *tim;
@property (nonatomic, strong) IBOutlet UILabel *rat;
@property (nonatomic, strong) IBOutlet UILabel *des;

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationmanager;
@property (nonatomic, strong) NSArray *places;
@property (nonatomic, strong) NSArray *mapItemList;
@property (nonatomic, assign) MKCoordinateRegion boundingRegion;

@end
