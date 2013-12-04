//
//  Observation.h
//  SnowReport
//
//  Created by Philip Henson on 7/8/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Observation : NSObject

@property (nonatomic, strong) NSDictionary  *location;
@property (nonatomic, strong) NSDictionary  *observationLocation;
@property (nonatomic, strong) NSDictionary  *weatherUndergroundImageInfo;
@property (nonatomic, strong) NSDictionary  *textForecast;
@property (nonatomic, strong) NSDictionary  *simpleForecast;


@property (nonatomic, strong) NSString      *timeString;
@property (nonatomic, strong) NSString      *timeStringRFC822;
@property (nonatomic, strong) NSString      *weatherDescription;
@property (nonatomic, strong) NSString      *windDescription;
@property (nonatomic, strong) NSString      *temperatureDescription;
@property (nonatomic, strong) NSString      *iconName;
@property (nonatomic, strong) NSString      *iconUrl;
@property (nonatomic, strong) NSString      *windDirection;
@property (nonatomic, strong) NSString      *precipTodayIn;
@property (nonatomic, strong) NSString      *precipTodayMetric;
@property (nonatomic, strong) NSString      *precipTodayString;

@property (nonatomic, strong) NSNumber      *temperatureF;
@property (nonatomic, strong) NSNumber      *temperatureC;
@property (nonatomic, strong) NSNumber      *windSpeedMPH;
@property (nonatomic, strong) NSNumber      *windSpeedKPH;

+ (instancetype)observationWithDictionary:(NSDictionary *)dictionary;

@end
