//
//  CurrentWeatherViewController.swift
//  CraftsburySkiing
//
//  Created by Philip Henson on 7/19/15.
//  Copyright (c) 2015 Philip Henson. All rights reserved.
//

import ReachabilitySwift
import UIKit

class CurrentWeatherViewController: UIViewController {



    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var conditionsIcon: UIImageView!
    @IBOutlet weak var kmOpenLabel: UILabel!
    @IBOutlet weak var snowfallLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!

    var weather: WeatherData!

    override func viewDidLoad() {
        super.viewDidLoad()

        // if network connection, get data
        
        let reachability = Reachability.reachabilityForInternetConnection()

        reachability.whenReachable = { reachability in
            if reachability.isReachableViaWiFi() {
                println("Reachable via WiFi")
            } else {
                println("Reachable via Cellular")
            }

            // TODO: Check conditions to see if English or Metric units are selected

            // Initialize weatherData with API call in class init()
            var weatherData = WeatherData();

            // Initialize trailStatus with HTTP request in class init()
            var trailStatus = TrailStatus();

            self.updateViewWithData(weatherData, trails: trailStatus)



        }
        reachability.whenUnreachable = { reachability in
            println("Not reachable")
            var alert = UIAlertController(title: "Network Unavailable", message: "Can't update weather without internet connection.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)

        }

        reachability.startNotifier()
    }
    func updateViewWithData(weather: WeatherData, trails: TrailStatus){
        // Populate view

        self.weather = weather

        if var rawDate = self.weather.timeStringRFC822 {
            let range = advance(rawDate.endIndex, -15)..<rawDate.endIndex
            rawDate.removeRange(range)
            self.dateLabel.text = rawDate
        }

        if let tempF = self.weather.tempF {
            self.tempLabel.text = String(tempF)
        }

        if let conditions = self.weather.weatherDescription {
            self.conditionsLabel.text = conditions;
        }

        if let urlString = self.weather.iconURL{
            if let url = NSURL(string: urlString){
                if let data = NSData(contentsOfURL: url){
                    self.conditionsIcon.image = UIImage(data: data)
                }
            }
        }

        if var lastUpdated = self.weather.localTimeString{
            if let range = lastUpdated.rangeOfString("-0500"){
                lastUpdated.removeRange(range)
                self.lastUpdatedLabel.text = lastUpdated
            }

        }

        // HTML DATA HERE

        if let kmOpenString = trails.kmOpenData{
            self.kmOpenLabel.text = kmOpenString

        }

        if let snowfallString = trails.snowfallData{
            self.snowfallLabel.text = snowfallString
        }




    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showForecast"
        {
            let destinationVC = segue.destinationViewController as ForecastViewController
            destinationVC.weatherData = self.weather
        }
        else if segue.identifier == "showTrailStatus"
        {
            let destinationVC = segue.destinationViewController as TrailStatusViewController
            destinationVC.weatherData = self.weather
        }
        else
        {
            let destinationVC = segue.destinationViewController as SettingsViewController
            destinationVC.weatherData = self.weather
        }

    }



}
