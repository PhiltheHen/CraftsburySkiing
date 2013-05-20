//
//  Weather.m
//  SnowReport2
//
//  Created by Philip Henson on 4/21/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import "Weather.h"

@implementation Weather

@synthesize conditions = _conditions;
@synthesize currentTemp = _currentTemp;
@synthesize currentConditionsImageUrl = _currentConditionsImageUrl;

@synthesize maxTempArray = _maxTempArray;
@synthesize minTempArray = _minTempArray;
@synthesize hourlyTemp = _hourlyTemp;
@synthesize windSpeedArray = _windSpeedArray;
@synthesize windDirArray = _windDirArray;
@synthesize popArray = _popArray;
@synthesize forecastImageUrl = _forecastImageUrl;


- (NSString *)description {
    return [NSString stringWithFormat:@"%@", _conditions];
}

@end
