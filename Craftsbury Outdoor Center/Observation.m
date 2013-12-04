//
//  Observation.m
//  SnowReport
//
//  Created by Philip Henson on 7/8/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import "Observation.h"

@implementation Observation

+ (NSDictionary *)keyMapping
{
    static NSDictionary *keyMapping = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        keyMapping = @{
                       @"display_location"             : @"location",
                       @"observation_location"         : @"observationLocation",
                       @"image"                        : @"weatherUndergroundImageInfo",
                       @"observation_time"             : @"timeString",
                       @"observation_time_rfc822"      : @"timeStringRFC822",
                       @"FCTTIME"                      : @"hourlyTimeInfo",
                       @"weather"                      : @"weatherDescription",
                       @"temperature_string"           : @"temperatureDescription",
                       @"icon"                         : @"iconName",
                       @"icon_url"                     : @"iconUrl",
                       @"temp_f"                       : @"temperatureF",
                       @"temp_c"                       : @"temperatureC",
                       @"wind_mph"                     : @"windSpeedMPH",
                       @"wind_kph"                     : @"windSpeedKPH",
                       @"wind_dir"                     : @"windDirection",
                       @"pop"                          : @"probabilityOfPrecipitation",
                       //@"precip_today_in"              : @"precipTodayIn",
                       //@"precip_today_metric"          : @"precipTodayMet",
                       @"precip_today_string"          : @"precipTodayString",
                       @"txt_forecast"                 : @"textForecast",
                       @"simpleforecast"               : @"simpleForecast"
                       };
    });
    
    return keyMapping;
}

+ (instancetype)observationWithDictionary:(NSDictionary *)dictionary
{
    
    
    Observation *observation = nil;
    
    if (dictionary)
    {
        NSDictionary *keyMapping = [self keyMapping];
        
        observation = [[Observation alloc] init];
        
        for (NSString *key in keyMapping)
        {
            id value = dictionary[key];
            
            if (value)
            {
                [observation setValue:value forKey:keyMapping[key]];
            }
            
        }
    }
    
    return observation;
}



@end
