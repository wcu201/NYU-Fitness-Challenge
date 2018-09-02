//
//  stationButton.swift
//  NYU Fitness Challenge
//
//  Created by Brienne Renfurm on 8/30/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit

class stationButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if imageView?.image != nil {
            //print ("Button has image: ",titleLabel?.text, " ", bounds.width/2 - (titleLabel?.frame.width)!/2)
            
            alignVertical()
            /*
            imageEdgeInsets = UIEdgeInsets(top: -95, left: (bounds.width/2 - (imageView?.frame.width)!/2), bottom: 0, right: 0)
            print("inset: ", (titleLabel?.frame.width)!/2)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: (bounds.width/2 - (titleLabel?.frame.width)!/2), bottom: 0, right: 0)*/
        }
        else {
            print ("Button has no image")
        }
    }
    
    func alignVertical(spacing: CGFloat = 6.0) {
        guard let imageSize = self.imageView?.image?.size,
            let text = self.titleLabel?.text,
            let font = self.titleLabel?.font
            else { return }
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [NSAttributedStringKey.font: font])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
    }

}
