//
//  WeatherRequest.m
//  SnowReport
//
//  Created by Philip Henson on 7/8/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import "WeatherRequest.h"
#import "WeatherAPIKey.h"

static NSString *const kWeatherUndergroundAPIBaseURLString = @"http://api.wunderground.com/api/";
static NSString *const kPath = @"conditions/forecast/hourly/q/05827.json";

// full URL: http:// api.wunderground.com/api/0f26d3b3dcb3da08/conditions/forecast/hourly/q/05827.json

@implementation WeatherRequest

+ (instancetype)requestOperation
{
    
    WeatherRequest *sharedRequest = nil;

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.wunderground.com/api/0f26d3b3dcb3da08/conditions/forecast/hourly/q/05827.json"]];
    sharedRequest = [[self alloc] initWithRequest:request];

    return sharedRequest;
}

- (void)getWeather:(void(^)(Observation *current, Observation *forecast, NSArray *hourly, NSError *error))completion
{
    
    AFHTTPRequestOperation *observation = [WeatherRequest requestOperation];
    
    observation.responseSerializer = [AFJSONResponseSerializer serializer];
    [observation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        Observation *current = [Observation observationWithDictionary:responseObject[@"current_observation"]];
        Observation *forecast = [Observation observationWithDictionary:responseObject[@"forecast"]];
        NSArray *hourly = [[NSArray arrayWithObject:responseObject[@"hourly_forecast"]] objectAtIndex:0];
        completion(current, forecast, hourly, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, nil, nil, error);
    }];
        [observation start];
    

}


@end
