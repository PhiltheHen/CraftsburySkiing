//
//  InfoViewController.m
//  SnowReport
//
//  Created by Philip Henson on 6/4/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.infoText1.editable = NO;
    self.infoText2.editable = NO;
    self.infoText3.editable = NO;
    self.infoText1.dataDetectorTypes = UIDataDetectorTypeAll;
    self.infoText2.dataDetectorTypes = UIDataDetectorTypeAll;
    self.infoText3.dataDetectorTypes = UIDataDetectorTypeAll;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
