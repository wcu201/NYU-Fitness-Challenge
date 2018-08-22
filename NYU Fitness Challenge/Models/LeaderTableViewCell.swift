//
//  LeaderTableViewCell.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/21/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit

class LeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var arrowIcon: UIImageView!
    @IBOutlet weak var challengeIcon: UIImageView!
    
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var second: UILabel!
    @IBOutlet weak var third: UILabel!
    @IBOutlet weak var fourth: UILabel!
    @IBOutlet weak var fifth: UILabel!
    
    @IBOutlet weak var firstScore: UILabel!
    @IBOutlet weak var secondScore: UILabel!
    @IBOutlet weak var thirdScore: UILabel!
    @IBOutlet weak var fourthScore: UILabel!
    @IBOutlet weak var fifthScore: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
