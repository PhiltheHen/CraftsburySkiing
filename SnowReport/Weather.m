//
//  Weather.m
//  SnowReport2
//
//  Created by Philip Henson on 4/21/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import "Weather.h"

@implementation Weather

@synthesize currentTemp = _currentTemp;
@synthesize maxTemp = _maxTemp;
@synthesize minTemp = _minTemp;
@synthesize windSpeed = _windSpeed;
@synthesize windDir = _windDir;
@synthesize conditions = _conditions;
@synthesize probabilityPrecip = _probabilityPrecip;
@synthesize imageURL = _imageURL;

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", _conditions];
}

@end
