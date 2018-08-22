//
//  Attempt.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 7/10/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class Attempt {
    //var station: String = ""
    var date: Date?
    var performance: String = ""
    var scores = [Int]()
    
    init(date: String){
        let isoDate = stringToDate(str: date)
        self.date = isoDate
        
        var attemptScores = [Int]()
        
        let ref = Database.database().reference(withPath: "scores")
        
        ref.observe(.value, with: {(snapshot) in
            
            let stations = (snapshot.children.allObjects)
            
            for station in stations {
                
                let stationSnap = (station as? DataSnapshot)
                
                if (stationSnap?.key == "row machine" || stationSnap?.key == "rope machine") {
    
                }
                else {
                    let attemptScore = stationSnap?.childSnapshot(forPath: (Auth.auth().currentUser?.uid)!).childSnapshot(forPath: "attempts").childSnapshot(forPath: date)
                
                    if (attemptScore?.exists())!{
                        attemptScores.append((attemptScore?.value as? Int)!)
                 
                    }
                    else {
                        attemptScores.append(0)
                    }
                }
            }
            
            self.scores = attemptScores
            
        })
        
    }
    
    init(){
        
    }
    
    func stringToDate(str: String) -> Date{
        //let isoDate = "2016-04-14T10:44:00+0000"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from:str)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let finalDate = calendar.date(from:components)
        
        return date
    }
}
