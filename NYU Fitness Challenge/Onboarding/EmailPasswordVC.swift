//
//  EmailPasswordVC.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 7/5/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import FirebaseDatabase

class EmailPasswordVC: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var nextBTN: UIButton!
    
    override var canBecomeFirstResponder: Bool {return true}
    override var inputAccessoryView: UIView? {return email.inputAccessoryView}
    
    override func viewWillAppear(_ animated: Bool) {
        email.becomeFirstResponder()
        
        nextBTN.frame = CGRect(x: self.view.frame.width/2 - nextBTN.frame.width/2, y: 0, width: nextBTN.frame.width, height: nextBTN.frame.height)
        nextBTN.layer.cornerRadius = 20
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        myView.backgroundColor = .clear
        
        myView.addSubview(nextBTN)
        email.inputAccessoryView = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func next(_ sender: Any) {
        if (password.text != confirmPassword.text) {
            showAlert(title: "Error", message: "Passwords do not match")
            return
        }
        
        if ((password.text?.isEmpty)! || (password.text?.count)! < 7) {
            showAlert(title: "Invalid Entry", message: "Password must be at least 7 characters long")
            return
        }
        //Database.database().reference(withPath: "users").child("testing").child("value")
        //print("sent to database")
        performSegue(withIdentifier: "toNameGender", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destiniation = segue.destination as? NameGenderVC
        
        destiniation?.email = self.email.text
        destiniation?.password = self.password.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

/*
var nuts = 2

for nut in nuts {
    showAlert(title: "HA!", message:"GOTEEEM")
}
*/
