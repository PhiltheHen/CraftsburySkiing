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
@synthesize currentConditions = _currentConditions;
@synthesize imageURL = _imageURL;

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", _currentTemp];
}

@end
