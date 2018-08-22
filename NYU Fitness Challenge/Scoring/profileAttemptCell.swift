//
//  profileAttemptCell.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 7/11/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit

class profileAttemptCell: UITableViewCell {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var overallPoints: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
