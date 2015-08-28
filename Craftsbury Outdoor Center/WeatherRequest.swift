//
//  WeatherRequest.swift
//  CraftsburySkiing
//
//  Created by Philip Henson on 8/27/15.
//  Copyright (c) 2015 Philip Henson. All rights reserved.
//

import UIKit
import Alamofire


class WeatherRequest {

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

        "txt_forecast",
        "simpleforecast"]

    var _weatherResult: WeatherData?

    func requestWeather (completionHandler: (WeatherData?, NSError?) -> ()) -> () {
        Alamofire.request(.GET, "http://api.wunderground.com/api/0f26d3b3dcb3da08/conditions/forecast/hourly/q/05827.json")
            .responseJSON { (_, _, data, error) in
                if error == nil {

                    // If weather exists already, do something with it
                    if let weatherResult = self._weatherResult {
                        completionHandler(weatherResult, nil)
                        // Maybe call a reloadData function here

                    } else {

                        self._weatherResult = WeatherData()

                    if let json = data as? [String:AnyObject] {
                        if let currentObs = json["current_observation"] as? NSDictionary {

                            self._weatherResult!.timeString = currentObs[self.keys[0]] as? String
                            self._weatherResult!.timeStringRFC822 = currentObs[self.keys[1]] as? String
                            self._weatherResult!.localTimeString = currentObs[self.keys[2]] as? String
                            self._weatherResult!.weatherDescription = currentObs[self.keys[3]] as? String
                            self._weatherResult!.temperatureDescription = currentObs[self.keys[4]] as? String
                            self._weatherResult!.iconName = currentObs[self.keys[5]] as? String
                            self._weatherResult!.iconURL = currentObs[self.keys[6]] as? String
                            self._weatherResult!.tempF = currentObs[self.keys[7]] as? Int
                            self._weatherResult!.tempC = currentObs[self.keys[8]] as? Int
                            self._weatherResult!.windSpeedMPH = currentObs[self.keys[9]] as? Int
                            self._weatherResult!.windSpeedKPH = currentObs[self.keys[10]] as? Int
                            self._weatherResult!.windDirection = currentObs[self.keys[11]] as? String
                            self._weatherResult!.probOfPrecip = currentObs[self.keys[12]] as? String
                            self._weatherResult!.precipToday = currentObs[self.keys[13]] as? String
                        }
                        if let hourlyObs = json["hourly_forecast"] as? NSArray{
                            self._weatherResult!.hourlyTimeInfo = hourlyObs
                        }
                        if let forecastObs = json["forecast"] as? NSDictionary{
                            self._weatherResult!.textForecast = forecastObs[self.keys[14]] as? NSDictionary
                            self._weatherResult!.simpleForecast = forecastObs[self.keys[15]] as? NSDictionary
                        }

                        
                    }
                        completionHandler(self._weatherResult, nil)
                    
                    
                }
                }
                
        }
    }
    
}