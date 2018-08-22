//
//  AttemptVC.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 7/9/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit

class AttemptVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var userAttempt: Attempt?
    @IBOutlet weak var attemptPerformances: UITableView!
    
    
    var challenges: [String] = {
        var challenges = [String]()
        for i in Events.cases().reversed() {
            challenges.append(i.rawValue)
        }
        return challenges.reversed()
    }()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return challenges.count
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
        switch(indexPath.section) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "stationAttempt") as? attemptCell
            cell?.name.text = challenges[indexPath.row]
            let score = userAttempt?.scores[indexPath.row]
            cell?.points.text = "\(score ?? 0)"
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "overallAttempt") as? overallAttemptCell
            cell?.overallScore.text = "\((userAttempt?.scores.reduce(0, +)) ?? 0)"
            return cell!
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "overallAttempt") as? overallAttemptCell
            return cell!
        }
        
        /*
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "stationAttempt") as? attemptCell
            cell?.name.text = challenges[indexPath.row]
            return cell!
        }
            /*
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "overallAttemptScore") as? overallAttemptCell
            return cell!
        }*/
    
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "overrallAttempt")
            return cell!
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "overallAttemptScore") as? overallAttemptCell
        return cell!
        */
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        attemptPerformances.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        //self.tabBarController?.title = "Profile"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let attemptDate = userAttempt?.date
        self.title = DateFormatter.localizedString(from: attemptDate!, dateStyle: .short, timeStyle: .none)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 

}
