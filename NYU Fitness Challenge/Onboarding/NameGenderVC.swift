//
//  NameGenderVC.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 7/5/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit

class NameGenderVC: UIViewController {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var nextBTN: UIButton!
  
    var email: String?
    var password: String?
    
    override var canBecomeFirstResponder: Bool {return true}
    override var inputAccessoryView: UIView? {return firstName.inputAccessoryView}
    
    override func viewWillAppear(_ animated: Bool) {
        firstName.becomeFirstResponder()
        
        nextBTN.frame = CGRect(x: self.view.frame.width/2 - nextBTN.frame.width/2, y: 0, width: nextBTN.frame.width, height: nextBTN.frame.height)
        nextBTN.layer.cornerRadius = 20
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        myView.backgroundColor = .clear
        
        myView.addSubview(nextBTN)
        firstName.inputAccessoryView = myView
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
        if ((firstName.text?.isEmpty)! || (lastName.text?.isEmpty)!) {
            showAlert(title: "Error", message: "Name cannot be left blank")
            return
        }
        performSegue(withIdentifier: "toProPic", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ProfilePicVC
        
        destination.email = self.email
        destination.password = self.password
        destination.firstName = self.firstName.text
        destination.lastName = self.lastName.text
        destination.gender = Int(self.gender.text!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
