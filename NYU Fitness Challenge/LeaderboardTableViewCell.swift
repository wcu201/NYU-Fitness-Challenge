//
//  LeaderboardTableViewCell.swift
//  NYU Fitness Challenge
//
//  Created by Brienne Renfurm on 4/17/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {
    @IBOutlet weak var leaderboardScore: UILabel!
    @IBOutlet weak var leaderboardName: UILabel!
    @IBOutlet weak var leaderboardRank: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
