//
//  LoginVC.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/13/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

class LoginVC: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("Signing")
        
        if error != nil {
            print("Error signing user in: ", error.localizedDescription)
        }
        
        else {
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    print("Error signing and retrieving: ", error.localizedDescription)
                    return
                }
                
                print("Successful Login: ", (Auth.auth().currentUser?.uid)!)
                
                if (authResult?.additionalUserInfo?.isNewUser)! {
                    //signIn.scopes = ["me", "profile"]
                    
                    let gplusapi = "https://www.googleapis.com/oauth2/v3/userinfo?access_token=\(user.authentication.accessToken!)"
                    let url = NSURL(string: gplusapi)!
                    
                    
                    
                    let request = NSMutableURLRequest(url: url as URL)
                    request.httpMethod = "GET"
                    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                    
                    print("Info Request: ", request)
                    
                    
                    let session = URLSession.shared
                    
                    
                    session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if error != nil {
                            print("Error fetching gender: ", error?.localizedDescription)
                        }
                        
                        do {
                            //let userData = try JSONSerialization.jsonObject(with: data!, options:[]) as? [String:AnyObject]
                            //print("Domain: ", userData!["hd"] as! String)
                            
                            /*if userData!["hd"] as? String != "nyu.edu" || !(userData!["hd"]?.exists())!{
                                GIDSignIn.sharedInstance().signOut()
                                do{try Auth.auth().signOut()} catch{}
                                let alertController = UIAlertController(title: "Error", message: "Only login using an NYU email", preferredStyle: .alert)
                                
                                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                                alertController.addAction(defaultAction)
                                
                                self.present(alertController, animated: true, completion: nil)
                            }*/
                            
                        } catch {
                            NSLog("Account Information could not be loaded")
                        }
                        
                    }).resume()
                    
                    Database.database().reference(withPath: "users").child((Auth.auth().currentUser?.uid)!).child("first_name").setValue(user.profile.givenName!)
                    Database.database().reference(withPath: "users").child((Auth.auth().currentUser?.uid)!).child("last_name").setValue(user.profile.familyName!)
                    Database.database().reference(withPath: "users").child((Auth.auth().currentUser?.uid)!).child("imageURL").setValue(user.profile.imageURL(withDimension: 300).absoluteString)
                    Database.database().reference(withPath: "users").child((Auth.auth().currentUser?.uid)!).child("overall").setValue(0)
                    UserDefaults.standard.set(user.profile.imageURL(withDimension: 300).absoluteString, forKey: "imageURL")
                    print(user.profile.email!)
                    print(user.profile.givenName)
                    print(user.profile.familyName)
                    print(user.profile.hasImage)
                    self.performSegue(withIdentifier: "launchApp", sender: self)
                // User is signed in
                // ...
                }
                else {
                    UserDefaults.standard.set(user.profile.imageURL(withDimension: 300).absoluteString, forKey: "imageURL")
                    //currentImage = user.profile.imageURL(withDimension: 300).absoluteString
                    self.performSegue(withIdentifier: "launchApp", sender: self)
                }
            }
        }
 
    }
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var loginBTN: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        //GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().clientID = "706151436086-1pgoebf6q5vqa2bbbgiuihh849cp8def.apps.googleusercontent.com"
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        if (self.email.text?.isEmpty)! || (self.password.text?.isEmpty)! {
            
            //Alert if no password or username was entered
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            FirebaseAuth.Auth.auth().signIn(withEmail: email.text!, password: password.text!, completion:
                { (user, error) in
                    if error == nil {

                        print("You have successfully logged in")

                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeTab")
                        self.present(vc!, animated: true, completion: nil)
                        
                    }
                    else {
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
            })
            
        }
        
        
    }
    
    @IBAction func googleSignIn(_ sender: Any) {
        print("Google Sign In")
        GIDSignIn.sharedInstance().hostedDomain = "nyu.edu"
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    func setupUI() {
        loginBTN.layer.cornerRadius = 20
        //RGB: R87, G6, B140
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
