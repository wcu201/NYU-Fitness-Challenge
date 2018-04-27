//
//  ViewController.swift
//  NYU Fitness Challenge
//
//  Created by Brienne Renfurm on 4/16/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit

var data = ["John", "Sarah", "Michael", "Lucy"]
var score = [23, 98, 75, 37]

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")as! LeaderboardTableViewCell
        
        cell.leaderboardName.text = data[indexPath.row]
        cell.leaderboardScore.text = "\(score[indexPath.row])"
        cell.leaderboardRank.text = "\(indexPath.row + 1)"
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

