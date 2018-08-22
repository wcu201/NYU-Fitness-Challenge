//
//  File.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/20/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn


var currentUser: NUser?
var currentUserDatabaseReference: DatabaseReference?
var currentImage: String?

enum Gender: Int
{
    case Female
    case Male
    case Other
}

class NUser: DictionaryRep {
    var fname: String?
    var lname: String?
    var gender: Gender?
    var uid: String?
    var scores: [Challenge]?
    var overallScore = Int()
    var challenges: Set<Challenge>?
    var imageURL: String?
    var ProfilePicture: UIImage?
    var attempts = [Attempt]()
    var attemptStrings: [String]?
    var bestScores = [Int]()
    var userType: String?
    
    init(snapshot: DataSnapshot) {
        
        if snapshot.value == nil { return }
        //let key = (snapshot.value as? NSDictionary)?.allKeys.first
        if let value: NSDictionary = snapshot.childSnapshot(forPath: (Auth.auth().currentUser?.uid)!).value as? NSDictionary
        {
            self.fname = value["first_name"] as? String ?? ""
            self.lname = value["last_name"] as? String ?? ""
            self.gender = Gender(rawValue: value["gender"] as? Int ?? 0) //?? Gender(rawValue: 0)
            self.uid = Auth.auth().currentUser?.uid ?? ""
            self.userType = value["userType"] as? String ?? ""
            self.imageURL = UserDefaults.standard.string(forKey: "imageURL")
            //self.imageURL = GIDProfileData.imageURL(<#T##GIDProfileData#>)/*value["imageURL"] as? String ?? ""*/
            self.overallScore = value["overall"] as? Int ?? 0
            self.challenges = value[""] as? Set<Challenge> ?? []
            self.scores = []
            //self.attempts = [Attempt(date: "2018-07-04T17:45:47+0000")]
            addAttempts(){(theAttempts) in
                self.attempts = theAttempts
                self.attempts.remove(at: 0)
            }
            findUserTopScoresAllEvents(){(scores) in
                self.bestScores = scores
            }
            //[Attempt(date: "2018-07-04T17:45:47+0000")]
        }
        
        
    }

    
    init(userObj: NUser) {
        self.fname = userObj.fname ?? ""
        self.lname = userObj.lname ?? ""
        self.gender = userObj.gender ?? Gender(rawValue: 0)
        self.uid = userObj.uid ?? ""
        self.overallScore = userObj.overallScore ?? 0
        self.challenges = userObj.challenges ?? []
    }
    
    init(userObj: NUser, aScore: Int) {
        self.fname = userObj.fname ?? ""
        self.lname = userObj.lname ?? ""
        self.gender = userObj.gender ?? Gender(rawValue: 0)
        self.uid = userObj.uid ?? ""
        self.overallScore = userObj.overallScore ?? 0
        self.challenges = userObj.challenges ?? []
        self.scores = [Challenge(score: aScore)]
    }
    

    init() {
    }
    
    func addScores(newScores: [Challenge]){
        self.scores = newScores
    }
    
    func addScore(newScore: Challenge){
        scores?.append(newScore)
    }
    
    func addAttempts(completion: @escaping ([Attempt]) -> ()){
        //var userAttempts = ["String"]
        var userAttempts = [Attempt(date: "2000-07-04T17:45:47+0000")]
        let ref = Database.database().reference(withPath: "users").child((Auth.auth().currentUser?.uid)!).child("attempts")
        
        ref.observe(.value, with: {(snapshot) in
            let theAttempts = snapshot.children.allObjects
            for attempt in theAttempts {
                let attemptDate = ((attempt as? DataSnapshot)?.value as? String)
                userAttempts.append(Attempt(date: attemptDate!))
            }
            completion(userAttempts)
            //return userAttempts
        })
    
        //return userAttempts!
    }
    
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
    
    func findUserTopScoresAllEvents(completion: @escaping ([Int])->()){
        var topScores = [Int]()
        
        let scoresRef = Database.database().reference(withPath: "scores")
        
        scoresRef.observe(.value, with: {(snapshot) in
            
            let stations = snapshot.children.allObjects
            for station in stations {
                let userAttempts = (station as? DataSnapshot)?.childSnapshot(forPath: (Auth.auth().currentUser?.uid)!).childSnapshot(forPath: "attempts")
                
                if (userAttempts?.exists())! {
                let stationScore = self.findBestScoreFromAttempt(snap: userAttempts!).value as? Int
                topScores.append(stationScore!)
                }
                
            }
            completion(topScores)
        })
        
        //return topScores
    }
    
    func downloadUser(for user: NUser, completion: ((_ theUser: NUser?) -> ())? = nil, failure: (()->())? = nil) {
        let usersRef = Database.database().reference(withPath: "users")
        let uid = Auth.auth().currentUser?.uid

        usersRef.queryOrderedByKey().queryEqual(toValue: uid).observeSingleEvent(of: .value, with: { (snapshot) in
            //self.authUser = NUser(snapshot: snapshot)
            currentUser = NUser(snapshot: snapshot)
            completion?(currentUser)

            
        })
    }
    
}
