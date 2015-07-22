//
//  CalController.h
//  First
//
//  Created by Arun Kumar on 21/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalController : UIViewController
{

    NSString *stack;
    double result;
    int optype;

}


@property (nonatomic, weak) IBOutlet UILabel *console;
@property (weak, nonatomic) IBOutlet UILabel *opperator;

@end
