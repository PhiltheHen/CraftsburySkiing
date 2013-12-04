//
//  InfoView.h
//  Craftsbury Outdoor Center
//
//  Created by Philip Henson on 12/1/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoView : UIViewController


@property (weak, nonatomic) IBOutlet UISegmentedControl *unitsSegment;

-(IBAction)changeUnits;

@end
