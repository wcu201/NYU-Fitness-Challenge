//
//  TrainTableViewCell.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 7/6/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit

class TrainTableViewCell: UITableViewCell {
    @IBOutlet weak var trainBTN: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trainBTN.layer.cornerRadius = 20
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
