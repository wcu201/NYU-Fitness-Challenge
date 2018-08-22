//
//  AppDelegate.swift
//  NYU Fitness Challenge
//
//  Created by Brienne Renfurm on 4/16/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?
    var authUser = NUser()
    var infoVideo = UIWebView()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        //GIDSignIn.sharedInstance().signOut()
        //do{try Auth.auth().signOut()} catch{}
        
        //Database.database().isPersistenceEnabled = true
       
        
        /*
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                self.load() {(theUser) in
                    print("User Downloaded")
                    
                let storageRef = Storage.storage().reference().child((Auth.auth().currentUser?.uid)!)
                storageRef.getData(maxSize: (3*1000*1000), completion: {(data, error) in
                    if (error != nil) {
                        print("Error downloading image: " + (error?.localizedDescription)!)
                    }
                    else {
                        currentUser?.ProfilePicture = UIImage(data: data!)
                    }
                })
                
                
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeTab")
                
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = vc
                self.window?.makeKeyAndVisible()
                print ("User logged in: " + (Auth.auth().currentUser?.email)!)
                }
                //print ("User: " + (currentUser?.fname)! + " " + (currentUser?.lname)!)
            }
            else {
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login")
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = vc
                self.window?.makeKeyAndVisible()
                print ("No user logged in")
            }
        }*/
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func loadUser(){
        
        let usersRef = Database.database().reference(withPath: "users")
        let scoreRef = Database.database().reference(withPath: "scores")
        if currentUser == nil {
            let uid = Auth.auth().currentUser?.uid
            
            //usersRef.child("testing").setValue("testing")
            
            /*usersRef.observe(.value, with: {(snapshot) in
                
            })*/
            
            usersRef.queryOrderedByKey().queryEqual(toValue: uid).observeSingleEvent(of: .value, with: { (snapshot) in
                //self.authUser = NUser(snapshot: snapshot)
                currentUser = NUser(snapshot: snapshot)
            })
            
            
            scoreRef.observeSingleEvent(of: .value, with: {(snapshot) in
                for event in snapshot.children.allObjects {
                    
                    
                    let ref = (event as! DataSnapshot).childSnapshot(forPath: (Auth.auth().currentUser?.uid)!)
                    
                    if ref.exists(){
                        let val = (event as! DataSnapshot).childSnapshot(forPath: (Auth.auth().currentUser?.uid)!).childSnapshot(forPath: "score").value as! Int
                        let date = (event as! DataSnapshot).childSnapshot(forPath: (Auth.auth().currentUser?.uid)!).childSnapshot(forPath: "date").value as! String
                        let station = Event(eventName: ((event as? DataSnapshot)?.key)!)
                        
                        //print((event as AnyObject).name)
                        if !(date.isEmpty) {
                            currentUser?.addScore(newScore: Challenge(score: val, eventName: station, attemptDate: date))
                        }
                    }

                    
                    
                    
                    
                }
                
            })
            
           
            /*scoreRef.queryOrderedByKey().observe(.value, with: { (snapshot) in
                for scorers in snapshot.children.allObjects {
                    var score = ((snapshot.children.allObjects[1] as AnyObject).children.allObjects[1] as AnyObject).childSnapshot(forPath: (Auth.auth().currentUser?.uid)!).childSnapshot(forPath: "score").value as? Int
                    
                    currentUser?.addScore(newScore: Challenge(score: score!))
                    if score != nil {
                        
                    
                    let s: Int = score!
                        var test = [Int]()
                        test.append(score!)
                       // currentUser?.scores?.append(5)
                        
                    }
                    
                    score = ((snapshot.children.allObjects[0] as AnyObject).children.allObjects[1] as AnyObject).childSnapshot(forPath: (Auth.auth().currentUser?.uid)!).childSnapshot(forPath: "score").value as? Int
                    if score != nil {
                        currentUser?.scores?.append(Challenge(score: score!))
                    }
                }
            })*/
            
        }
        else {
            
        }
        
    }
    
    func load(completion: @escaping (NUser) -> ()){
        let usersRef = Database.database().reference(withPath: "users")
        let uid = Auth.auth().currentUser?.uid
        
        usersRef.queryOrderedByKey().queryEqual(toValue: uid).observeSingleEvent(of: .value, with: { (snapshot) in
            //self.authUser = NUser(snapshot: snapshot)
            currentUser = NUser(snapshot: snapshot)
            completion(currentUser!)
        })
    }
    
    func loadVideo(){
        let video = "cxP4fwuGO-4"
        let url = URL(string: "https://www.youtube.com/embed/\(video)")
        print("URL: " + "\(url)")
        infoVideo.loadRequest(URLRequest(url: url!))
    }
    
    
    //Helper function that added attempts to all users who scored in the backend (Can be repurposed later for future backend testing and scripting
    func addAttemptsToScores(){
        let ref = Database.database().reference(withPath: "scores")
        
        ref.observe(.value, with: {(snapshot) in
            
            let stations = (snapshot.children.allObjects)
            
            for station in stations {
                
                let users = (station as? DataSnapshot)?.children.allObjects
                
                for user in users! {
                    
                    let points  = (user as? DataSnapshot)?.childSnapshot(forPath: "score").value as? Int
                    
                    ref.child(((station as? DataSnapshot)?.key)!).child(((user as? DataSnapshot)?.key)!).child("attempts").setValue(["2018-07-04T17:45:47+0000" : points])
                    
                    
                }
            }
            
        })
    }
    
    func addAttemptsToUsers(){
        let ref = Database.database().reference(withPath: "users")
        
        ref.observe(.value, with: {(snapshot) in
            
            let users = (snapshot.children.allObjects)
            
            for user in users {
                
                let key = (user as? DataSnapshot)?.key
                
                ref.child(key!).child("attempts").setValue(["0":"2018-07-04T17:45:47+0000"])
                
            }
            
        })
    }


}

