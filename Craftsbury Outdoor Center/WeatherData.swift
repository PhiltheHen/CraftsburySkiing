//
//  WeatherData.swift
//  CraftsburySkiing
//
//  Created by Philip Henson on 8/14/15.
//  Copyright (c) 2015 Philip Henson. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire


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

    var hourlyTimeInfo: NSDictionary?

    var textForecast: NSDictionary?
    var simpleForecast: NSDictionary?

    let keys: [String] = [
        "observation_time",
        "observation_time_rfc822",
        "local_time_rfc822",
        "weather",
        "temperature_string",
        "icon",
        "icon_url",
        "temp_f",
        "temp_c",
        "wind_mph",
        "wind_kph",
        "wind_dir",
        "pop",
        "precip_today_string",

        "FCTTIME",

        "txt_forecast",
        "simpleforecast"]

    init () {
        Alamofire.request(.GET, "http://api.wunderground.com/api/0f26d3b3dcb3da08/conditions/forecast/hourly/q/05827.json")
            .responseJSON { (_, _, data, error) in
                if (error != nil) {
                    println(error)
                }else if let json = data as? [String:AnyObject] {
                    //println(json);
                    if let currentObs = json["current_observation"] as? NSDictionary {

                        // Okay, there has got to be a better way to do this :/
                        self.timeString = currentObs[self.keys[0]] as? String
                        self.timeStringRFC822 = currentObs[self.keys[1]] as? String
                        self.localTimeString = currentObs[self.keys[2]] as? String
                        self.weatherDescription = currentObs[self.keys[3]] as? String
                        self.temperatureDescription = currentObs[self.keys[4]] as? String
                        self.iconName = currentObs[self.keys[5]] as? String
                        self.iconURL = currentObs[self.keys[6]] as? String
                        self.tempF = currentObs[self.keys[7]] as? Int
                        self.tempC = currentObs[self.keys[8]] as? Int
                        self.windSpeedMPH = currentObs[self.keys[9]] as? Int
                        self.windSpeedKPH = currentObs[self.keys[10]] as? Int
                        self.windDirection = currentObs[self.keys[11]] as? String
                        self.probOfPrecip = currentObs[self.keys[12]] as? String
                    }
                    if let hourlyObs = json["hourly_forecast"] as? NSDictionary{
                        self.hourlyTimeInfo = hourlyObs[self.keys[13]] as? NSDictionary
                    }
                    if let forecastObs = json["forecast"] as? NSDictionary{
                        self.textForecast = forecastObs[self.keys[14]] as? NSDictionary
                        self.simpleForecast = forecastObs[self.keys[15]] as? NSDictionary
                    }



                    
                }
                
        }
    }

    func reloadWeather(){

    }

}