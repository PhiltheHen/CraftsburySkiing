//
//  WeatherData.swift
//  CraftsburySkiing
//
//  Created by Philip Henson on 8/14/15.
//  Copyright (c) 2015 Philip Henson. All rights reserved.
//

import UIKit


class WeatherData {

    var timeString: String?
    var timeStringRFC822: String?
    var localTimeString: String?
    var weatherDescription: String?
    var temperatureDescription: String?
    var iconName: String?
    var iconURL: String?
    var tempF: Int?
    var tempC: Int?
    var windSpeedMPH: Int?
    var windSpeedKPH: Int?
    var windDirection: String?
    var probOfPrecip: String?
    var precipToday: String?
    var hourlyTimeInfo: NSArray?
    var textForecast: NSDictionary?
    var simpleForecast: NSDictionary?

}