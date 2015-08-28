
//
//  TrailCell.swift
//  CraftsburySkiing
//
//  Created by Philip Henson on 8/26/15.
//  Copyright (c) 2015 Philip Henson. All rights reserved.
//

import UIKit

class TrailCell: UITableViewCell {
    
    @IBOutlet weak var trailName: UILabel!
    @IBOutlet weak var trailGroomed: UILabel!
    @IBOutlet weak var trailNote: UILabel!
    @IBOutlet weak var trailImage: UIImageView!
    @IBOutlet weak var trailOpen: UILabel!
    @IBOutlet weak var trailClosed: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
