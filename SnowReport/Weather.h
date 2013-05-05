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
@property (nonatomic, copy) NSString *maxTemp;
@property (nonatomic, copy) NSString *minTemp;
@property (nonatomic, copy) NSString *windSpeed;
@property (nonatomic, copy) NSString *windDir;
@property (nonatomic, copy) NSString *probabilityPrecip;
@property (nonatomic, copy) NSString *imageURL;

@end
