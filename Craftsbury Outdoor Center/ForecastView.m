//
//  SecondViewController.m
//  Craftsbury Outdoor Center
//
//  Created by Philip Henson on 12/1/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import "ForecastView.h"


@interface ForecastView ()

@end

@implementation ForecastView

@synthesize lastObservation = _lastObservation;
@synthesize previousUnits = _previousUnits;

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    AppDelegate *delegate = UIAppDelegate;
    
    // if data exists, populate page
    if (delegate.completeWeatherData){
        [self updateWeatherDetailUI];
    }
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void) viewDidAppear:(BOOL)animated
{
    
    AppDelegate *delegate = UIAppDelegate;
    
    // if data exists, check if page needs update
    if (delegate.completeWeatherData[0]){
        [self checkIfUpdateNeeded:delegate];
    }
    
}

- (void) checkIfUpdateNeeded:(AppDelegate *)delegate
{
    
    if (delegate.completeWeatherData){
        Observation *current = [delegate.completeWeatherData objectAtIndex:0];
        
        NSString *currentObservation = current.timeString;
        NSInteger currentUnits =[[NSUserDefaults standardUserDefaults] integerForKey:@"englishUnits"];
        
        // update if data is old or if user changed unit preference
        if ((![currentObservation isEqualToString:self.lastObservation]) || (currentUnits != self.previousUnits))
            [self updateWeatherDetailUI];
    }
    
}

