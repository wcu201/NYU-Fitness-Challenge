//
//  Challenge.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/21/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import Foundation
import UIKit


class Challenge {
    var key: String?
    var score: Int?
    var uid: String?
    var event: Event?
    var date: NSDate?
    
    init() {
    }
    
    init(score: Int, uid: String, event: Event, date: NSDate) {
        self.score = score
        self.date = date
        self.uid = uid
        self.event = event
    }
    
    init(score: Int) {
        self.score = score
    }
    
    init(score: Int, eventName: Event, attemptDate: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        
        self.score = score
        self.event = eventName
        self.date = dateFormatter.date(from: attemptDate) as! NSDate
        
    }
    
}

extension Challenge: Hashable, Equatable
{
    public static func ==(lhs: Challenge, rhs: Challenge) -> Bool
    {
        return lhs.key == rhs.key
    }
    
    public var hashValue: Int
    {
        return self.key!.hashValue
    }
}
