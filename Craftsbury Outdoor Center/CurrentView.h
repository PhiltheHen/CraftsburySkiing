//
//  FirstViewController.h
//  Craftsbury Outdoor Center
//
//  Created by Philip Henson on 12/1/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "Observation.h"
#import "Reachability.h"
#import "WeatherRequest.h"

// THIS IS A TEST

@interface CurrentView : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *conditionsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *conditionsIcon;
@property (weak, nonatomic) IBOutlet UILabel *kmOpenLabel;

@property (weak, nonatomic) IBOutlet UILabel *snowfallLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdatedLabel;

@property (strong, nonatomic) Reachability *internetReachable;
@property (strong, nonatomic) Reachability *hostReachable;

- (void) parseHTMLFileAtURL;

- (IBAction)refresh:(id)sender;

+ (BOOL)getConnectivity;
+ (BOOL)getConnectivityViaWiFiNetwork;
+ (BOOL)getConnectivityViaCarrierDataNetwork;

@end
