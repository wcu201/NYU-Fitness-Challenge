//
//  SettingsViewController.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 7/7/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class SettingsViewController: UIViewController {
    @IBOutlet weak var signOutBTN: UIButton!
    
    @IBOutlet weak var addUserAttemptBTN: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        signOutBTN.layer.cornerRadius = 20
        addUserAttemptBTN.layer.cornerRadius = 20
        
        if currentUser?.userType != "administrator" {
            addUserAttemptBTN.isHidden = true
            //addUserAttemptBTN.removeFromSuperview()
        }
        // Do a
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        let alertController = UIAlertController(title: title, message: "Are you sure you want to sign out?", preferredStyle: .alert)
        
        let exitAction = UIAlertAction(title: "Yes", style: .default, handler: {action in
            do{
                try Auth.auth().signOut()
            }
            catch{}
            GIDSignIn.sharedInstance().signOut()
        })
        let defaultAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(exitAction)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func addUserAttempt(_ sender: Any) {
        self.performSegue(withIdentifier: "showAddAttempts", sender: self)
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
