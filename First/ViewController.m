//
//  ViewController.m
//  First
//
//  Created by Arun Kumar on 14/07/15.
//  Copyright © 2015 Arun Kumar. All rights reserved.
//

#import "ViewController.h"
#import "SimpleTableCell.h"
#import "DetailsViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    events=[[NSMutableArray alloc] init];
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"details" ofType:@"txt" ];
       NSString* content = [NSString stringWithContentsOfFile:filePath  encoding:NSUTF8StringEncoding error:NULL];
    
    NSData* myData = [content dataUsingEncoding:NSUTF8StringEncoding];
    if (myData) {
        // do something useful
        
       id publicTimeline = [NSJSONSerialization JSONObjectWithData:myData options:0 error:nil];
        
        for (int i=0; i<[publicTimeline count]; i++) {
            NSDictionary *arrayResult = [publicTimeline objectAtIndex:i];
            //NSLog(@"name=%@",[arrayResult objectForKey:@"colorName"]);
            
            details=[[Event alloc] init];
            details.name=[arrayResult objectForKey:@"Name"];
            details.date=[arrayResult objectForKey:@"Date"];
            details.location=[arrayResult objectForKey:@"Location"];
            details.time=[arrayResult objectForKey:@"Time"];
            details.rating=[arrayResult objectForKey:@"Rating"];
            details.ID=[arrayResult objectForKey:@"Id"];
            details.desc=[arrayResult objectForKey:@"Description"];
            details.address=[arrayResult objectForKey:@"Address"];

            
            
            
            [events addObject:details];
            
            

            NSLog(@"name=%@",[arrayResult objectForKey:@"Name"]);
            
        }
          }
   
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction Methods

- (IBAction)showMessage
{
    mytext.text=@"text changed for button pressw";
    
    }


#pragma mark - UITableView delegate methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [events count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       static NSString *simpleTableIdentifier = @"RecipeCell";
    
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[SimpleTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    Event *tmp=[[Event alloc] init];
    tmp=[events objectAtIndex:indexPath.row];
    //cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.nameLabel.text = tmp.name;
    cell.time.text=tmp.time;
    cell.venue.text=tmp.location;
    cell.date.text=tmp.date;
   

    
    
    int x = [  tmp.rating intValue];
    NSLog(@"%i",x);//cell.thumbnailImageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    //cell.prepTimeLabel.text = [prepTime objectAtIndex:indexPath.row];
    switch (x) {
        case 1:
            cell.ratestar.image = [UIImage imageNamed:@"1star"];
            break;
        case 2:
            cell.ratestar.image = [UIImage imageNamed:@"2star"];

            break;
        case 3:
            cell.ratestar.image = [UIImage imageNamed:@"3star"];

            break;
        case 4:
            cell.ratestar.image = [UIImage imageNamed:@"4star"];

            break;
        case 5:
            cell.ratestar.image = [UIImage imageNamed:@"5star"];

            break;
            
            
        default:
            cell.ratestar.image = [UIImage imageNamed:@"1star"];
            break;
    }
cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell"] ] ;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailsViewController *destViewController = segue.destinationViewController;
        
        
        destViewController.deta=[events objectAtIndex:indexPath.row];
        
        
        
    }
}

@end
