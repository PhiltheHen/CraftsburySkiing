//
//  TrailStatusViewController.swift
//  CraftsburySkiing
//
//  Created by Philip Henson on 8/26/15.
//  Copyright (c) 2015 Philip Henson. All rights reserved.
//

import UIKit

class TrailStatusViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    var trails: TrailStatus!

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trails.trailNamesData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TrailCell

        let trailName = self.trails.trailNamesData[indexPath.row]
        let trailLength = self.trails.trailLengthsData[indexPath.row]
        let trailStatus = self.trails.trailStatusData[indexPath.row]
        let trailNote = self.trails.trailNote[indexPath.row]
        let trailGroomed = self.trails.trailDateGroomed[indexPath.row]
        let trailDifficulty = self.trails.trailDifficulty[indexPath.row]

        cell.trailName.text = trailName + " (" + trailLength + ")"

        if trailNote != "%nbsp"{
            cell.trailNote.text = "Note: \(trailNote)"
        }

        if trailGroomed != "%nbsp" {
            cell.trailGroomed.text = "Groomed: \(trailGroomed)"
        }

        if trailDifficulty == "beginner"{
            cell.trailImage.image = UIImage(named: "beginnerTrail")
        } else if trailDifficulty == "intermediate"{
            cell.trailImage.image = UIImage(named: "intermediateTrail")
        } else if trailDifficulty == "advanced"{
            cell.trailImage.image = UIImage(named: "advancedTrail")
        } else{
            cell.trailImage.image = UIImage(named: "unknownTrail")
        }


        if trailStatus == "OPEN"{
            cell.trailOpen.text = "OPEN"
            cell.trailClosed.text = ""
        } else {
            cell.trailClosed.text = "Closed"
            cell.trailOpen.text = ""
        }

        return cell
    }
}