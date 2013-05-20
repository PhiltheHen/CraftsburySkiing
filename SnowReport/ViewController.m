//
//  ViewController.m
//  SnowReport
//
//  Created by Philip Henson on 4/27/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

@synthesize craftsburyWeather = _craftsburyWeather;
@synthesize firstParse = _firstParse;

@synthesize xmlParser = _xmlParser;
@synthesize currentString = _currentString;
@synthesize storeCharacters = _storeCharacters;

@synthesize xmlParserForecast = _xmlParserForecast;
@synthesize currentArray = _currentArray;
@synthesize storeElements = _storeElements;
@synthesize currentElement = _currentElement;

@synthesize snowReportParser = _snowReportParser;

int cycleNum = 0;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ************************************ CURRENT WEATHER XML PARSER ************************************
	
    self.firstParse = YES;
    
    self.xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString: @"http://w1.weather.gov/xml/current_obs/KMVL.xml"]];
    
    self.xmlParser.delegate = self;
    self.currentString = [NSMutableString string];
    
    if ( [self.xmlParser parse] )
        NSLog(@"XML Current Weather Parsed");
    else
        NSLog(@"Failed to parse");
    
    // ************************************ WEATHER FORECAST XML PARSER ************************************
    self.firstParse = NO;
    
    self.xmlParserForecast = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString: @"http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php?lat=44.68&lon=-72.36&product=time-series&begin=&end=&maxt=maxt&mint=mint&temp=temp&pop12=pop12&wspd=wspd&wdir=wdir&wx=wx&icons=icons"]];
    
    self.xmlParserForecast.delegate = self;
    self.currentArray = [NSMutableArray array];
    
    if ( [self.xmlParserForecast parse] )
        NSLog(@"XML Forecast Parsed");
    else
        NSLog(@"Failed to parse forecast");
    
    // ************************************ SNOW REPORT MAIN HTML PARSER ************************************
    NSURL *snowReportUrl = [NSURL URLWithString: @"http://craftsbury.com/skiing/nordic_center/snow_report.htm"];
    NSData *snowReportData = [NSData dataWithContentsOfURL:snowReportUrl];
    
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
            //self.trackSetLabel.text = [[element objectForKey:@"]]
        }
        index++;
    }
    
    self.kmOpenLabel.text = reportElementsData[0];
    self.trackSetLabel.text = reportElementsData[1];
    self.skateGroomedLabel.text = reportElementsData[2];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Label Data Source



- (void) populateLabels{
    
    self.conditionsLabel.text = self.craftsburyWeather.conditions;
    self.currentTempLabel.text = [NSString stringWithFormat:@"%@%@", self.craftsburyWeather.currentTemp, @" ºF"];
    
    NSURL *currentConditionsImageUrl = [NSURL URLWithString:self.craftsburyWeather.currentConditionsImageUrl];
    NSData *imageData = [NSData dataWithContentsOfURL:currentConditionsImageUrl];
    UIImage *image = [UIImage imageWithData:imageData];
    
    self.conditionsImageView.image = image;
    
    
}

#pragma mark -
#pragma mark Parser Delegate

static NSString *kCurrent_Observation = @"current_observation";
static NSString *kWeather = @"weather";
static NSString *kCurrent_Temp = @"temp_f";
static NSString *kIconURL = @"icon_url_name";

static NSString *kTemp_Forecast = @"temperature";
static NSString *kConditions_Forecast = @"weather-conditions";
// ...etc

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if (self.firstParse){ // For current weather
    
        if ([elementName isEqualToString:kCurrent_Observation]){
            self.craftsburyWeather = [[Weather alloc] init];
            self.storeCharacters = NO;
        }
        else if ([elementName isEqualToString:kWeather] || [elementName isEqualToString:kCurrent_Temp] || [elementName isEqualToString:kIconURL]) {
            [self.currentString setString:@""];
            self.storeCharacters = YES;
        }
    } else { // For weather forecast
        
        if ([elementName isEqualToString:kTemp_Forecast] || [elementName isEqualToString:kConditions_Forecast]){ // ...etc
            [self.currentString setString:@""];
            self.storeElements = YES;
        }
        
    }
}

//string buffer
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // Works for both parsers
    
        if ((self.storeCharacters) || (self.storeElements)){
            [self.currentString appendString:string];
            
//            if (!self.firstParse){
//                NSLog(@"%@", _currentString);
//            }
            
        }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:kWeather]){
        self.craftsburyWeather.conditions = _currentString;
    } else if ([elementName isEqualToString:kCurrent_Temp]){
        self.craftsburyWeather.currentTemp = _currentString;
    } else if ([elementName isEqualToString:kIconURL]){
        self.craftsburyWeather.currentConditionsImageUrl = [NSString stringWithFormat:@"%@%@", @"http://forecast.weather.gov/images/wtf/small/", _currentString];
    } else if ([elementName isEqualToString:kTemp_Forecast]){
        NSArray *tempArray = [[self.currentString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
                
        if (cycleNum == 0){
            tempArray = [tempArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 5)]];
            cycleNum++;
        } else if (cycleNum == 1){
            tempArray = [tempArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(4, 5)]];
            cycleNum++;
            NSLog(@"%@", self.craftsburyWeather.minTempArray);
        } else if (cycleNum == 2){
            tempArray = [tempArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, 5)]];
            cycleNum++;
        }
        
    } else if ([elementName isEqualToString:kTemp_Forecast]){
        NSArray *tempArray = [[self.currentString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
        
    }
    
    if ([elementName isEqualToString:@"privacy_policy_url"] || [elementName isEqualToString:@"/dwml"]){ //define end for parsing data. MIGHT NEED TO EDIT
        [self finishedCurrentWeather:_craftsburyWeather];
    }
    
    self.storeCharacters = NO;
}

- (void) finishedCurrentWeather:(Weather *)w{
    [self populateLabels];
    self.craftsburyWeather = nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"Error Parsing Data");
    //DO SOMETHING HERE TO ALERT USER OF ERROR
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"Document Ended");
    
    
}


@end

