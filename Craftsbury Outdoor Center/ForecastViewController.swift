//
//  ForecastViewController.swift
//  CraftsburySkiing
//
//  Created by Philip Henson on 8/23/15.
//  Copyright (c) 2015 Philip Henson. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {

    var weather: WeatherData!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var conditionsImage: UIImageView!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var highLowTempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var precipLabel: UILabel!
    @IBOutlet weak var recentPrecipLabel: UILabel!

    @IBOutlet weak var hourOneLabel: UILabel!
    @IBOutlet weak var hourTwoLabel: UILabel!
    @IBOutlet weak var hourThreeLabel: UILabel!
    @IBOutlet weak var hourFourLabel: UILabel!
    @IBOutlet weak var conditionsOneImage: UIImageView!
    @IBOutlet weak var conditionsTwoImage: UIImageView!
    @IBOutlet weak var conditionsThreeImage: UIImageView!
    @IBOutlet weak var conditionsFourImage: UIImageView!
    @IBOutlet weak var tempOneLabel: UILabel!
    @IBOutlet weak var tempTwoLabel: UILabel!
    @IBOutlet weak var tempThreeLabel: UILabel!
    @IBOutlet weak var tempFourLabel: UILabel!
    @IBOutlet weak var windOneLabel: UILabel!
    @IBOutlet weak var windTwoLabel: UILabel!
    @IBOutlet weak var windThreeLabel: UILabel!
    @IBOutlet weak var windFourLabel: UILabel!
    @IBOutlet weak var precipOneLabel: UILabel!
    @IBOutlet weak var precipTwoLabel: UILabel!
    @IBOutlet weak var precipThreeLabel: UILabel!
    @IBOutlet weak var precipFourLabel: UILabel!

    @IBOutlet weak var dayOneLabel: UILabel!
    @IBOutlet weak var dayTwoLabel: UILabel!
    @IBOutlet weak var dayThreeLabel: UILabel!

    @IBOutlet weak var conditionsDayOneImage: UIImageView!
    @IBOutlet weak var conditionsDayTwoImage: UIImageView!
    @IBOutlet weak var conditionsDayThreeImage: UIImageView!
    @IBOutlet weak var tempDayOneLabel: UILabel!
    @IBOutlet weak var tempDayTwoLabel: UILabel!
    @IBOutlet weak var tempDayThreeLabel: UILabel!
    @IBOutlet weak var windDayOneLabel: UILabel!
    @IBOutlet weak var windDayTwoLabel: UILabel!
    @IBOutlet weak var windDayThreeLabel: UILabel!
    @IBOutlet weak var precipDayOneLabel: UILabel!
    @IBOutlet weak var precipDayTwoLabel: UILabel!
    @IBOutlet weak var precipDayThreeLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateViewWithData()

    }

    func updateViewWithData() {

        if let tempF = self.weather.tempF {
            self.currentTempLabel.text = String(tempF) + "˚F"
        }

        if let conditions = self.weather.weatherDescription {
            self.conditionsLabel.text = conditions;
        }


        if var urlString = self.weather.iconURL{
            if let range = urlString.rangeOfString("/k/"){
                urlString.removeRange(range)
                urlString.splice("/i/", atIndex: range.startIndex)
                if let url = NSURL(string: urlString){
                    if let data = NSData(contentsOfURL: url){
                        self.conditionsImage.image = UIImage(data: data)
                    }
                }
            }
        }

        if let simpleForecast =  self.weather.simpleForecast{
            if let forecastDay = simpleForecast.valueForKey("forecastday") as? NSArray{
                if let highs = forecastDay.objectAtIndex(0).valueForKey("high") as? NSDictionary{
                    if let lows = forecastDay.objectAtIndex(0).valueForKey("low") as? NSDictionary{
                        if let highValue = highs.valueForKey("fahrenheit") as? String{
                            if let lowValue = lows.valueForKey("fahrenheit") as? String{
                                self.highLowTempLabel.text = highValue + "˚F" + "/" + lowValue + "˚F"
                            }
                        }
                    }
                }
            }
        }

        if let wind =  self.weather.windSpeedMPH{
            if let windDir = self.weather.windDirection{
                self.windLabel.text = String(wind) + " mph " + windDir
            }
        }

        if let forecastDay = self.weather.textForecast?.objectForKey("forecastday") as? NSArray{
            if let precip = forecastDay.objectAtIndex(0).valueForKey("pop") as? String{
                self.precipLabel.text = precip + "%"
            }
        }

        if let recentPrecip =  self.weather.precipToday {
            self.recentPrecipLabel.text = recentPrecip
        }


        if let hourlyTimeInfo = self.weather.hourlyTimeInfo?.objectAtIndex(0)["FCTTIME"] as? NSDictionary {
            if var hourText = hourlyTimeInfo.valueForKey("civil") as? String{
                if let range = hourText.rangeOfString(":00 "){
                    hourText.removeRange(range)
                    self.hourOneLabel.text = hourText
                }
            }
        }

        if let hourlyTimeInfo = self.weather.hourlyTimeInfo?.objectAtIndex(1)["FCTTIME"] as? NSDictionary {
            if var hourText = hourlyTimeInfo.valueForKey("civil") as? String{
                if let range = hourText.rangeOfString(":00 "){
                    hourText.removeRange(range)
                    self.hourTwoLabel.text = hourText
                }
            }
        }

        if let hourlyTimeInfo = self.weather.hourlyTimeInfo?.objectAtIndex(2)["FCTTIME"] as? NSDictionary {
            if var hourText = hourlyTimeInfo.valueForKey("civil") as? String{
                if let range = hourText.rangeOfString(":00 "){
                    hourText.removeRange(range)
                    self.hourThreeLabel.text = hourText
                }
            }
        }

        if let hourlyTimeInfo = self.weather.hourlyTimeInfo?.objectAtIndex(3)["FCTTIME"] as? NSDictionary {
            if var hourText = hourlyTimeInfo.valueForKey("civil") as? String{
                if let range = hourText.rangeOfString(":00 "){
                    hourText.removeRange(range)
                    self.hourFourLabel.text = hourText
                }
            }
        }

        if var urlString = self.weather.hourlyTimeInfo?.objectAtIndex(0)["icon_url"] as? String{
            if let range = urlString.rangeOfString("/k/"){
                urlString.removeRange(range)
                urlString.splice("/i/", atIndex: range.startIndex)
            }

            if let url = NSURL(string: urlString){
                if let data = NSData(contentsOfURL: url){
                self.conditionsOneImage.image = UIImage(data: data)
                }
            }
        }

        if var urlString = self.weather.hourlyTimeInfo?.objectAtIndex(1)["icon_url"] as? String{
            if let range = urlString.rangeOfString("/k/"){
                urlString.removeRange(range)
                urlString.splice("/i/", atIndex: range.startIndex)
            }
            if let url = NSURL(string: urlString){
                if let data = NSData(contentsOfURL: url){
                    self.conditionsTwoImage.image = UIImage(data: data)
                }
            }
        }

        if var urlString = self.weather.hourlyTimeInfo?.objectAtIndex(2)["icon_url"] as? String{
            if let range = urlString.rangeOfString("/k/"){
                urlString.removeRange(range)
                urlString.splice("/i/", atIndex: range.startIndex)
            }
            if let url = NSURL(string: urlString){
                if let data = NSData(contentsOfURL: url){
                    self.conditionsThreeImage.image = UIImage(data: data)
                }
            }
        }

        if var urlString = self.weather.hourlyTimeInfo?.objectAtIndex(3)["icon_url"] as? String{
            if let range = urlString.rangeOfString("/k/"){
                urlString.removeRange(range)
                urlString.splice("/i/", atIndex: range.startIndex)
            }
            if let url = NSURL(string: urlString){
                if let data = NSData(contentsOfURL: url){
                    self.conditionsFourImage.image = UIImage(data: data)
                }
            }
        }

        if let hourlyTemp = self.weather.hourlyTimeInfo?.objectAtIndex(0)["temp"] as? NSDictionary{
            if let hourlyTempEng = hourlyTemp.valueForKey("english") as? String{
                self.tempOneLabel.text = hourlyTempEng + "°F"
            }
        }
        if let hourlyTemp = self.weather.hourlyTimeInfo?.objectAtIndex(1)["temp"] as? NSDictionary{
            if let hourlyTempEng = hourlyTemp.valueForKey("english") as? String{
                self.tempTwoLabel.text = hourlyTempEng + "°F"
            }
        }
        if let hourlyTemp = self.weather.hourlyTimeInfo?.objectAtIndex(2)["temp"] as? NSDictionary{
            if let hourlyTempEng = hourlyTemp.valueForKey("english") as? String{
                self.tempThreeLabel.text = hourlyTempEng + "°F"
            }
        }
        if let hourlyTemp = self.weather.hourlyTimeInfo?.objectAtIndex(3)["temp"] as? NSDictionary{
            if let hourlyTempEng = hourlyTemp.valueForKey("english") as? String{
                self.tempFourLabel.text = hourlyTempEng + "°F"
            }
        }

        if let hourlyWind = self.weather.hourlyTimeInfo?.objectAtIndex(0)["wspd"] as? NSDictionary{
            if let hourlyWindEng = hourlyWind.valueForKey("english") as? String{
                self.windOneLabel.text = hourlyWindEng + " mph"
            }
        }
        if let hourlyWind = self.weather.hourlyTimeInfo?.objectAtIndex(1)["wspd"] as? NSDictionary{
            if let hourlyWindEng = hourlyWind.valueForKey("english") as? String{
                self.windTwoLabel.text = hourlyWindEng + " mph"
            }
        }
        if let hourlyWind = self.weather.hourlyTimeInfo?.objectAtIndex(2)["wspd"] as? NSDictionary{
            if let hourlyWindEng = hourlyWind.valueForKey("english") as? String{
                self.windThreeLabel.text = hourlyWindEng + " mph"
            }
        }
        if let hourlyWind = self.weather.hourlyTimeInfo?.objectAtIndex(3)["wspd"] as? NSDictionary{
            if let hourlyWindEng = hourlyWind.valueForKey("english") as? String{
                self.windFourLabel.text = hourlyWindEng + " mph"
            }
        }

        if let hourlyPop = self.weather.hourlyTimeInfo?.objectAtIndex(0)["pop"] as? String{
            self.precipOneLabel.text = hourlyPop + "%"
        }
        if let hourlyPop = self.weather.hourlyTimeInfo?.objectAtIndex(1)["pop"] as? String{
            self.precipTwoLabel.text = hourlyPop + "%"
        }
        if let hourlyPop = self.weather.hourlyTimeInfo?.objectAtIndex(2)["pop"] as? String{
            self.precipThreeLabel.text = hourlyPop + "%"
        }
        if let hourlyPop = self.weather.hourlyTimeInfo?.objectAtIndex(3)["pop"] as? String{
            self.precipFourLabel.text = hourlyPop + "%"
        }

        if let forecastDay = self.weather.simpleForecast?.objectForKey("forecastday") as? NSArray{
            if let date = forecastDay.objectAtIndex(1).valueForKey("date") as? NSDictionary{
                if let dateString = date.valueForKey("weekday") as? String{
                    self.dayOneLabel.text = dateString
                }
            }
        }

        if let forecastDay = self.weather.simpleForecast?.objectForKey("forecastday") as? NSArray{
            if let date = forecastDay.objectAtIndex(2).valueForKey("date") as? NSDictionary{
                if let dateString = date.valueForKey("weekday") as? String{
                    self.dayTwoLabel.text = dateString
                }
            }
        }

        if let forecastDay = self.weather.simpleForecast?.objectForKey("forecastday") as? NSArray{
            if let date = forecastDay.objectAtIndex(3).valueForKey("date") as? NSDictionary{
                if let dateString = date.valueForKey("weekday") as? String{
                    self.dayThreeLabel.text = dateString
                }
            }
        }

        if let forecastDay = self.weather.simpleForecast?.objectForKey("forecastday") as? NSArray{
            if var urlString = forecastDay.objectAtIndex(1).valueForKey("icon_url") as? String{
                if let range = urlString.rangeOfString("/k/"){
                    urlString.removeRange(range)
                    urlString.splice("/i/", atIndex: range.startIndex)
                }
                if let url = NSURL(string: urlString){
                    if let data = NSData(contentsOfURL: url){
                        self.conditionsDayOneImage.image = UIImage(data: data)
                    }
                }
            }
        }

        if let forecastDay = self.weather.simpleForecast?.objectForKey("forecastday") as? NSArray{
            if var urlString = forecastDay.objectAtIndex(2).valueForKey("icon_url") as? String{
                if let range = urlString.rangeOfString("/k/"){
                    urlString.removeRange(range)
                    urlString.splice("/i/", atIndex: range.startIndex)
                }
                if let url = NSURL(string: urlString){
                    if let data = NSData(contentsOfURL: url){
                        self.conditionsDayTwoImage.image = UIImage(data: data)
                    }
                }
            }
        }

        if let forecastDay = self.weather.simpleForecast?.objectForKey("forecastday") as? NSArray{
            if var urlString = forecastDay.objectAtIndex(3).valueForKey("icon_url") as? String{
                if let range = urlString.rangeOfString("/k/"){
                    urlString.removeRange(range)
                    urlString.splice("/i/", atIndex: range.startIndex)
                }
                if let url = NSURL(string: urlString){
                    if let data = NSData(contentsOfURL: url){
                        self.conditionsDayThreeImage.image = UIImage(data: data)
                    }
                }
            }
        }

        if let forecastDay = self.weather.simpleForecast?.objectForKey("forecastday") as? NSArray{
            if let let high = forecastDay.objectAtIndex(1).valueForKey("high") as? NSDictionary{
                if let low = forecastDay.objectAtIndex(1).valueForKey("low") as? NSDictionary{
                    if let highValue = high.valueForKey("fahrenheit") as? String{
                        if let lowValue = low.valueForKey("fahrenheit") as? String{
                            self.tempDayOneLabel.text = highValue + "°F/" + lowValue + "°F"
                        }}
                }
            }
        }

        if let forecastDay = self.weather.simpleForecast?.objectForKey("forecastday") as? NSArray{
            if let let high = forecastDay.objectAtIndex(2).valueForKey("high") as? NSDictionary{
                if let low = forecastDay.objectAtIndex(2).valueForKey("low") as? NSDictionary{
                    if let highValue = high.valueForKey("fahrenheit") as? String{
                        if let lowValue = low.valueForKey("fahrenheit") as? String{
                            self.tempDayTwoLabel.text = highValue + "°F/" + lowValue + "°F"
                        }}
                }
            }
        }

        if let forecastDay = self.weather.simpleForecast?.objectForKey("forecastday") as? NSArray{
            if let let high = forecastDay.objectAtIndex(3).valueForKey("high") as? NSDictionary{
                if let low = forecastDay.objectAtIndex(3).valueForKey("low") as? NSDictionary{
                    if let highValue = high.valueForKey("fahrenheit") as? String{
                        if let lowValue = low.valueForKey("fahrenheit") as? String{
                            self.tempDayThreeLabel.text = highValue + "°F/" + lowValue + "°F"
                        }}
                }
            }
        }

        if let forecastDay = self.weather.simpleForecast?.objectForKey("forecastday") as? NSArray{
            if let aveWind = forecastDay.objectAtIndex(1).valueForKey("avewind") as? NSDictionary{
                if let wind = aveWind.valueForKey("mph") as? Int{
                    self.windDayOneLabel.text = String(wind) + " mph"
                }
            }
        }

        if let forecastDay = self.weather.simpleForecast?.objectForKey("forecastday") as? NSArray{
            if let aveWind = forecastDay.objectAtIndex(2).valueForKey("avewind") as? NSDictionary{
                if let wind = aveWind.valueForKey("mph") as? Int{
                    self.windDayTwoLabel.text = String(wind) + " mph"
                }
            }
        }

        if let forecastDay = self.weather.simpleForecast?.objectForKey("forecastday") as? NSArray{
            if let aveWind = forecastDay.objectAtIndex(3).valueForKey("avewind") as? NSDictionary{
                if let wind = aveWind.valueForKey("mph") as? Int{
                    self.windDayThreeLabel.text = String(wind) + " mph"
                }
            }
        }

        if let forecastDay = self.weather.textForecast?.objectForKey("forecastday") as? NSArray{
            if let precip = forecastDay.objectAtIndex(1).valueForKey("pop") as? String{
                self.precipDayOneLabel.text = precip + "%"
            }
        }
        if let forecastDay = self.weather.textForecast?.objectForKey("forecastday") as? NSArray{
            if let precip = forecastDay.objectAtIndex(2).valueForKey("pop") as? String{
                self.precipDayTwoLabel.text = precip + "%"
            }
        }
        if let forecastDay = self.weather.textForecast?.objectForKey("forecastday") as? NSArray{
            if let precip = forecastDay.objectAtIndex(3).valueForKey("pop") as? String{
                self.precipDayThreeLabel.text = precip + "%"
            }
        }

        

        



        




    }




}