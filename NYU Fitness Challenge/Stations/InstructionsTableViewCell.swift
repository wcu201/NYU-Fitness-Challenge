//
//  InstructionsTableViewCell.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 7/7/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class InstructionsTableViewCell: UITableViewCell {
    let videoController = AVPlayerViewController()
    
    override func awakeFromNib() {
        //addVideo(videoURL: instructionsPath!)
        super.awakeFromNib()
        // Initialization code
    }

    //"/Users/williamuchegbu/Documents/GitHub/NYU-Fitness-Challenge/NYU Fitness Challenge/Videos/Brooklyn Athletic Facility Mannequin Challenge.mp4"
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addVideo(videoURL: String){
        let path = Bundle.main.path(forResource: videoURL, ofType: "mp4")
        let url = URL(fileURLWithPath: path!)
        
        let video = AVPlayer(url: url)
        videoController.player = video
        videoController.view.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
        //videoController.entersFullScreenWhenPlaybackBegins = true
        //videoController.player?.play()
        self.contentView.addSubview(videoController.view)
    }

}
