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

@property (nonatomic, strong) NSXMLParser *xmlParser;
@property (nonatomic, strong) Weather *currentWeather;
@property (nonatomic, strong) NSMutableString *currentString;
@property (nonatomic, assign) BOOL storeCharacters;
@property (weak, nonatomic) IBOutlet UILabel *conditionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (strong, nonatomic) IBOutlet UIImageView *conditionsImageView;
@property (strong, nonatomic) TFHpple *snowReportParser;
@property (weak, nonatomic) IBOutlet UILabel *kmOpenLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackSetLabel;
@property (weak, nonatomic) IBOutlet UILabel *skateGroomedLabel;



- (void) populateLabels;

- (void) finishedCurrentWeather:(Weather*)w;

@end
