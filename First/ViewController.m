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
    
   tableData=[[NSMutableArray alloc] init];
    tme=[[NSMutableArray alloc] init];
    rat=[[NSMutableArray alloc] init];
    dat=[[NSMutableArray alloc] init];

    ven=[[NSMutableArray alloc] init];
    description=[[NSMutableArray alloc] init];
    EventId=[[NSMutableArray alloc] init];
    Address=[[NSMutableArray alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"details" ofType:@"txt" ];
       NSString* content = [NSString stringWithContentsOfFile:filePath  encoding:NSUTF8StringEncoding error:NULL];
    
    NSData* myData = [content dataUsingEncoding:NSUTF8StringEncoding];
    if (myData) {
        // do something useful
        
       id publicTimeline = [NSJSONSerialization JSONObjectWithData:myData options:0 error:nil];
        
        for (int i=0; i<[publicTimeline count]; i++) {
            NSDictionary *arrayResult = [publicTimeline objectAtIndex:i];
            //NSLog(@"name=%@",[arrayResult objectForKey:@"colorName"]);
            NSString *nam=[arrayResult objectForKey:@"Name"];
             NSString *dt=[arrayResult objectForKey:@"Date"];
             NSString *vn=[arrayResult objectForKey:@"Location"];
             NSString *tm=[arrayResult objectForKey:@"Time"];
            NSString *rt=[arrayResult objectForKey:@"Rating"];
            NSString *Id=[arrayResult objectForKey:@"Id"];
            NSString *desc=[arrayResult objectForKey:@"Description"];
            NSString *addr=[arrayResult objectForKey:@"Address"];

            [tableData addObject:  nam];
            [tme addObject:  tm];
            [dat addObject:  dt];
            [ven addObject:  vn];
            [rat addObject:rt];
            [description addObject:desc];
            [EventId addObject:Id];
            
            [Address addObject:addr];



            NSLog(@"name=%@",[arrayResult objectForKey:@"Name"]);
            
        }
          }
    // Do any additional setup after loading the view, typically from a nib.
   // tableData = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];

    // Initialize thumbnails
    thumbnails = [NSArray arrayWithObjects:@"egg_benedict.jpg", @"mushroom_risotto.jpg", @"full_breakfast.jpg", @"hamburger.jpg", @"ham_and_egg_sandwich.jpg", @"creme_brelee.jpg", @"white_chocolate_donut.jpg", @"starbucks_coffee.jpg", @"vegetable_curry.jpg", @"instant_noodle_with_egg.jpg", @"noodle_with_bbq_pork.jpg", @"japanese_noodle_with_pork.jpg", @"green_tea.jpg", @"thai_shrimp_cake.jpg", @"angry_birds_cake.jpg", @"ham_and_cheese_panini.jpg", nil];
    prepTime = [NSArray arrayWithObjects:@"2", @"2", @"2", @"2", @"2", @"2", @"2", @"2", @"2", @"2", @"2", @"2", @"2", @"2", @"2", @"2", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showMessage
{
    mytext.text=@"text changed for button pressw";
    
    }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       static NSString *simpleTableIdentifier = @"RecipeCell";
    
   // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[SimpleTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.nameLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.time.text=[tme objectAtIndex:indexPath.row];
    cell.venue.text=[ven objectAtIndex:indexPath.row];
    cell.date.text=[dat objectAtIndex:indexPath.row];
   

    
    
    int x = [[rat  objectAtIndex:indexPath.row]intValue];
    NSLog(@"%i",x);//cell.thumbnailImageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    //cell.prepTimeLabel.text = [prepTime objectAtIndex:indexPath.row];
    switch (x) {
        case 1:
            cell.ratestar.image = [UIImage imageNamed:@"1s.png"];
            break;
        case 2:
            cell.ratestar.image = [UIImage imageNamed:@"2s.png"];

            break;
        case 3:
            cell.ratestar.image = [UIImage imageNamed:@"3s.png"];

            break;
        case 4:
            cell.ratestar.image = [UIImage imageNamed:@"4s.png"];

            break;
        case 5:
            cell.ratestar.image = [UIImage imageNamed:@"5s.png"];

            break;
            
            
        default:
            cell.ratestar.image = [UIImage imageNamed:@"1s.png"];
            break;
    }
cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgg.png"] ] ;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 145;
}
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    [messageAlert show];
    
}
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailsViewController *destViewController = segue.destinationViewController;
        destViewController.recipeName = [tableData objectAtIndex:indexPath.row];
        destViewController.ID = [EventId objectAtIndex:indexPath.row];
        destViewController.Location = [ven objectAtIndex:indexPath.row];
        destViewController.Date = [dat objectAtIndex:indexPath.row];
        destViewController.Time = [tme objectAtIndex:indexPath.row];
        destViewController.Description = [description objectAtIndex:indexPath.row];
        destViewController.Rating = [rat objectAtIndex:indexPath.row];
        destViewController.Address = [Address objectAtIndex:indexPath.row];
        
        
    }
}

@end
