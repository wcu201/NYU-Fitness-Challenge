//
//  ScoringFunctions.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 7/12/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

struct scoring {
    
    func findBestScoreFromAttempt(snap: DataSnapshot)->DataSnapshot{
        
        let attempts = snap.children.allObjects
        //print ("Size: " + "\(attempts.count)")
        //print ("Station Key: " + snap.key)
        var maxIndex = 0
        for (index, _) in attempts.enumerated() {
            let max = ((attempts[maxIndex] as? DataSnapshot)?.value as? Int)
            let currentVal = ((attempts[index] as? DataSnapshot)?.value as? Int)
            
            if currentVal! > max! {
                maxIndex = index
            }
        }
        
        return (attempts[maxIndex] as? DataSnapshot)!
        
    }
    
    func findUserTopScoresAllEvents()->[Int]{
        var topScores = [Int]()
        
        let scoresRef = Database.database().reference(withPath: "scores")
        
        scoresRef.observe(.value, with: {(snapshot) in
            
            let stations = snapshot.children.allObjects
            for station in stations {
                let userAttempts = (station as? DataSnapshot)?.childSnapshot(forPath: (Auth.auth().currentUser?.uid)!).childSnapshot(forPath: "attempts")
                
                let stationScore = self.findBestScoreFromAttempt(snap: userAttempts!).value as? Int
                topScores.append(stationScore!)
                
            }
            
        })
        
        return topScores
    }
    
    
    
    
}

