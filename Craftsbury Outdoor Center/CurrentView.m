//
//  FirstViewController.m
//  Craftsbury Outdoor Center
//
//  Created by Philip Henson on 12/1/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import "CurrentView.h"


@interface CurrentView ()

@end

@implementation CurrentView

@synthesize internetReachable = _internetReachable;
@synthesize hostReachable = _hostReachable;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // if network connection, get data
    
    self.internetReachable = [Reachability reachabilityForInternetConnection];
    
    if ([CurrentView getConnectivity]) {
        [self reloadData];
        [self parseHTMLFileAtURL];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Unavailable"
                                                        message:@"Can't update weather without internet connection."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated{
    
    // always checking for updated and correct info
    
    AppDelegate *delegate = UIAppDelegate;
    
    if (delegate.completeWeatherData){
        
        Observation *observation = delegate.completeWeatherData[0];
        
        if (![[NSUserDefaults standardUserDefaults] integerForKey:@"englishUnits"])
            self.tempLabel.text = [NSString stringWithFormat:@"%d°F", [observation.temperatureF intValue]];
        else
            self.tempLabel.text = [NSString stringWithFormat:@"%d°C", [observation.temperatureC intValue]];
    }
    
    
}


- (void)reloadData
{
    
    AppDelegate *delegate = UIAppDelegate;
    
    self.internetReachable = [Reachability reachabilityForInternetConnection];
    
    if ([CurrentView getConnectivity]) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];

        
        if (!delegate.completeTrailData){
            [self parseHTMLFileAtURL];
        }
        
        WeatherRequest *newRequest = [WeatherRequest requestOperation];
        
        
        
        [newRequest getWeather:^(Observation *current, Observation *forecast, NSArray *hourly, NSError *error) {
            

            
            if (error)
            {
                NSLog(@"Web Service Error: %@", [error description]);
            }
            else
            {
                [self updateUIWithObservation:current];
                
                // Save weather data to App Delegate to be accessed by other tab views
                
                delegate.completeWeatherData = [NSMutableArray arrayWithObjects:current, forecast, hourly, nil];
                

            }
            
            
        }];
        
        [SVProgressHUD dismiss];
        
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Unavailable"
                                                        message:@"Can't update weather without internet connection."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)updateUIWithObservation:(Observation *)observation
{
    
    if (observation)
        
    {
        
        if (![[NSUserDefaults standardUserDefaults] integerForKey:@"englishUnits"])
            self.tempLabel.text = [NSString stringWithFormat:@"%d°F", [observation.temperatureF intValue]];
        else
            self.tempLabel.text = [NSString stringWithFormat:@"%d°C", [observation.temperatureC intValue]];
        
        self.dateLabel.text = [observation.timeStringRFC822 substringToIndex:[observation.timeStringRFC822 length] - 15]; // trim time elements from string
        self.conditionsLabel.text = observation.weatherDescription;
                
        self.conditionsIcon.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[observation.iconUrl stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]]];
        
        self.lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [observation.localTimeString stringByReplacingOccurrencesOfString:@"-0500" withString:@""]];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Weather Unavailable"
                                                        message:@"Unable to retrieve weather data."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)parseHTMLFileAtURL
{
        
    NSString *snowReportURL = @"http://craftsbury.com/skiing/nordic_center/snow_report.htm";
    
    NSData *snowReportData = [NSData dataWithContentsOfURL:[NSURL URLWithString:snowReportURL]];
    
    TFHpple *snowReportParser = [TFHpple hppleWithHTMLData:snowReportData];
    
    NSArray *snowDetails = [snowReportParser searchWithXPathQuery:@"//div[@id='snow-details']/p/span[@class='data']"];
    NSArray *kmOpen = [snowReportParser searchWithXPathQuery:@"//div[@id='kilometers-open']/p/span[@class='data']"];
    NSArray *trailConditions = [snowReportParser searchWithXPathQuery:@"//div[@id='trail-conditions']/table//td"];
    NSArray *trailNames = [snowReportParser searchWithXPathQuery:@"//div[@id='trail-conditions']/table/tr/td/span[@class='trail-name']"];
    
    NSArray *trailNodes = [snowReportParser searchWithXPathQuery:@"//div[@id='trail-conditions']/table/tr/td/span[@class]"];
    
    
    NSString *snowDetailsData = @"";
    NSString *kmOpenData = @"";
    NSMutableArray *trailLengthsData = [NSMutableArray array];
    NSMutableArray *trailStatusData = [NSMutableArray array];
    NSMutableArray *trailNamesData = [NSMutableArray array];
    NSMutableArray *trailDateGroomed = [NSMutableArray array];
    NSMutableArray *trailNote = [NSMutableArray array];
    NSMutableArray *trailDifficulty = [NSMutableArray array];
    
    
    /* GET SNOWFALL */
    TFHppleElement *element = snowDetails[1];
    if ((![element text]) || ([[element text] isEqualToString:@"0"]))
        snowDetailsData = @"0 in";
    else
        snowDetailsData = [element text];
    
    
    /* GET KM OPEN */
    element = kmOpen[0];
    if ((![element text]) || ([[element text] isEqualToString:@"0"]))
        kmOpenData = @"0 km";
    else
        kmOpenData = [element text];
    
    /* GET TRAIL STATUS */
    
    int idx=0;
    int counter=0;
    long sizeArray = [trailConditions count];
    
    while (counter + 2 <= sizeArray){
        
        element = trailConditions[counter];
        
        if ([[[element attributes] valueForKey:@"class"] isEqualToString:@"trail-kilometers"]){
            trailLengthsData[idx] = [element text];
            element = trailConditions[counter+1];
            
            if ([[element text] isEqualToString:@"CLOSED"]){
                trailStatusData[idx] = @"CLOSED";
                trailDateGroomed[idx] = @"--";
                trailNote[idx] = @" ";
            }
            else {
                trailStatusData[idx] = @"OPEN";
                trailDateGroomed[idx] = [element text];
                
                element = trailConditions[counter+2];
                trailNote[idx] = [[element text] stringByReplacingOccurrencesOfString:@"\u00a0" withString:@" "];
            }
            idx++;
        }
        counter++;
    }
    
    idx=0;
    for (TFHppleElement *element in trailNames){
        // resolve occurances of &nbsp in html
        trailNamesData[idx] = [[element text] stringByReplacingOccurrencesOfString:@"\u00a0" withString:@" "];
        idx++;
    }
    
    
    /* GET TRAIL DIFFICULTY */
    
    idx=0;
    for (TFHppleElement *element in trailNodes){
        
        if ([[element objectForKey:@"class"] isEqualToString:@"beginner trail-number"]){
            trailDifficulty[idx] = @"beginner";
            idx++;
        }
        else if ([[element objectForKey:@"class"] isEqualToString:@"intermediate trail-number"]){
            trailDifficulty[idx] = @"intermediate";
            idx++;
        }
        else if ([[element objectForKey:@"class"] isEqualToString:@"advanced trail-number"]){
            trailDifficulty[idx] = @"advanced";
            idx++;
        }
        else if ([[element objectForKey:@"class"] isEqualToString:@"na trail-number"]){
            trailDifficulty[idx] = @"na trail-number";
            idx++;
        }
    }
    
    
    NSArray *keys = [NSArray arrayWithObjects:@"Name", @"Length", @"Status", @"Groomed", @"Note", @"Difficulty", nil];
    NSArray *objects = [NSArray arrayWithObjects:trailNamesData, trailLengthsData, trailStatusData, trailDateGroomed, trailNote, trailDifficulty, nil];
    NSMutableDictionary *completeTrailData = [NSMutableDictionary dictionaryWithObjects:objects forKeys:keys];
    
    AppDelegate *delegate = UIAppDelegate;
    
    delegate.completeTrailData = completeTrailData;
        
    self.kmOpenLabel.text = kmOpenData;
    self.kmOpenLabel.numberOfLines = 0;
    self.kmOpenLabel.adjustsFontSizeToFitWidth = YES;
    
    // Replace hash mark with units
    NSArray *substrings = [snowDetailsData componentsSeparatedByString:@"\""];
    if ([substrings count] > 1)
        snowDetailsData = [NSString stringWithFormat:@"%@ in", substrings[0]];
    
    self.snowfallLabel.text = snowDetailsData;
    self.snowfallLabel.numberOfLines = 0;
    self.snowfallLabel.adjustsFontSizeToFitWidth = YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)refresh:(id)sender
{
    [self reloadData];
}

+ (BOOL)getConnectivity {
    return [[Reachability reachabilityWithHostName:@"google.com"] currentReachabilityStatus] != NotReachable;
}

+ (BOOL)getConnectivityViaWiFiNetwork {
    return [[Reachability reachabilityWithHostName:@"google.com"] currentReachabilityStatus] == ReachableViaWiFi;
}

+ (BOOL)getConnectivityViaCarrierDataNetwork {
    return [[Reachability reachabilityWithHostName:@"google.com"] currentReachabilityStatus] == ReachableViaWWAN;
}

@end
