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

@synthesize xmlParserForecast = _xmlParserForecast;
@synthesize weatherForecast = _weatherForecast;
@synthesize currentString = _currentString;
@synthesize storeCharacters = _storeCharacters;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.xmlParserForecast = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?zipCodeList=05827&format=24+hourly&numDays=7"]];
    
    self.xmlParserForecast.delegate = self;
    self.currentString = [NSMutableString string];
    
    if ([self.xmlParserForecast parse])
        NSLog(@"XML Forecast Parsed");
    else
        NSLog(@"Failed to Parse XML Forecast");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Forecast Label Data Source

- (void) populateLabels{
    // Fill in forecast labels here, with images
    self.testLabel.text = self.weatherForecast.maxTemp;
}

#pragma mark -
#pragma mark Forecast Parser Delegate

static NSString *kForecast = @"location";
static NSString *kTemp = @"temperature";
static NSString *kPoP = @"probability-of-precipitation";
static NSString *kConditions = @"weather-conditions";
static NSString *kConditionsImage = @"conditions-icon";

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:kForecast]){
        NSLog(@"Found forecast");
        self.weatherForecast = [[Weather alloc] init];
        self.storeCharacters = NO;
    }
    else if ([elementName isEqualToString:kTemp] || [elementName isEqualToString:kPoP] || [elementName isEqualToString:kConditions] || [elementName isEqualToString:kConditionsImage]){
        [self.currentString setString:@""];
        self.storeCharacters = YES;
    }
}

//string buffer

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (self.storeCharacters) [self.currentString appendString:string];
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:kTemp]){
        self.weatherForecast.maxTemp = _currentString;
        NSLog(@"%@", self.weatherForecast.maxTemp);
    } else if ([elementName isEqualToString:kPoP]){
        self.weatherForecast.probabilityPrecip = _currentString;
    } else if ([elementName isEqualToString:kConditions]){
        self.weatherForecast.conditions = _currentString;
    } else if ([elementName isEqualToString:kConditionsImage]){
        self.weatherForecast.imageURL = _currentString;
    }
    
    if ([elementName isEqualToString:@"/dwml"])
        {//define end for parsing data
        [self finishedWeatherForecast:_weatherForecast];
    }
    self.storeCharacters = NO;
}

- (void) finishedWeatherForecast:(Weather *)w {
    // in case we want to do something with Weather object
    [self populateLabels];
    self.weatherForecast = nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"Error Parsing Data");
    //Do something here to alert user of error
}

- (void) parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"Forecast Document Ended");
}

@end