- (void) updateWeatherDetailUI
{
    AppDelegate *delegate = UIAppDelegate;
    
    Observation *current = [delegate.completeWeatherData objectAtIndex:0];
    Observation *forecast = [delegate.completeWeatherData objectAtIndex:1];
    NSArray *hourly = [delegate.completeWeatherData objectAtIndex:2];
    
    
    // Temperatures and Wind Speeds
    NSDictionary *hourlyWindSpd = [hourly valueForKey:@"wspd"];
    NSArray *hourlyWindSpdEng = [hourlyWindSpd valueForKey:@"english"];
    NSArray *hourlyWindSpdMet = [hourlyWindSpd valueForKey:@"metric"];
    
    NSDictionary *hourlyTemp = [hourly valueForKey:@"temp"];
    NSArray *hourlyTempEng = [hourlyTemp valueForKey:@"english"];
    NSArray *hourlyTempMet = [hourlyTemp valueForKey:@"metric"];
    
    NSArray *forecastDay = [forecast.simpleForecast valueForKey:@"forecastday"];
    NSDictionary *upcomingHighs = [forecastDay valueForKey:@"high"];
    NSDictionary *upcomingLows = [forecastDay valueForKey:@"low"];
    NSArray *upcomingHighsF = [upcomingHighs valueForKey:@"fahrenheit"];
    NSArray *upcomingLowsF = [upcomingLows valueForKey:@"fahrenheit"];
    NSArray *upcomingHighsC = [upcomingHighs valueForKey:@"celsius"];
    NSArray *upcomingLowsC = [upcomingLows valueForKey:@"celsius"];
    
    NSDictionary *upcomingWind = [forecastDay valueForKey:@"avewind"];
    NSArray *upcomingWindMPH = [upcomingWind valueForKey:@"mph"];
    NSArray *upcomingWindKPH = [upcomingWind valueForKey:@"kph"];
    
    if (![[NSUserDefaults standardUserDefaults] integerForKey:@"englishUnits"]) {
        self.previousUnits = 0;
        
        self.detailTemp.text = [NSString stringWithFormat:@"%d°F", [current.temperatureF intValue]];
        self.detailWind.text = [NSString stringWithFormat:@"%d mph %@", [current.windSpeedMPH intValue], current.windDirection];
        
        self.hour1Wind.text = [NSString stringWithFormat:@"%d mph", [[hourlyWindSpdEng objectAtIndex:0] intValue]];
        self.hour2Wind.text = [NSString stringWithFormat:@"%d mph", [[hourlyWindSpdEng objectAtIndex:1] intValue]];
        self.hour3Wind.text = [NSString stringWithFormat:@"%d mph", [[hourlyWindSpdEng objectAtIndex:2] intValue]];
        self.hour4Wind.text = [NSString stringWithFormat:@"%d mph", [[hourlyWindSpdEng objectAtIndex:3] intValue]];
        
        self.hour1Temp.text = [NSString stringWithFormat:@"%d°", [[hourlyTempEng objectAtIndex:0] intValue]];
        self.hour2Temp.text = [NSString stringWithFormat:@"%d°", [[hourlyTempEng objectAtIndex:1] intValue]];
        self.hour3Temp.text = [NSString stringWithFormat:@"%d°", [[hourlyTempEng objectAtIndex:2] intValue]];
        self.hour4Temp.text = [NSString stringWithFormat:@"%d°", [[hourlyTempEng objectAtIndex:3] intValue]];
        
        self.detailHigh.text = [NSString stringWithFormat:@"H: %d°", [[upcomingHighsF objectAtIndex:0] intValue]];
        self.detailLow.text = [NSString stringWithFormat:@"L: %d°", [[upcomingLowsF objectAtIndex:0] intValue]];
        
        self.day1HiLow.text = [NSString stringWithFormat:@"%d°/%d°", [[upcomingHighsF objectAtIndex:1] intValue], [[upcomingLowsF objectAtIndex:1] intValue]];
        self.day2HiLow.text = [NSString stringWithFormat:@"%d°/%d°", [[upcomingHighsF objectAtIndex:2] intValue], [[upcomingLowsF objectAtIndex:2] intValue]];
        self.day3HiLow.text = [NSString stringWithFormat:@"%d°/%d°", [[upcomingHighsF objectAtIndex:3] intValue], [[upcomingLowsF objectAtIndex:3] intValue]];
        
        self.day1Wind.text = [NSString stringWithFormat:@"%d mph", [[upcomingWindMPH objectAtIndex:1] intValue]];
        self.day2Wind.text = [NSString stringWithFormat:@"%d mph", [[upcomingWindMPH objectAtIndex:2] intValue]];
        self.day3Wind.text = [NSString stringWithFormat:@"%d mph", [[upcomingWindMPH objectAtIndex:3] intValue]];
    } else {
        
        self.previousUnits = 1;
        self.detailTemp.text = [NSString stringWithFormat:@"%d°C", [current.temperatureC intValue]];
        self.detailWind.text = [NSString stringWithFormat:@"%d km/h %@", [current.windSpeedKPH intValue], current.windDirection];
        
        self.hour1Wind.text = [NSString stringWithFormat:@"%d km/h", [[hourlyWindSpdMet objectAtIndex:0] intValue]];
        self.hour2Wind.text = [NSString stringWithFormat:@"%d km/h", [[hourlyWindSpdMet objectAtIndex:1] intValue]];
        self.hour3Wind.text = [NSString stringWithFormat:@"%d km/h", [[hourlyWindSpdMet objectAtIndex:2] intValue]];
        self.hour4Wind.text = [NSString stringWithFormat:@"%d km/h", [[hourlyWindSpdMet objectAtIndex:3] intValue]];
        
        self.hour1Temp.text = [NSString stringWithFormat:@"%d°", [[hourlyTempMet objectAtIndex:0] intValue]];
        self.hour2Temp.text = [NSString stringWithFormat:@"%d°", [[hourlyTempMet objectAtIndex:1] intValue]];
        self.hour3Temp.text = [NSString stringWithFormat:@"%d°", [[hourlyTempMet objectAtIndex:2] intValue]];
        self.hour4Temp.text = [NSString stringWithFormat:@"%d°", [[hourlyTempMet objectAtIndex:3] intValue]];
        
        self.detailHigh.text = [NSString stringWithFormat:@"H: %d°", [[upcomingHighsC objectAtIndex:0] intValue]];
        self.detailLow.text = [NSString stringWithFormat:@"L: %d°", [[upcomingLowsC objectAtIndex:0] intValue]];
        
        self.day1HiLow.text = [NSString stringWithFormat:@"%d°/%d°", [[upcomingHighsC objectAtIndex:1] intValue], [[upcomingLowsF objectAtIndex:1] intValue]];
        self.day2HiLow.text = [NSString stringWithFormat:@"%d°/%d°", [[upcomingHighsC objectAtIndex:2] intValue], [[upcomingLowsF objectAtIndex:2] intValue]];
        self.day3HiLow.text = [NSString stringWithFormat:@"%d°/%d°", [[upcomingHighsC objectAtIndex:3] intValue], [[upcomingLowsF objectAtIndex:3] intValue]];
        
        self.day1Wind.text = [NSString stringWithFormat:@"%d km/h", [[upcomingWindKPH objectAtIndex:1] intValue]];
        self.day2Wind.text = [NSString stringWithFormat:@"%d km/h", [[upcomingWindKPH objectAtIndex:2] intValue]];
        self.day3Wind.text = [NSString stringWithFormat:@"%d km/h", [[upcomingWindKPH objectAtIndex:3] intValue]];
    }
    
    // CURRENT WEATHER
    self.detailConditions.text = current.weatherDescription;
    self.lastObservation = current.timeString;
    self.lastUpdated.text = [NSString stringWithFormat:@"Last Updated: %@", [current.localTimeString stringByReplacingOccurrencesOfString:@"-0500" withString:@""]];
    self.detailConditionsIcon.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[current.iconUrl stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
    self.detailPrecipitation.text = [NSString stringWithFormat:@"%@", current.precipTodayString];
    NSArray *upcomingPop = [[forecast.textForecast valueForKey:@"forecastday"] valueForKey:@"pop"];
    self.detailPop.text = [NSString stringWithFormat:@"%d%%", [[upcomingPop objectAtIndex:0] intValue]];
    
    // HOURLY FORECAST
    NSDictionary *forecastTimeInfo = [hourly valueForKey:@"FCTTIME"];
    NSArray *timeStringArray = [forecastTimeInfo valueForKey:@"civil"];
    self.hour1.text = [timeStringArray[0] stringByReplacingOccurrencesOfString:@":00 " withString:@""];
    self.hour2.text = [timeStringArray[1] stringByReplacingOccurrencesOfString:@":00 " withString:@""];
    self.hour3.text = [timeStringArray[2] stringByReplacingOccurrencesOfString:@":00 " withString:@""];
    self.hour4.text = [timeStringArray[3] stringByReplacingOccurrencesOfString:@":00 " withString:@""];
    
    NSArray *hourlyPop = [hourly valueForKey:@"pop"];
    
    self.hour1Pop.text = [NSString stringWithFormat:@"%d%%", [[hourlyPop objectAtIndex:0] intValue]];
    self.hour2Pop.text = [NSString stringWithFormat:@"%d%%", [[hourlyPop objectAtIndex:1] intValue]];
    self.hour3Pop.text = [NSString stringWithFormat:@"%d%%", [[hourlyPop objectAtIndex:2] intValue]];
    self.hour4Pop.text = [NSString stringWithFormat:@"%d%%", [[hourlyPop objectAtIndex:3] intValue]];
    
    NSArray *hourlyImgURLs = [hourly valueForKey:@"icon_url"];
    
    self.hour1Img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[hourlyImgURLs objectAtIndex:0] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
    self.hour2Img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[hourlyImgURLs objectAtIndex:1] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
    self.hour3Img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[hourlyImgURLs objectAtIndex:2] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
    self.hour4Img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[hourlyImgURLs objectAtIndex:3] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
    
    
    // 3-DAY FORECAST
    
    NSDictionary *dateInfo = [forecastDay valueForKey:@"date"];
    NSArray *upcomingDays = [NSArray arrayWithArray:[dateInfo valueForKey:@"weekday"]];
    NSArray *upcomingImgURLs = [forecastDay valueForKey:@"icon_url"];
    
    self.detailPop.text = [NSString stringWithFormat:@"%d%%", [[upcomingPop objectAtIndex:0] intValue]];
    
    self.day1.text = [upcomingDays objectAtIndex:1];
    self.day2.text = [upcomingDays objectAtIndex:2];
    self.day3.text = [upcomingDays objectAtIndex:3];
    
    self.day1Pop.text = [NSString stringWithFormat:@"%d%%", [[upcomingPop objectAtIndex:1] intValue]];
    self.day2Pop.text = [NSString stringWithFormat:@"%d%%", [[upcomingPop objectAtIndex:2] intValue]];
    self.day3Pop.text = [NSString stringWithFormat:@"%d%%", [[upcomingPop objectAtIndex:3] intValue]];
    
    self.day1Img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[upcomingImgURLs objectAtIndex:1] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
    self.day2Img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[upcomingImgURLs objectAtIndex:2] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
    self.day3Img.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[upcomingImgURLs objectAtIndex:3] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
    
}



-(void) onAppSettingsChanged:(NSNotification*)notification
{
    [self updateWeatherDetailUI];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MyAppSettingsChanged" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
