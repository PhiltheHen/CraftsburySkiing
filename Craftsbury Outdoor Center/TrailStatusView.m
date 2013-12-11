//
//  ThirdViewController.m
//  Craftsbury Outdoor Center
//
//  Created by Philip Henson on 12/1/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import "TrailStatusView.h"

@interface TrailStatusView ()

@end

@implementation TrailStatusView

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
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
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
    AppDelegate *delegate = UIAppDelegate;
    
    if (delegate.completeTrailData){
        NSInteger rows = (NSInteger) [[delegate.completeTrailData objectForKey:@"Name"] count];
        return rows;
    }
    else{
        return 0;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *delegate = UIAppDelegate;
    
    
    
    static NSString *CellIdentifier = @"trailCell";
    TrailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TrailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (delegate.completeTrailData) {
        
        NSArray *trailNames = [delegate.completeTrailData objectForKey:@"Name"];
        NSArray *trailLength = [delegate.completeTrailData objectForKey:@"Length"];
        NSArray *trailTracked = [delegate.completeTrailData objectForKey:@"Tracked"];
        NSArray *trailGroomed = [delegate.completeTrailData objectForKey:@"Groomed"];
        NSArray *trailStatus = [delegate.completeTrailData objectForKey:@"Status"];
        NSArray *trailDifficulty = [delegate.completeTrailData objectForKey:@"Difficulty"];
        
        NSString *cellTitle = [NSString stringWithFormat:@"%@ (%@)", [trailNames objectAtIndex:indexPath.row], [trailLength objectAtIndex:indexPath.row]];
        cell.trailNameLabel.text = cellTitle;
        cell.trailNameLabel.adjustsFontSizeToFitWidth = YES;
        
        NSString *cellRightDetail = [trailStatus objectAtIndex:indexPath.row];
        
        if ([cellRightDetail isEqualToString:@"OPEN"]){
            cell.trailOpenLabel.text = cellRightDetail;
            cell.trailClosedLabel.text = @"";
        }
        else {
            cell.trailClosedLabel.text = cellRightDetail;
            cell.trailOpenLabel.text = @"";
        }
        
        NSString *cellBotLeftDetail = [trailGroomed objectAtIndex:indexPath.row];
        if (![[trailGroomed objectAtIndex:indexPath.row] isEqualToString:@"%nbsp"])
            cell.trailGroomedLabel.text = [NSString stringWithFormat:@"Groomed: %@", cellBotLeftDetail];
        else
            cell.trailGroomedLabel.text = @"";
        
        NSString *cellBotRightDetail = [trailTracked objectAtIndex:indexPath.row];
        if (![[trailTracked objectAtIndex:indexPath.row] isEqualToString:@"%nbsp"])
            cell.trailTrackedLabel.text = [NSString stringWithFormat:@"Tracked: %@", cellBotRightDetail];
        else
            cell.trailTrackedLabel.text = @"";
        
        NSString *cellImageKey = [trailDifficulty objectAtIndex:indexPath.row];
        
        if ([cellImageKey isEqualToString:@"beginner"]){
            cell.trailUIIcon.image = [UIImage imageNamed:@"beginnerTrail"];
        }
        else if ([cellImageKey isEqualToString:@"intermediate"])
            cell.trailUIIcon.image = [UIImage imageNamed:@"intermediateTrail"];
        else if ([cellImageKey isEqualToString:@"advanced"])
            cell.trailUIIcon.image = [UIImage imageNamed:@"advancedTrail"];
        else
            cell.trailUIIcon.image = [UIImage imageNamed:@"unknownTrail"];
    }
    
    
    
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

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
