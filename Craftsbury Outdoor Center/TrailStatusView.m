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
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
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
        NSArray *trailNote = [delegate.completeTrailData objectForKey:@"Note"];
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
        
        NSString *cellBotRightDetail = [trailNote objectAtIndex:indexPath.row];
        if (![[trailNote objectAtIndex:indexPath.row] isEqualToString:@"%nbsp"])
            cell.trailNoteLabel.text = [NSString stringWithFormat:@"Note: %@", cellBotRightDetail];
        else
            cell.trailNoteLabel.text = @"";
        
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

@end
