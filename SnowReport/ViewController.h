//
//  ViewController.h
//  SnowReport
//
//  Created by Philip Henson on 4/27/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//
// adding comment here

#import <UIKit/UIKit.h>
#import "Weather.h"
#import "TFHpple.h"
#import "AFNetworking.h"

@interface ViewController : UIViewController <NSXMLParserDelegate>

@property (nonatomic, strong) Weather *craftsburyWeather;
@property (nonatomic, assign) BOOL firstParse;

@property (nonatomic, strong) NSXMLParser *xmlParser;
@property (nonatomic, strong) NSMutableString *currentString;
@property (nonatomic, assign) BOOL storeCharacters;

@property (nonatomic, strong) NSXMLParser *xmlParserForecast;
@property (nonatomic, strong) NSMutableArray *currentArray;
@property (nonatomic, assign) BOOL storeElements;
@property (nonatomic, strong) NSString *currentElement;


@property (strong, nonatomic) TFHpple *snowReportParser;

// *************** LABELS *******************
@property (weak, nonatomic) IBOutlet UILabel *conditionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (strong, nonatomic) IBOutlet UIImageView *conditionsImageView;
@property (weak, nonatomic) IBOutlet UILabel *kmOpenLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackSetLabel;
@property (weak, nonatomic) IBOutlet UILabel *skateGroomedLabel;





- (void) populateLabels;

- (void) finishedCurrentWeather:(Weather*)w;

@end
