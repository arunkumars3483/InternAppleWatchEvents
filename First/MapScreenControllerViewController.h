//
//  MapScreenControllerViewController.h
//  First
//
//  Created by Arun Kumar on 16/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/mapKit.h>
@interface MapScreenControllerViewController : UIViewController
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, assign) MKCoordinateRegion boundingRegion;
@property (nonatomic,assign)  MKMapItem *mapItem;
@end
