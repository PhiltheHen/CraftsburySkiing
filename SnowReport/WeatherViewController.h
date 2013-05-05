//
//  WeatherViewController.h
//  SnowReport
//
//  Created by Philip Henson on 4/28/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"

@interface WeatherViewController : UIViewController <NSXMLParserDelegate>

@property (nonatomic, strong) NSXMLParser *xmlParserForecast;
@property (nonatomic,strong) Weather *weatherForecast;
@property (nonatomic, strong) NSMutableString *currentString;
@property (nonatomic, assign) BOOL storeCharacters;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

- (void) populateLabels;

- (void) finishedWeatherForecast:(Weather*)w;

@end
