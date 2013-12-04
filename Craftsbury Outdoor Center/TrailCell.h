//
//  TrailCell.h
//  Craftsbury Outdoor Center
//
//  Created by Philip Henson on 12/2/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *trailNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *trailGroomedLabel;
@property (weak, nonatomic) IBOutlet UILabel *trailTrackedLabel;
@property (weak, nonatomic) IBOutlet UILabel *trailOpenLabel;
@property (weak, nonatomic) IBOutlet UILabel *trailClosedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *trailUIIcon;

@end
