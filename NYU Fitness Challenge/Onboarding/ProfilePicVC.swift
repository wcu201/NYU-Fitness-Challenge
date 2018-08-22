//
//  ProfilePicVC.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 7/5/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import Photos
import FirebaseAuth
import FirebaseDatabase
import Firebase

class ProfilePicVC: UIViewController {
    @IBOutlet weak var proPic: UIImageView!
    @IBOutlet weak var signUpBTN: UIButton!
    
    var email: String?
    var password: String?
    var firstName: String?
    var lastName: String?
    var gender: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        if (self.proPic.image?.isEqual(#imageLiteral(resourceName: "PROFILE-PHOTO-PLACEHOLDER")))! {
            print("No Profile")
        }
        else {
            print("Profile Pic added")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkPermission()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(_ sender: Any) {
        guard let userEmail = email else {return}
        guard let userPassword = password else {return}
        guard let userFirstname = firstName else {return}
        guard let userLastname = lastName else {return}
        //guard let userGender = Gender.init(rawValue: <#T##Int#>)
        
        if (userFirstname.isEmpty || userLastname.isEmpty) {
            showAlert(title: "Invalid Registration", message: "First name and last name must be filled out")
            return
        }
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword, completion: {user, error in
            if error == nil && user != nil {
                print ("User Created")
                let userRef = Database.database().reference(withPath: "users").child((Auth.auth().currentUser?.uid)!)
                userRef.child("first_name").setValue(userFirstname)
                userRef.child("last_name").setValue(userLastname)
                userRef.child("overall").setValue(0)
                userRef.child("gender").setValue(0)
                if !(self.proPic.image?.isEqual(#imageLiteral(resourceName: "PROFILE-PHOTO-PLACEHOLDER")))! {
                    let storageRef = Storage.storage().reference().child((Auth.auth().currentUser?.uid)!)
                    if let uploadImage = UIImagePNGRepresentation(self.proPic.image!) {
                        storageRef.putData(uploadImage, metadata: nil, completion: {(metadata, error) in
                            if error != nil {
                                print("Error uploading image: " + (error?.localizedDescription)!)
                                return
                            }
                        })
                    }
                 userRef.child("imageURL").setValue("")
                 
                }
                
                //Send email verificaiton to the user
                Auth.auth().currentUser?.sendEmailVerification(completion: {(error) in
                    if error != nil {
                        print("Error sending verification email to " + (Auth.auth().currentUser?.email)! + ": " + (error?.localizedDescription)!)
                    }
                    
                    else {
                        print("Verification email successfully sent to " + (Auth.auth().currentUser?.email)!)
                    }
                })
            }
            else {
                self.showAlert(title: "Error creating user", message: (error?.localizedDescription)!)
                print ("Error creating user: \(error!.localizedDescription)")
            }
        })
    }
    
    @objc func profilePicPressed(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker, animated: true, completion: nil)
    }
    
    func setupUI(){
        proPic.layer.cornerRadius = proPic.frame.width/2
        //proPic.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.profilePicPressed))
        proPic.addGestureRecognizer(tapGestureRecognizer)
        
        signUpBTN.layer.cornerRadius = 20
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }

}



extension ProfilePicVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Did finish picking. Info = " + "\(info)")
        var selectedImage: UIImage?
        if let croppedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImage = croppedImage
        }
        
        self.proPic.image = selectedImage
        
        self.dismiss(animated: true, completion: nil)
        
        //present(alert, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

/*
 let storageRef = Storage.storage().reference().child((Auth.auth().currentUser?.uid)!)
 if let uploadImage = UIImagePNGRepresentation(selectedImage!) {
 storageRef.putData(uploadImage, metadata: nil, completion: {(metadata, error) in
 if error != nil {
 print("Error uploading image: " + (error?.localizedDescription)!)
 return
 }
 })
 }
 */
