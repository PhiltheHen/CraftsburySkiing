//
//  WeatherRequest.h
//  SnowReport
//
//  Created by Philip Henson on 7/8/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "Observation.h"

@interface WeatherRequest : AFHTTPRequestOperation

+ (instancetype)requestOperation;

- (void)getWeather:(void(^)(Observation *current, Observation *forecast, NSArray *hourly, NSError *error))completion;

@end
