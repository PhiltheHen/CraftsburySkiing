//
//  CurrentView.swift
//  CraftsburySkiing
//
//  Created by Philip Henson on 7/19/15.
//  Copyright (c) 2015 Philip Henson. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD
import TFHpple
import TFHppleElement
import AFNetworking
import AppDelegate
import Observation
import Reachability
import weatherRequest

class CurrentView: UIViewController {
    
    var dateLabel: UILabel?
    var tempLabel: UILabel?
    var conditionsLabel: UILabel?
    var conditionsIcon: UIImageView?
    var kmOpenLabel: UILabel?
    
    var snowfallLabel: UILabel?
    var lastUpdatedLabel: UILabel?
    
    var internetReachable: Reachability?
    var hostReachable: Reachability?


    override func viewDidLoad() {
        super.viewDidLoad()

        // if network connection, get data
        
        internetReachable = Reachability.reachabilityForInternetConnection();
        
        if (CurrentView.getConnectivity()) {
            reloadData()
            parseHTMLFileAtURL()
            
        } else {
            
            var alert = UIAlertController(title: "Network Unavailable", message: "Can't update weather without internet connection.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
