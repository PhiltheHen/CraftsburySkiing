//
//  ViewController.m
//  SnowReport
//
//  Created by Philip Henson on 4/27/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import "ViewController.h"
#import "WeatherViewController.h"
#import "TrailConditionsViewController.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize weatherElementsDictionary = _weatherElementsDictionary;
@synthesize trailConditionsArray = _trailConditionsArray;
@synthesize snowReportParser = _snowReportParser;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *weatherURL = @"http://api.wunderground.com/api/0f26d3b3dcb3da08/conditions/forecast/hourly/q/05827.json";
    NSString *snowReportURL = @"http://craftsbury.com/skiing/nordic_center/snow_report.htm";
    
    // Process data from API and web
    [self parseJSONFileAtURL:weatherURL];
    [self parseHTMLFileAtURL:snowReportURL];

}

- (void)parseJSONFileAtURL:(NSString *)URL
{
    // Process data for weather forecast
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        
        self.weatherElementsDictionary = (NSDictionary *)JSON;
        [self storeWeatherData];
    
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather. Try Again Later." message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }];

    [operation start];
    
}

- (void) storeWeatherData{
    
    // Store data so it can be used in subsequent view controller without another call to API
    
    NSDictionary *mainViewElements = [self.weatherElementsDictionary objectForKey:@"current_observation"];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[mainViewElements valueForKey:@"icon_url"] stringByReplacingOccurrencesOfString:@"/k/" withString:@"/i/"]]];
    UIImage *image = [UIImage imageWithData:imageData];
    
    NSString *lastUpdated = [mainViewElements valueForKey:@"observation_time_rfc822"];
    
    self.date.text = [lastUpdated substringToIndex:[lastUpdated length] - 15]; // trim time elements from string
    self.conditionsLabel.text = [mainViewElements valueForKey:@"weather"];
    self.currentTemp.text = [NSString stringWithFormat:@"%d°F", [[mainViewElements valueForKey:@"temp_f"] integerValue]];
    self.conditionsUIImageView.image = image;
    
}


- (void)parseHTMLFileAtURL:(NSString *)URL{
    // Process data for snow report and trail conditions
    
    NSData *snowReportData = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
    
    self.snowReportParser = [TFHpple hppleWithHTMLData:snowReportData];
    
    NSArray *reportElements = [self.snowReportParser searchWithXPathQuery:@"//div[@id='kilometers-open']/p/span[@class='data']"];
    
    NSMutableArray *reportElementsData = [[NSMutableArray alloc] initWithCapacity:0];
    int index = 0;
    
    for (TFHppleElement *element in reportElements) {
        if (![element text])
            reportElementsData[index] = @"0.0 km";
        else {
            reportElementsData[index] = [element text];
            NSLog(@"%@", reportElementsData[index]);
            
            // not sure what the key is at the moment...non-existant during off-season
            // self.trackSetLabel.text = [[element objectForKey:@""]]
        }
        index++;
    }
    
    
    // Do the same thing for trail conditions:
    
    // NEED TO FIGURE OUT CLASS FOR OPEN TRAILS. THE FOLLOWING ONLY WORKS FOR CLOSED TRAILS (off-season)
    
    NSArray *trailConditions = [self.snowReportParser searchWithXPathQuery:@"//td[@class='trail-closed']"];
    
    NSMutableArray *trailConditionsData = [[NSMutableArray alloc] initWithCapacity:0];

    int idx = 0;
    
    for (TFHppleElement *element in trailConditions) {
        trailConditionsData[idx] = [element text];
        idx++;
    }
    
    self.trailConditionsArray = trailConditionsData; // Pass this to TrailConditionsViewController
    
    self.kmOpenLabel.text = reportElementsData[0];
    self.trackSetLabel.text = reportElementsData[1];
    self.skateGroomedLabel.text = reportElementsData[2];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showForecast"]){
        WeatherViewController *wvc = (WeatherViewController *)[segue destinationViewController];
        wvc.craftsburyDetailWeather = self.weatherElementsDictionary;
    }
    
    else if ([[segue identifier] isEqualToString:@"showTrailConditions"]){
        TrailConditionsViewController *tcvc = (TrailConditionsViewController *)[segue destinationViewController];
        tcvc.trailStatus = self.trailConditionsArray;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

