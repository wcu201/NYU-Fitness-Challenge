//
//  ProfileViewController.swift
//  NYU Fitness Challenge
//
//  Created by Brienne Renfurm on 4/17/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var overallScore: UILabel!
    
    @IBOutlet weak var overallRank: UILabel!
    
    @IBOutlet weak var proPic: UIImageView!
    
    @IBOutlet weak var name: UITextField!
    
    var ref:DatabaseReference?
    var databaseHandle:DatabaseHandle?
    
    var events = ["Freethrows", "3-Point", "Nutrition", "Push-ups", "Body Squats", "Juggling", "Frisbee", "Rope"]
    var scores = [34, 75, 20, 50, 34, 85, 34, 62]
    var ranks = [12, 2, 4, 11, 7, 37, 48, 21]
    
    //self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell")as! eventCell
        
        cell.eventName.text = events[indexPath.row]
        cell.eventScore.text = "\(scores[indexPath.row])"
        cell.eventRank.text = "\(ranks[indexPath.row])"
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = Database.database().reference()
        //print (UserMetadata.)
    
        databaseHandle = ref?.child("users").child("user_1").observe(.value, with: { (snapshot) in
            let fname = snapshot.childSnapshot(forPath: "firstName").value as? String
            let lname = snapshot.childSnapshot(forPath: "lastName").value as? String
            
            self.name.text = fname! + " " + lname!
            
            let fthrows = snapshot.childSnapshot(forPath: "freethrows").value as? Int
            let threepoint = snapshot.childSnapshot(forPath: "threepoint").value as? Int
            let nutrition = snapshot.childSnapshot(forPath: "nutrition").value as? Int
            let pushups = snapshot.childSnapshot(forPath: "pushups").value as? Int
            let bodysquats = snapshot.childSnapshot(forPath: "bodysquats").value as? Int
            let juggling = snapshot.childSnapshot(forPath: "juggling").value as? Int
            let frisbee = snapshot.childSnapshot(forPath: "frisbee").value as? Int
            let rope = snapshot.childSnapshot(forPath: "rope").value as? Int
            
            let pic = snapshot.childSnapshot(forPath: "profilePic").value as? String
            
            
            self.scores[0] = fthrows!
            self.scores[1] = threepoint!
            self.scores[2] = nutrition!
            self.scores[3] = pushups!
            self.scores[4] = bodysquats!
            self.scores[5] = juggling!
            self.scores[6] = frisbee!
            self.scores[7] = rope!
            self.tableView.reloadData()
            
            self.overallScore.text = "\(self.findOverall())"
            self.setImage(the_url: pic!)
            
            
        })
        
        //let val = value(forKey: (ref?.child("users").child("user_1").child("firstName").key)!)
        
        
        //name.text = test as! String
        
        overallRank.text = "\(22)"
        roundImage()
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func findOverall() -> Int {
        var overall = 0
        
        for x in scores
        {
            overall = overall + x
        }
        
        return overall
    }
    
    func setBackItem() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func roundImage() {
        proPic.layer.cornerRadius = proPic.frame.size.width / 2
    }
    
    func setImage(the_url: String) {
        
        var imgData: Data? = nil
        
        let url = URL(string: the_url)
        do {
         imgData = try Data(contentsOf: url!)
        }
        catch{}
        
        self.proPic.image = UIImage(data: imgData!)
        //UIImage *image = [UIImage imageWithData: data];
    }
    
    //self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
