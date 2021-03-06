//
//  secondInterfaceController.h
//  First
//
//  Created by Arun Kumar on 31/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface SecondInterfaceController : WKInterfaceController


@property(nonatomic,weak) IBOutlet WKInterfaceLabel *eventName;
@property(nonatomic,weak) IBOutlet WKInterfaceLabel *eventLocation;
@property(nonatomic,weak) IBOutlet WKInterfaceLabel *eventTime;
@property(nonatomic,weak) IBOutlet WKInterfaceLabel *eventDate;

@end
