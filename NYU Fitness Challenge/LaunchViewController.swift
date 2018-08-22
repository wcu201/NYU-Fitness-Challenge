//
//  LaunchViewController.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 5/25/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import RevealingSplashView
import GoogleSignIn

class LaunchViewController: UIViewController {
    var window: UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealingSplashiew = RevealingSplashView(iconImage: UIImage(named: "ChallengeLogo")!, iconInitialSize: CGSize(width: 320, height: 125), backgroundColor: .clear)
       
        revealingSplashiew.animationType = .twitter
        revealingSplashiew.duration = 3.0
        //revealingSplashiew.finishHeartBeatAnimation()
        
        self.view.addSubview(revealingSplashiew)
        
        
        
        revealingSplashiew.startAnimation(){
            self.initalizeApp()
            /*
            if let user = Auth.auth().currentUser {
                self.performSegue(withIdentifier: "goToHome", sender: self)
                print("Email: " + user.email!)
                print("Name: " + user.uid)
            }
                
            else {
                self.performSegue(withIdentifier: "goToSignIn", sender: self)
            }
             */
        
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func initalizeApp(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            print("There is a new auth state")
            if user != nil {
                print("User State")
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
                    
                    
                    //let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeTab")
                    
                    self.performSegue(withIdentifier: "launchApp", sender: self)
                    
                    /*
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window?.rootViewController = vc
                    self.window?.makeKeyAndVisible()
                    */
                    
                    print ("User logged in: " + (Auth.auth().currentUser?.email)!)
                }
                //print ("User: " + (currentUser?.fname)! + " " + (currentUser?.lname)!)
            }
            else {
            print("No user state")
                let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login")
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = vc
                self.window?.makeKeyAndVisible()
                print ("No user logged in")
            }
        }
    }

}
