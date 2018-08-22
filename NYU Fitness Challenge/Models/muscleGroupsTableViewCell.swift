//
//  muscleGroupsTableViewCell.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/23/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit

class muscleGroupsTableViewCell: UITableViewCell {
    @IBOutlet weak var muscleGroups: UILabel!
    var testing: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
