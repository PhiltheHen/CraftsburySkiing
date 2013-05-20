//
//  Weather.h
//  SnowReport2
//
//  Created by Philip Henson on 4/21/13.
//  Copyright (c) 2013 Philip Henson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject

@property (nonatomic, copy) NSString *conditions;
@property (nonatomic, copy) NSString *currentTemp;
@property (nonatomic, copy) NSString *currentConditionsImageUrl;

@property (nonatomic, copy) NSArray *maxTempArray;
@property (nonatomic, copy) NSArray *minTempArray;
@property (nonatomic, copy) NSArray *hourlyTemp;
@property (nonatomic, copy) NSString *windSpeedArray;
@property (nonatomic, copy) NSString *windDirArray;
@property (nonatomic, copy) NSString *popArray;
@property (nonatomic, copy) NSString *forecastImageUrl;


@end
