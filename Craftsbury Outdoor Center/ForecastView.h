//
//  SecondViewController.h
//  Craftsbury Outdoor Center
//
//  Created by Philip Henson on 12/1/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Observation.h"
#import "AppDelegate.h"
#import "WeatherRequest.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface ForecastView : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *detailTemp;
@property (weak, nonatomic) IBOutlet UIImageView *detailConditionsIcon;
@property (weak, nonatomic) IBOutlet UILabel *detailConditions;
@property (weak, nonatomic) IBOutlet UILabel *detailHigh;
@property (weak, nonatomic) IBOutlet UILabel *detailLow;
@property (weak, nonatomic) IBOutlet UILabel *detailWind;
@property (weak, nonatomic) IBOutlet UILabel *detailPop;
@property (weak, nonatomic) IBOutlet UILabel *detailPrecipitation;
@property (weak, nonatomic) IBOutlet UILabel *hour1;
@property (weak, nonatomic) IBOutlet UILabel *hour2;
@property (weak, nonatomic) IBOutlet UILabel *hour3;
@property (weak, nonatomic) IBOutlet UILabel *hour4;
@property (weak, nonatomic) IBOutlet UILabel *hour1Temp;

@property (weak, nonatomic) IBOutlet UILabel *hour1Wind;
@property (weak, nonatomic) IBOutlet UILabel *hour1Pop;
@property (weak, nonatomic) IBOutlet UILabel *hour2Temp;
@property (weak, nonatomic) IBOutlet UILabel *hour2Wind;
@property (weak, nonatomic) IBOutlet UILabel *hour2Pop;
@property (weak, nonatomic) IBOutlet UILabel *hour3Temp;
@property (weak, nonatomic) IBOutlet UILabel *hour3Wind;
@property (weak, nonatomic) IBOutlet UILabel *hour3Pop;
@property (weak, nonatomic) IBOutlet UILabel *hour4Temp;
@property (weak, nonatomic) IBOutlet UILabel *hour4Wind;
@property (weak, nonatomic) IBOutlet UILabel *hour4Pop;
@property (weak, nonatomic) IBOutlet UIImageView *hour1Img;
@property (weak, nonatomic) IBOutlet UIImageView *hour2Img;
@property (weak, nonatomic) IBOutlet UIImageView *hour3Img;
@property (weak, nonatomic) IBOutlet UIImageView *hour4Img;
@property (weak, nonatomic) IBOutlet UILabel *day1;
@property (weak, nonatomic) IBOutlet UIImageView *day1Img;
@property (weak, nonatomic) IBOutlet UILabel *day1HiLow;
@property (weak, nonatomic) IBOutlet UILabel *day1Wind;
@property (weak, nonatomic) IBOutlet UILabel *day1Pop;
@property (weak, nonatomic) IBOutlet UILabel *day2;
@property (weak, nonatomic) IBOutlet UIImageView *day2Img;
@property (weak, nonatomic) IBOutlet UILabel *day2HiLow;
@property (weak, nonatomic) IBOutlet UILabel *day2Wind;
@property (weak, nonatomic) IBOutlet UILabel *day2Pop;
@property (weak, nonatomic) IBOutlet UILabel *day3;
@property (weak, nonatomic) IBOutlet UIImageView *day3Img;
@property (weak, nonatomic) IBOutlet UILabel *day3HiLow;
@property (weak, nonatomic) IBOutlet UILabel *day3Wind;
@property (weak, nonatomic) IBOutlet UILabel *day3Pop;

@property (weak, nonatomic) IBOutlet UILabel *lastUpdated;

-(void)updateWeatherDetailUI;

@end
