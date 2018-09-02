//
//  LeadersVC.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/21/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn
import HMSegmentedControl

class LeadersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var segmentController: UISegmentedControl!
    var newSegmentedController: HMSegmentedControl!
    var imagesAdjusted = false
    
    @IBOutlet weak var leaderPic: UIImageView!
    @IBOutlet weak var leaderName: UILabel!
    @IBOutlet weak var leaderScore: UILabel!
    
    @IBOutlet weak var leaderBoard: UITableView!
    var scoreTemplate = scoring()
    
    var challenges: [String] = {
        var challenges = [String]()
        for i in Events.cases().reversed() {
            challenges.append(i.rawValue)
        }
        return challenges.reversed()
    }()
    
    var selectedRowIndex = -1
    var thereIsCellTapped = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leadersCell") as! LeaderTableViewCell
        cell.name.text = challenges[indexPath.row]
        
       

        
        
        Database.database().reference(withPath: "scores").child(challenges[indexPath.row].lowercased()).observe(.value, with: {(snapshot) in
            var first: DataSnapshot?
            var second: DataSnapshot?
            var third: DataSnapshot?
            var fourth: DataSnapshot?
            var fifth: DataSnapshot?
            
            var rankIndex = 0
            var stationScores = snapshot.children.allObjects

            
            switch (/*self.segmentController.selectedSegmentIndex*/self.newSegmentedController.selectedSegmentIndex) {
            case 0:
                break
            case 1:
                stationScores = self.filterGender(snap: snapshot, gender: "male")
            case 2:
                stationScores = self.filterGender(snap: snapshot, gender: "female")
            default:
                break
            }
            
            //While loop assigns users to rankings in at the station
            while rankIndex <= 4{
                var maxIndex = 0
                for (index, score) in stationScores.enumerated() {
                    if (self.scoreTemplate.findBestScoreFromAttempt(snap: (score as! DataSnapshot).childSnapshot(forPath: "attempts")).value as! Int) > self.scoreTemplate.findBestScoreFromAttempt(snap: (stationScores[maxIndex] as! DataSnapshot).childSnapshot(forPath: "attempts")).value as! Int {
                        maxIndex = index
                    }
                }
                switch (rankIndex) {
                case 0:
                    first = stationScores[maxIndex] as? DataSnapshot
                case 1:
                    second = stationScores[maxIndex] as? DataSnapshot
                case 2:
                    third = stationScores[maxIndex] as? DataSnapshot
                case 3:
                    fourth = stationScores[maxIndex] as? DataSnapshot
                case 4:
                    fifth = stationScores[maxIndex] as? DataSnapshot
                default:
                    break
                }
                
                stationScores.remove(at: maxIndex)
                rankIndex = rankIndex + 1
            }
            
            
            cell.firstScore.text = "\(self.scoreTemplate.findBestScoreFromAttempt(snap: (first?.childSnapshot(forPath: "attempts"))!).value as! Int)"
            cell.secondScore.text = "\(self.scoreTemplate.findBestScoreFromAttempt(snap: (second?.childSnapshot(forPath: "attempts"))!).value as! Int)"
            cell.thirdScore.text = "\(self.scoreTemplate.findBestScoreFromAttempt(snap: (third?.childSnapshot(forPath: "attempts"))!).value as! Int)"
            cell.fourthScore.text = "\(self.scoreTemplate.findBestScoreFromAttempt(snap: (fourth?.childSnapshot(forPath: "attempts"))!).value as! Int)"
            cell.fifthScore.text = "\(self.scoreTemplate.findBestScoreFromAttempt(snap: (fifth?.childSnapshot(forPath: "attempts"))!).value as! Int)"
            
            Database.database().reference(withPath: "users").child((first?.key)!).child("first_name").observe(.value, with: {(snapshot) in
               cell.first.text =  snapshot.value as? String
                })
            Database.database().reference(withPath: "users").child((second?.key)!).child("first_name").observe(.value, with: {(snapshot) in
                cell.second.text =  snapshot.value as? String
            })
            Database.database().reference(withPath: "users").child((third?.key)!).child("first_name").observe(.value, with: {(snapshot) in
                cell.third.text =  snapshot.value as? String
            })
            Database.database().reference(withPath: "users").child((fourth?.key)!).child("first_name").observe(.value, with: {(snapshot) in
                cell.fourth.text =  snapshot.value as? String
            })
            Database.database().reference(withPath: "users").child((fifth?.key)!).child("first_name").observe(.value, with: {(snapshot) in
                cell.fifth.text =  snapshot.value as? String
            })
            
            
            
            
            
        })

        guard let icon = Event(eventName: challenges[indexPath.row].lowercased()).icon else {
            return cell
        }
        
        //(15.0, 18.0, 24.0, 12.5)
        
        /*if (indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 5) && imagesAdjusted ==  false{
            cell.challengeIcon.frame = CGRect(x: cell.challengeIcon.frame.minX, y: cell.challengeIcon.frame.maxY/2, width: cell.challengeIcon.frame.width, height: cell.challengeIcon.frame.height/2)
            
            if indexPath.row == 5 {
                imagesAdjusted = true
            }
        }*/
        
        if (indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 5) {
            print ("Altered cells: ", cell.name.text)
            cell.challengeIcon.frame = CGRect(x: 15.0, y: 18.0, width: 24.0, height: 12.5)
        }
        cell.challengeIcon.image = icon 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedRowIndex {
            return 275
            
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if selectedRowIndex != indexPath.row {
            self.thereIsCellTapped = true
            self.selectedRowIndex = indexPath.row
            let cell = tableView.cellForRow(at: indexPath) as! LeaderTableViewCell
            UIView.animate(withDuration:0.25, animations: {
                cell.arrowIcon.transform = cell.arrowIcon.transform.rotated(by: (-3.14))
            })
        }
        else {
            // there is no cell selected anymore
            tableView.deselectRow(at: indexPath, animated: true)
            let cell = tableView.cellForRow(at: indexPath) as! LeaderTableViewCell
            UIView.animate(withDuration:0.25, animations: {
                cell.arrowIcon.transform = cell.arrowIcon.transform.rotated(by: .pi)
            })
            self.thereIsCellTapped = false
            self.selectedRowIndex = -1
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }

    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LeaderTableViewCell
        
        //animates arrow  icon to rotate back into place when cell is deselceted
        UIView.animate(withDuration:0.25, animations: {
            cell.arrowIcon.transform = cell.arrowIcon.transform.rotated(by: .pi)
        })
    }

    
    func setupUI(){
        leaderPic.layer.cornerRadius = leaderPic.frame.width/2
        //self.tabBarController?.navigationController?.navigationBar.titleTextAttributes =
        self.tabBarController?.title = "Leaderboards"
        /*if currentUser == nil || currentUser?.fname == nil {
            loadUser()
        }*/
    }
    
    func findLeader(){
        let storageRef = Storage.storage().reference()
        
        Database.database().reference(withPath: "users").observe(.value, with: {(snapshot) in
            
           var users = snapshot.children.allObjects
            
            //segement controller value determines how you will filter data
            switch (/*self.segmentController.selectedSegmentIndex*/self.newSegmentedController.selectedSegmentIndex) {
            case 0:
                users = snapshot.children.allObjects
            case 1:
                users = self.filterGender(snap: snapshot, gender: "male")
            case 2:
                users = self.filterGender(snap: snapshot, gender: "female")
            default:
                users = snapshot.children.allObjects
            }
            
            var maxIndex: Int?
            if users.count != 0 {maxIndex = 0}
            
            for (index, leader) in users.enumerated() {
                let ref = (leader as! DataSnapshot).childSnapshot(forPath: "overall")
                
                if ref.exists() {
                if ((leader as! DataSnapshot).childSnapshot(forPath: "overall").value as? Int)! > ((users[maxIndex!] as! DataSnapshot).childSnapshot(forPath: "overall").value as? Int)! {
                    maxIndex = index
                }
            }
            }
            
            let maxUid = (users[maxIndex!] as! DataSnapshot).key
            storageRef.child(maxUid).getData(maxSize: 3*1000*1000, completion: {(data, error) in
                if (error != nil) {
                    print("Error downloading image: " + (error?.localizedDescription)!)
                    self.leaderPic.image = #imageLiteral(resourceName: "PROFILE-PHOTO-PLACEHOLDER")
                }
                else {
                    self.leaderPic.image = UIImage(data: data!)
                }
            })
            
            
            self.leaderName.text = ((users[maxIndex!] as! DataSnapshot).childSnapshot(forPath: "first_name").value as? String)! + " " + ((users[maxIndex!] as! DataSnapshot).childSnapshot(forPath: "last_name").value as? String)!
            
            self.leaderScore.text = "\(((users[maxIndex!] as! DataSnapshot).childSnapshot(forPath: "overall").value as? Int)!)"
            self.leaderScore.text?.append("pts")
        })
    }
    
    func filterGender(snap: DataSnapshot, gender: String) -> [DataSnapshot]{
        var filteredSnap = [DataSnapshot]()
        var genderVal: Int?{
        if gender == "female"{ return 1}
        else {return 0}
        }
        
        let snapArray = snap.children.allObjects
        for user in snapArray {
            if ((user as! DataSnapshot).childSnapshot(forPath: "gender").exists()) {
                
                if ((user as! DataSnapshot).childSnapshot(forPath: "gender").value as! Int) == genderVal {
                        filteredSnap.append(user as! DataSnapshot)
                }
            }
            
        }
        
        return filteredSnap
    }
    
    func reloadData() {
        findLeader()
        setupUI()
        leaderBoard.reloadData()
    }
    
    func loadUser(){
        
        let usersRef = Database.database().reference(withPath: "users")
        let scoreRef = Database.database().reference(withPath: "scores")
        if currentUser == nil {
            let uid = Auth.auth().currentUser?.uid
            
            
            usersRef.queryOrderedByKey().queryEqual(toValue: uid).observeSingleEvent(of: .value, with: { (snapshot) in
                currentUser = NUser(snapshot: snapshot)
            })
            
            
            scoreRef.observe(.value, with: {(snapshot) in
                for event in snapshot.children.allObjects {
                    
                    
                    let ref = (event as! DataSnapshot).childSnapshot(forPath: (Auth.auth().currentUser?.uid)!)
                    
                    if ref.exists(){
                        let val = (event as! DataSnapshot).childSnapshot(forPath: (Auth.auth().currentUser?.uid)!).childSnapshot(forPath: "score").value as! Int
                        let date = (event as! DataSnapshot).childSnapshot(forPath: (Auth.auth().currentUser?.uid)!).childSnapshot(forPath: "date").value as! String
                        let station = Event(eventName: ((event as? DataSnapshot)?.key)!)
                        
                        if !(date.isEmpty) {
                            currentUser?.addScore(newScore: Challenge(score: val, eventName: station, attemptDate: date))
                        }
                    }
                    
                    
                    
                    
                    
                }
                
            })
            

            
        }
        else {
            
        }
        
    }
    
    //opens settings
    @objc func showSettings(){
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "settings")
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        findLeader()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adds setting button to nav bar throughout the app
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_settings_white_24dp"), style: .plain, target: self, action: #selector(showSettings))
        //setupUI()
        addSegmentedController()
        addSgmentedControllerConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //adds new segmented controller to view
    func addSegmentedController(){
        newSegmentedController = HMSegmentedControl(frame: CGRect(x: 0, y: 85, width: self.view.frame.width, height: 50))
        newSegmentedController.selectionStyle = .fullWidthStripe
        newSegmentedController.selectionIndicatorColor = UIColor(red: 87/255, green: 6/255, blue: 140/255, alpha: 1.0)
        //let attrs = [
            //NSAttributedStringKey.foregroundColor: UIColor.red,
            //NSAttributedStringKey.font: UIFont(name: "TruenoLt", size: 17)!
        //]
        //newSegmentedController.titleTextAttributes = attrs
        newSegmentedController.sectionTitles = ["Overall", "Men", "Women"]
        newSegmentedController.addTarget(self, action: #selector(segmentChanges), for: .valueChanged)
        self.view.addSubview(newSegmentedController)
    }
    
    //adds contraints to the new segemented controller
    func addSgmentedControllerConstraints() {
        newSegmentedController.translatesAutoresizingMaskIntoConstraints = false
        
        let xAnchor = NSLayoutConstraint(item: newSegmentedController, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let yAnchor = NSLayoutConstraint(item: newSegmentedController, attribute: .top, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0)
        let widthAnchor = NSLayoutConstraint(item: newSegmentedController, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1, constant: 0)
        let heightAnchor = NSLayoutConstraint(item: newSegmentedController, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: newSegmentedController.frame.height)
 
        self.view.addConstraints([xAnchor, yAnchor, widthAnchor, heightAnchor])
    }
    
    //deprecated from old egmented view controller
    @IBAction func switchLeaderboards(_ sender: Any) {
        reloadData()
    }
    
    //reloads data when new segemented view controller is changes value
    @objc func segmentChanges() {
        reloadData()
    }
    
    

}
