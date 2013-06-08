//
//  WeatherViewController.m
//  SnowReport
//
//  Created by Philip Henson on 4/28/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

@synthesize craftsburyDetailWeather = _craftsburyDetailWeather;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *currentWeather = [self.craftsburyDetailWeather objectForKey:@"current_observation"];

    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[currentWeather valueForKey:@"icon_url"] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]];
    UIImage *image = [UIImage imageWithData:imageData];
    
    self.detailConditions.text = [currentWeather valueForKey:@"weather"];
    self.detailTemp.text = [NSString stringWithFormat:@"%d°F", [[currentWeather valueForKey:@"temp_f"] integerValue]];
    self.detailWeatherImage.image = image;
    self.detailWind.text = [NSString stringWithFormat:@"%d mph %@", [[currentWeather valueForKey:@"wind_mph"] integerValue], [currentWeather valueForKey:@"wind_dir"]];
    
    // ***************** 3 - DAY FORECAST **********************
    
    NSDictionary *overallForecast = [self.craftsburyDetailWeather objectForKey:@"forecast"];
    NSDictionary *simpleForecast = [overallForecast objectForKey:@"simpleforecast"];
    NSDictionary *forecastDay = [simpleForecast objectForKey:@"forecastday"];
    NSDictionary *date = [forecastDay valueForKey:@"date"];
    NSArray *upcomingDays = [NSArray arrayWithArray:[date valueForKey:@"weekday"]];
    NSDictionary *upcomingHighs = [forecastDay valueForKey:@"high"];
    NSDictionary *upcomingLows = [forecastDay valueForKey:@"low"];
    NSArray *upcomingHighsF = [upcomingHighs valueForKey:@"fahrenheit"];
    NSArray *upcomingLowsF = [upcomingLows valueForKey:@"fahrenheit"];
    NSArray *upcomingHighsC = [upcomingHighs valueForKey:@"celsius"];
    NSArray *upcomingLowsC = [upcomingLows valueForKey:@"celsius"];
    
    NSDictionary *upcomingWind = [forecastDay valueForKey:@"avewind"];
    NSArray *upcomingWindMPH = [upcomingWind valueForKey:@"mph"];
    NSArray *upcomingWindDir = [upcomingWind valueForKey:@"dir"];
    
    NSArray *upcomingPop = [forecastDay valueForKey:@"pop"];
    
    NSArray *upcomingImgURLs = [forecastDay valueForKey:@"icon_url"];
    
    self.detailPop.text = [NSString stringWithFormat:@"%d%%", [[upcomingPop objectAtIndex:0] integerValue]];
    self.detailHigh.text = [NSString stringWithFormat:@"H: %d°", [[upcomingHighsF objectAtIndex:0] integerValue]];
    self.detailLow.text = [NSString stringWithFormat:@"L: %d°", [[upcomingLowsF objectAtIndex:0] integerValue]];
    
    self.day1.text = [upcomingDays objectAtIndex:1];
    self.day2.text = [upcomingDays objectAtIndex:2];
    self.day3.text = [upcomingDays objectAtIndex:3];
    
    self.day1HiLow.text = [NSString stringWithFormat:@"%d°/%d°", [[upcomingHighsF objectAtIndex:1] integerValue], [[upcomingLowsF objectAtIndex:1] integerValue]];
    self.day2HiLow.text = [NSString stringWithFormat:@"%d°/%d°", [[upcomingHighsF objectAtIndex:2] integerValue], [[upcomingLowsF objectAtIndex:2] integerValue]];
    self.day3HiLow.text = [NSString stringWithFormat:@"%d°/%d°", [[upcomingHighsF objectAtIndex:3] integerValue], [[upcomingLowsF objectAtIndex:3] integerValue]];
    
    self.day1Wind.text = [NSString stringWithFormat:@"%d mph", [[upcomingWindMPH objectAtIndex:1] integerValue]];
    self.day2Wind.text = [NSString stringWithFormat:@"%d mph", [[upcomingWindMPH objectAtIndex:2] integerValue]];
    self.day3Wind.text = [NSString stringWithFormat:@"%d mph", [[upcomingWindMPH objectAtIndex:3] integerValue]];
    
    self.day1Pop.text = [NSString stringWithFormat:@"%d%%", [[upcomingPop objectAtIndex:1] integerValue]];
    self.day2Pop.text = [NSString stringWithFormat:@"%d%%", [[upcomingPop objectAtIndex:2] integerValue]];
    self.day3Pop.text = [NSString stringWithFormat:@"%d%%", [[upcomingPop objectAtIndex:3] integerValue]];
    
    self.day1Img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[upcomingImgURLs objectAtIndex:1] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
    self.day2Img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[upcomingImgURLs objectAtIndex:2] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
    self.day3Img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[upcomingImgURLs objectAtIndex:3] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];

    
    // ***************** HOURLY FORECAST *********************
    
    NSDictionary *completeHourlyForecast = [self.craftsburyDetailWeather objectForKey:@"hourly_forecast"];
    NSDictionary *hourlyForecast = [completeHourlyForecast valueForKey:@"FCTTIME"];
    NSArray *timeString = [hourlyForecast valueForKey:@"civil"];
    
    self.hour1.text = [[timeString objectAtIndex:0] stringByReplacingOccurrencesOfString:@":00 " withString:@""];
    self.hour2.text = [[timeString objectAtIndex:1] stringByReplacingOccurrencesOfString:@":00 " withString:@""];
    self.hour3.text = [[timeString objectAtIndex:2] stringByReplacingOccurrencesOfString:@":00 " withString:@""];
    self.hour4.text = [[timeString objectAtIndex:3] stringByReplacingOccurrencesOfString:@":00 " withString:@""];
    
    NSDictionary *hourlyTempDict = [completeHourlyForecast valueForKey:@"temp"];
    NSArray *hourlyTempEng = [hourlyTempDict valueForKey:@"english"];
    NSArray *hourlyTempMet = [hourlyTempDict valueForKey:@"metric"];
    
    self.hour1Temp.text = [NSString stringWithFormat:@"%d°", [[hourlyTempEng objectAtIndex:0] integerValue]];
    self.hour2Temp.text = [NSString stringWithFormat:@"%d°", [[hourlyTempEng objectAtIndex:1] integerValue]];
    self.hour3Temp.text = [NSString stringWithFormat:@"%d°", [[hourlyTempEng objectAtIndex:2] integerValue]];
    self.hour4Temp.text = [NSString stringWithFormat:@"%d°", [[hourlyTempEng objectAtIndex:3] integerValue]];
    
    NSDictionary *hourlyWindSpd = [completeHourlyForecast valueForKey:@"wspd"];
    NSArray *hourlyWindSpdEng = [hourlyWindSpd valueForKey:@"english"];
    NSArray *hourlyWindSpdMet = [hourlyWindSpd valueForKey:@"metric"];
    NSArray *hourlyWindDir = [[completeHourlyForecast valueForKey:@"wdir"] valueForKey:@"dir"];
    
    self.hour1Wind.text = [NSString stringWithFormat:@"%d mph", [[hourlyWindSpdEng objectAtIndex:0] integerValue]];
    self.hour2Wind.text = [NSString stringWithFormat:@"%d mph", [[hourlyWindSpdEng objectAtIndex:1] integerValue]];
    self.hour3Wind.text = [NSString stringWithFormat:@"%d mph", [[hourlyWindSpdEng objectAtIndex:2] integerValue]];
    self.hour4Wind.text = [NSString stringWithFormat:@"%d mph", [[hourlyWindSpdEng objectAtIndex:3] integerValue]];
    
    NSArray *hourlyPop = [completeHourlyForecast valueForKey:@"pop"];
    
    self.hour1Pop.text = [NSString stringWithFormat:@"%d%%", [[hourlyPop objectAtIndex:0] integerValue]];
    self.hour2Pop.text = [NSString stringWithFormat:@"%d%%", [[hourlyPop objectAtIndex:1] integerValue]];
    self.hour3Pop.text = [NSString stringWithFormat:@"%d%%", [[hourlyPop objectAtIndex:2] integerValue]];
    self.hour4Pop.text = [NSString stringWithFormat:@"%d%%", [[hourlyPop objectAtIndex:3] integerValue]];
    
    NSArray *hourlyImgURLs = [completeHourlyForecast valueForKey:@"icon_url"];
    
    self.hour1Img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[hourlyImgURLs objectAtIndex:0] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
    self.hour2Img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[hourlyImgURLs objectAtIndex:1] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
    self.hour3Img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[hourlyImgURLs objectAtIndex:2] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
    self.hour4Img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[hourlyImgURLs objectAtIndex:3] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
