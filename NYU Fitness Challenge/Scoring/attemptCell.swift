//
//  attemptCell.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 7/9/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit

class attemptCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var performance: UILabel!
    
    @IBOutlet weak var points: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
