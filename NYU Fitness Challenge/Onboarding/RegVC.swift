//
//  RegVC.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/23/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegVC: UIViewController {
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var signUpBTN: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func register(_ sender: Any) {
        guard let userEmail = email.text else {return}
        guard let userPassword = password.text else {return}
        guard let userConfirmPassword = confirmPassword.text else {return}
        guard let userFirstname = firstname.text else {return}
        guard let userLastname = lastname.text else {return}
        
        if (userFirstname.isEmpty || userLastname.isEmpty) {
            showAlert(title: "Invalid Registration", message: "First name and last name must be filled out")
            return
        }
        
        if (userConfirmPassword != userPassword) {
            showAlert(title: "Error", message: "Passwords do not match")
            return
        }
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword, completion: {user, error in
            if error == nil && user != nil {
                print ("User Created")
                Database.database().reference(withPath: "users").child((Auth.auth().currentUser?.uid)!).child("first_name").setValue(userFirstname)
                Database.database().reference(withPath: "users").child((Auth.auth().currentUser?.uid)!).child("last_name").setValue(userLastname)
                Database.database().reference(withPath: "users").child((Auth.auth().currentUser?.uid)!).child("overall").setValue(0)
            }
            else {
                self.showAlert(title: "Error creating user", message: (error?.localizedDescription)!)
                print ("Error creating user: \(error!.localizedDescription)")
            }
        })
    }
    
    
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func setupUI() {
        signUpBTN.layer.cornerRadius = 20
    }
    
    
}
