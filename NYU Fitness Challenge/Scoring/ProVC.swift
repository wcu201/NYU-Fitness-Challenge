//
//  ProVC.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/20/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase
import Photos
import UserNotifications
import NotificationCenter
import SVProgressHUD
import GoogleSignIn

class ProVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate {
    
    //Outlets
    @IBOutlet weak var userPerformance: UITableView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    var selectedAttempt: Attempt?
    var bestOverall: Int {
        let overall = currentUser?.bestScores.reduce(0, +)
        return overall!
    }
    
    
    let pickerView = UIImagePickerController()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            if currentUser?.attempts.count == 0 {
                return 1
            }
            return (currentUser?.attempts.count)!
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "")

        
        switch (indexPath.section) {
        case 0:
            if currentUser?.attempts.count == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "noAttempts")
                cell?.frame.size.height = 100
            }
            else {
                cell = tableView.dequeueReusableCell(withIdentifier: "attempt") as? profileAttemptCell
                let attemptDate = currentUser?.attempts[indexPath.row].date
                (cell as? profileAttemptCell)?.date.text = DateFormatter.localizedString(from: attemptDate!, dateStyle: .medium, timeStyle: .none)
                (cell as? profileAttemptCell)?.overallPoints.text = "\(currentUser?.attempts[indexPath.row].scores.reduce(0, +) ?? 0)"
            }
        case 1:
            cell = (tableView.dequeueReusableCell(withIdentifier: "overallScore") as! OverallScoreTableViewCell)
            (cell as! OverallScoreTableViewCell).overrallScore.text = "\(bestOverall)" + " pts"
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "")
        }
        
        return cell!
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0 && currentUser?.attempts.count != 0) {
            selectedAttempt = currentUser?.attempts[indexPath.row]
            performSegue(withIdentifier: "showAttemptResults", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.light)
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show()
        
        /*
        loadUser() {(theUser) in
            self.downloadProPic() {(thePic) in
                self.setupUI()
                SVProgressHUD.dismiss()
                
            }
        }*/
        
        loadUser() {(theUser) in
            self.setupUI()
            SVProgressHUD.dismiss()
        }
        
        pickerView.delegate = self
        //checkPermission()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.title = "Profile"
        picture.layer.cornerRadius = picture.frame.width/2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section) {
        case 0:
            if currentUser?.attempts.count == 0 {
                return 100
            }
            return 44
        default:
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    
    func setupUI() {
        
        //Name UI
        name.text = (currentUser?.fname)! + " " + (currentUser?.lname)!
        
        // Pic UI
        do {
            let imageData = try Data(contentsOf: (URL(string: (currentUser?.imageURL)!))!)
            let googlePic = UIImage(data: imageData)
            currentUser?.ProfilePicture = googlePic
        }catch{print("Error, unable to download image")}
        picture.layer.cornerRadius = picture.frame.width/2
        picture.image = currentUser?.ProfilePicture
        //picture.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.proPicturePressed))
        picture.addGestureRecognizer(tapGestureRecognizer)
        
        //Table UI
        let header = UIView()
        //header.backgroundColor = UIColor(red:200/255.0, green:199/255.0, blue:204/255.0, alpha:0.2)
        header.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 40)
        let title = UILabel(frame: CGRect(x: 15, y: 9, width: 100, height: 20))
        title.font = UIFont(name: "Montserrat-Medium", size: 17.0)
        title.text = "Attempts"
        header.addSubview(title)
        userPerformance.headerView(forSection: 0)?.textLabel?.text = "Attempt"
        userPerformance.headerView(forSection: 1)?.textLabel?.text = "Points"
        userPerformance.tableHeaderView = header
        
        //Scores & Attempts
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
    
    func loadUser(completion: @escaping (NUser) -> ()){
        let usersRef = Database.database().reference(withPath: "users")
        let uid = Auth.auth().currentUser?.uid
        
        usersRef.queryOrderedByKey().queryEqual(toValue: uid).observeSingleEvent(of: .value, with: { (snapshot) in
            //self.authUser = NUser(snapshot: snapshot)
            currentUser = NUser(snapshot: snapshot)
            completion(currentUser!)
        })
    }
    
    func downloadProPic(completion: @escaping (UIImage) -> ()){
        let storageRef = Storage.storage().reference().child((Auth.auth().currentUser?.uid)!)
        storageRef.getData(maxSize: (3*1000*1000), completion: {(data, error) in
            if (error != nil) {
                print("Error downloading image: " + (error?.localizedDescription)!)
                currentUser?.ProfilePicture = #imageLiteral(resourceName: "PROFILE-PHOTO-PLACEHOLDER")
                completion(#imageLiteral(resourceName: "PROFILE-PHOTO-PLACEHOLDER"))
            }
            else {
                currentUser?.ProfilePicture = UIImage(data: data!)
                completion((currentUser?.ProfilePicture)!)
            }
        })
    }
    
    func downloadGooglePic(){
        //GIDProfileData.imageURL(<#T##GIDProfileData#>)
    }
    
    @objc func proPicturePressed(){
        print("Picture Pressed")
        let alert = UIAlertController(title: "Update Image", message: "Do you want to edit your profile picture?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let approve = UIAlertAction(title: "Yes", style: .default, handler: {action in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            
            self.present(picker, animated: true, completion: nil)
        })
        
        alert.addAction(cancel)
        alert.addAction(approve)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = (segue.destination as? AttemptVC)
        dest?.userAttempt  = self.selectedAttempt
    }
    
    
    
}

extension ProVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Did finish picking. Info = " + "\(info)")
        var selectedImage: UIImage?
        if let croppedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImage = croppedImage
        }
        
        self.picture.image = selectedImage
        let storageRef = Storage.storage().reference().child((Auth.auth().currentUser?.uid)!)
        if let uploadImage = UIImagePNGRepresentation(selectedImage!) {
            storageRef.putData(uploadImage, metadata: nil, completion: {(metadata, error) in
                if error != nil {
                    print("Error uploading image: " + (error?.localizedDescription)!)
                    return
                }
            })
        }
        self.dismiss(animated: true, completion: nil)
        
        //present(alert, animated: true, completion: nil)
        
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}



