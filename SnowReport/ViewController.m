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

@synthesize xmlParser = _xmlParser;
@synthesize currentWeather = _currentWeather;
@synthesize currentString = _currentString;
@synthesize storeCharacters = _storeCharacters;
@synthesize snowReportParser = _snowReportParser;

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString: @"http://w1.weather.gov/xml/current_obs/KMVL.xml"]];
    
    self.xmlParser.delegate = self;
    self.currentString = [NSMutableString string];
    
    if ( [self.xmlParser parse] )
        NSLog(@"XML Parsed");
    else
        NSLog(@"Failed to parse");
    
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
    
    NSLog(@"%@", self.currentWeather.conditions);
    
    self.conditionsLabel.text = self.currentWeather.conditions;
    self.currentTempLabel.text = [NSString stringWithFormat:@"%@%@", self.currentWeather.currentTemp, @" ºF"];
    
    NSURL *imageURL = [NSURL URLWithString:self.currentWeather.imageURL];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    self.conditionsImageView.image = image;
    
    
}

#pragma mark -
#pragma mark Parser Delegate

static NSString *kCurrent_Observation = @"current_observation";
static NSString *kWeather = @"weather";
static NSString *kCurrent_Temp = @"temp_f";
static NSString *kWind_Speed = @"wind_mph";
static NSString *kWind_Dir = @"wind_dir";
static NSString *kIconURL = @"icon_url_name";

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    if ([elementName isEqualToString:kCurrent_Observation]){
        self.currentWeather = [[Weather alloc] init];
        self.storeCharacters = NO;
    }
    else if ([elementName isEqualToString:kWeather] || [elementName isEqualToString:kCurrent_Temp] || [elementName isEqualToString:kWind_Speed] || [elementName isEqualToString:kWind_Dir]|| [elementName isEqualToString:kIconURL]) {
        [self.currentString setString:@""];
        self.storeCharacters = YES;
    }
}

//string buffer
- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (self.storeCharacters) [self.currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:kWeather]){
        self.currentWeather.conditions = _currentString;
    } else if ([elementName isEqualToString:kCurrent_Temp]){
        self.currentWeather.currentTemp = _currentString;
    } else if ([elementName isEqualToString:kWind_Speed]){
        self.currentWeather.windSpeed = _currentString;
    } else if ([elementName isEqualToString:kWind_Dir]){
        self.currentWeather.windDir = _currentString;
    } else if ([elementName isEqualToString:kIconURL]){
        self.currentWeather.imageURL = [NSString stringWithFormat:@"%@%@", @"http://forecast.weather.gov/images/wtf/small/", _currentString];
    }
    if ([elementName isEqualToString:@"privacy_policy_url"]){ //define end for parsing data. MIGHT NEED TO EDIT
        [self finishedCurrentWeather:_currentWeather];
    }
    
    self.storeCharacters = NO;
}

- (void) finishedCurrentWeather:(Weather *)w{ // in case you want to do something with Weather object
    [self populateLabels];
    self.currentWeather = nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"Error Parsing Data");
    //DO SOMETHING HERE TO ALERT USER OF ERROR
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"Document Ended");
    //[self.tableView reloadData]; // MIGHT NOT NEED
    
    
}


@end

