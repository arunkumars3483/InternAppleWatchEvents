//
//  InterfaceController.h
//  First WatchKit 1 Extension
//
//  Created by Arun Kumar on 23/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController
@property(nonatomic,weak) IBOutlet WKInterfaceLabel *ev;
@property (weak, nonatomic) IBOutlet WKInterfaceTable* table;
@property (nonatomic,strong) NSMutableArray *devices;

@end
