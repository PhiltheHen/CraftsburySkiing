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

@property (nonatomic, strong) NSXMLParser *xmlParser;
@property (nonatomic, strong) NSMutableDictionary *craftsburyWeather;
@property (nonatomic, strong) NSMutableDictionary *weatherElement;
@property (nonatomic, strong) NSString *previousElement;
@property (nonatomic, strong) NSString *elementName;
@property (nonatomic, strong) NSMutableString *elementValue;
@property (nonatomic, assign) BOOL errorParsing;

@property (strong, nonatomic) TFHpple *snowReportParser;

// *************** LABELS *******************
@property (weak, nonatomic) IBOutlet UILabel *conditionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (weak, nonatomic) IBOutlet UIImageView *conditionsUIImageView;

@property (weak, nonatomic) IBOutlet UILabel *kmOpenLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackSetLabel;
@property (weak, nonatomic) IBOutlet UILabel *skateGroomedLabel;



- (void) parseXMLFileAtURL:(NSString *)URL;

- (void) parseHTMLFileAtURL:(NSString *)URL;

- (void) populateLabels;

@end
