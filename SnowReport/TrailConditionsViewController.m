//
//  TrailConditionsViewController.m
//  SnowReport
//
//  Created by Philip Henson on 6/7/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import "TrailConditionsViewController.h"

@interface TrailConditionsViewController ()

@end

@implementation TrailConditionsViewController

@synthesize trailNames = _trailNames;
@synthesize trailStatus = _trailStatus;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trailNames = [NSArray arrayWithObjects:@"Murphy's Field (1.3k)", @"Round-a-bit (0.7k)", @"Duck Pond (2.9k)", @"Elinor's Trail (2.8k)", @"Round-a-lot (0.8k)", @"Lower Soccer Field (0.7k)", @"Upper Soccer Field (0.7k)", @"Big Hosmer Lake (7.5k)", @"Village Out & Back (13.6k)", @"Little Hosmer Lake (7.2k)", @"Cabin Trail (2.0k)", @"Lemon's Haunt (2.3k)", @"Ruthie's Run (8.5k)", @"Ruthie's-Sam's Alternate (9.3k)", @"Sam's Run (8.5k)", @"Max's Pond (2.8k)", @"Charley's Cabin Out & Back (7.6k)", @"Biathlon Trails (1.3k)", @"Grand Tour (16.7k)", @"Grand Tour Cutoff (13.0k)", @"Grand Tour w/extension (23.3k)", @"Wylie Hill Trail (9.0k)", @"Race Loop (5.5k)", @"Race Loop w/cutoff (4.6k)", @"Baily Hazen (3.7l)", @"To Highland Lodge (19.8k)", @"Patmos (5.0k)", @"Short and Long Barr Hill (6.0k)", @"Easy Rider - Beech Rd (10.0k)", @"Great Circle (16.0k)", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.trailNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:CellIdentifier];
    }
    
    NSString *cellTitle = [self.trailNames objectAtIndex:indexPath.row];
    cell.textLabel.text = cellTitle;
    
    NSString *cellDetail = [self.trailStatus objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = cellDetail;
    
    UIFont *tableViewFont = [UIFont fontWithName:@"Helvetica" size:12.0];
    cell.textLabel.font = tableViewFont;
    cell.detailTextLabel.font = tableViewFont;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
