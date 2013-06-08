//
//  ViewController.h
//  SnowReport
//
//  Created by Philip Henson on 4/27/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//
// adding comment here

#import <UIKit/UIKit.h>
#import "TFHpple.h"
#import "AFNetworking.h"

@interface ViewController : UIViewController <NSXMLParserDelegate>

@property (strong, nonatomic) NSDictionary *weatherElementsDictionary;
@property (strong, nonatomic) NSArray *trailConditionsArray;
@property (strong, nonatomic) TFHpple *snowReportParser;

// *************** LABELS *******************
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *conditionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTemp;
@property (weak, nonatomic) IBOutlet UIImageView *conditionsUIImageView;
@property (weak, nonatomic) IBOutlet UILabel *kmOpenLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackSetLabel;
@property (weak, nonatomic) IBOutlet UILabel *skateGroomedLabel;

// Some methods
- (void) parseJSONFileAtURL:(NSString *)URL;

- (void) parseHTMLFileAtURL:(NSString *)URL;

- (void) storeWeatherData;

@end
