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
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    var weather: WeatherData!
    var trailStatus: TrailStatus!

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
        }
        reachability.whenUnreachable = { reachability in
            println("Not reachable")
        }

        if reachability.isReachable(){

            // TODO: Check conditions to see if English or Metric units are selected
            // Initialize weatherData with API call in class init()
            self.activityIndicatorView.startAnimating()
            self.activityIndicatorView.hidesWhenStopped = true
            
            self.getWeatherAndTrailStatus()

        } else{
            var alert = UIAlertController(title: "Network Unavailable", message: "Can't update weather without internet connection.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

        reachability.startNotifier()

    }

    func getWeatherAndTrailStatus() {

        var newRequest = WeatherRequest()
        var trailStatus = TrailStatus()
        trailStatus.parseHTML()
        newRequest.requestWeather{ (weather, error) in
            if let latestWeather = weather {
                self.updateViewWithData(latestWeather, trails: trailStatus)
                self.activityIndicatorView.stopAnimating()

            } else {
                // Handle error here
            }
        }


    }
    func updateViewWithData(weather: WeatherData, trails: TrailStatus){
        // Populate view

        self.weather = weather
        self.trailStatus = trails

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

        if let kmOpenString = self.trailStatus.kmOpenData{
            self.kmOpenLabel.text = kmOpenString

        }

        if let snowfallString = self.trailStatus.snowfallData{
            self.snowfallLabel.text = snowfallString
        }


    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showForecast"
        {
            if let destinationVC = segue.destinationViewController as? ForecastViewController{
                destinationVC.weather = self.weather
            }
        }

        if segue.identifier == "showTrailStatus"
        {
            if let destinationVC = segue.destinationViewController as? TrailStatusViewController {
                destinationVC.trails = self.trailStatus
            }
        }

    }

    func reachabilityChanged(note: NSNotification) {

        let reachability = note.object as! Reachability

        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                println("Reachable via WiFi")
            } else {
                println("Reachable via Cellular")
            }
        } else {
            println("Not reachable")
        }
    }



}
