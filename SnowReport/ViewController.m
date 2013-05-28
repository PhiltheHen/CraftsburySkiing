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
@synthesize craftsburyWeather = _craftsburyWeather;
@synthesize weatherElement = _weatherElement;
@synthesize previousElement = _previousElement;
@synthesize elementValue = _elementValue;
@synthesize elementName = _elementName;
@synthesize errorParsing = _errorParsing;

@synthesize snowReportParser = _snowReportParser;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *currentWeatherURL = @"http://w1.weather.gov/xml/current_obs/KMVL.xml";
    NSString *weatherForecastURL = @"http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php?lat=44.68&lon=-72.36&product=time-series&begin=&end=&maxt=maxt&mint=mint&temp=temp&pop12=pop12&wx=wx&icons=icons";
    NSString *snowReportURL = @"http://craftsbury.com/skiing/nordic_center/snow_report.htm";
    
    //[self parseXMLFileAtURL:currentWeatherURL];
    [self parseXMLFileAtURL:weatherForecastURL];
    //[self parseHTMLFileAtURL:snowReportURL];

}

- (void)parseHTMLFileAtURL:(NSString *)URL{
    // ************************************ SNOW REPORT MAIN HTML PARSER ************************************
    
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
            //self.trackSetLabel.text = [[element objectForKey:@"]]
        }
        index++;
    }
    
    self.kmOpenLabel.text = reportElementsData[0];
    self.trackSetLabel.text = reportElementsData[1];
    self.skateGroomedLabel.text = reportElementsData[2];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"File found and parsing started");
}

- (void)parseXMLFileAtURL:(NSString *)URL
{

    // ************************************ CURRENT WEATHER XML PARSER ************************************
    self.craftsburyWeather = [[NSMutableDictionary alloc] init];
    self.errorParsing=NO;

    self.xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:URL]];
    [self.xmlParser setDelegate:self];
    
    // You may need to turn some of these on depending on the type of XML file you are parsing
    [self.xmlParser setShouldProcessNamespaces:NO];
    [self.xmlParser setShouldReportNamespacePrefixes:NO];
    [self.xmlParser setShouldResolveExternalEntities:NO];
    
    [self.xmlParser parse];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSString *errorString = [NSString stringWithFormat:@"Error code %i", [parseError code]];
    NSLog(@"Error parsing XML: %@", errorString);
    
    self.errorParsing = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -
#pragma mark Parser Delegate

// Both Current Weather and Forecast Elements
static NSString *kConditions = @"weather";

// Current Weather Elements
static NSString *kCurrent_Temp_F = @"temp_f";
static NSString *kCurrent_Temp_C = @"temp_c";
static NSString *kLastUpdated = @"observation_time";
static NSString *kWindSpeedMPH = @"wind_mph";
static NSString *kWindDir = @"wind_dir";
static NSString *kCurrentIconURLBase = @"icon_url_base";
static NSString *kCurrentIconURL = @"icon_url_name";

// Forecast Elements
static NSString *kTemp_Forecast = @"temperature";
static NSString *kPoP = @"probability-of-precipitation";
static NSString *kForecastIconURL = @"conditions-icon";
static NSString *kTime_Stamp = @"layout-key";

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    self.previousElement = self.elementName;
    
    NSLog(@"%@", qName);
    
    if(qName){
        NSLog(@"HERE");
        self.elementName = qName;
    }
    
    if ([qName isEqualToString:kConditions]){
        self.weatherElement = [NSMutableDictionary dictionary];
    } else if ([qName isEqualToString:kCurrent_Temp_F]){
        self.weatherElement = [NSMutableDictionary dictionary];
    } else if ([qName isEqualToString:kCurrent_Temp_C]){
        self.weatherElement = [NSMutableDictionary dictionary];
    } else if ([qName isEqualToString:kLastUpdated]){
        self.weatherElement = [NSMutableDictionary dictionary];
    } else if ([qName isEqualToString:kWindSpeedMPH]){
        self.weatherElement = [NSMutableDictionary dictionary];
    } else if ([qName isEqualToString:kWindDir]){
        self.weatherElement = [NSMutableDictionary dictionary];
    } else if ([qName isEqualToString:kCurrentIconURLBase]){
        self.weatherElement = [NSMutableDictionary dictionary];
    } else if ([qName isEqualToString:kCurrentIconURL]){
        self.weatherElement = [NSMutableDictionary dictionary];
    } else if ([qName isEqualToString:kTemp_Forecast]){
        self.weatherElement = [NSMutableDictionary dictionary];
    } else if ([qName isEqualToString:kPoP]){
        self.weatherElement = [NSMutableDictionary dictionary];
    } else if ([qName isEqualToString:kForecastIconURL]){
        self.weatherElement = [NSMutableDictionary dictionary];
    } else if ([qName isEqualToString:kTime_Stamp]){
        self.weatherElement = [NSMutableDictionary dictionary];
    }

        self.elementValue = [NSMutableString string];
        
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    //NSLog(@"%@", self.elementName);
    if (!self.elementName){
        return;
    }
    
    [self.elementValue appendString:string];
    //NSLog(@"%@", self.elementValue);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    // FOR THE CURRENT WEATHER ELEMENTS
    if ([qName isEqualToString:kConditions] || [qName isEqualToString:kCurrent_Temp_C] || [qName isEqualToString:kCurrent_Temp_F]|| [qName isEqualToString:kLastUpdated]|| [qName isEqualToString:kWindSpeedMPH]|| [qName isEqualToString:kWindDir]|| [elementName isEqualToString:kCurrentIconURLBase] || [qName isEqualToString:kCurrentIconURL]){
        
        [self.craftsburyWeather setObject:self.elementValue forKey:elementName];
        
        self.weatherElement = nil;
 
        //NSLog(@"%@", self.craftsburyWeather);
        
        // FOR THE WEATHER FORECAST ELEMENTS
    } else if ([qName isEqualToString:kTemp_Forecast] || [qName isEqualToString:kPoP] || [qName isEqualToString:kForecastIconURL] || [qName isEqualToString:kTime_Stamp]){
    
        
        //NSLog(@"%@", self.weatherElement);
        
        self.weatherElement = nil;
        
    }
    
    self.elementName = nil;

}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    
    if (self.errorParsing == NO){
        NSLog(@"Document ended");
        [self populateLabels];
        // CACHE HERE!!
        
        self.craftsburyWeather = nil; // is this necessary?
    } else {
        NSLog(@"Error occurred during XML processing");
    }
}

#pragma mark - View Label Data Source

- (void) populateLabels{
    
    self.conditionsLabel.text = [self.craftsburyWeather objectForKey:kConditions];
    self.currentTempLabel.text = [self.craftsburyWeather objectForKey:kCurrent_Temp_F];
    
    
    // LOOK INTO CORE GRAPHICS
    
    NSString *combinedURL = [NSString stringWithFormat:@"%@%@", [self.craftsburyWeather objectForKey:kCurrentIconURLBase], [self.craftsburyWeather objectForKey:kCurrentIconURL]];
    NSString *fullURL = [combinedURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:fullURL]];
    UIImage *image = [UIImage imageWithData:imageData];
    
    self.conditionsUIImageView.image = image;
    
    
    

}

@end

