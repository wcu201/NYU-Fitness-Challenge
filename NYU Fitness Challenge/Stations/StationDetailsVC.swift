//
//  StationDetailsVC.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/23/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import AVKit

class StationDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var event = Event()
    @IBOutlet weak var detailsTable: UITableView!
    let videoController = AVPlayerViewController()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    //Number of rows for each of the 4 sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return event.muscleGroups.count
        case 3:
            return 1
        default:
            break
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "instructions") as? InstructionsTableViewCell
            cell?.addVideo(videoURL: event.instructions)

            return cell!
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "muscleGroupsHeader")
            return cell!
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "muscleGroups") as! muscleGroupsTableViewCell
            cell.muscleGroups.text = cell.muscleGroups.text! + event.muscleGroups[indexPath.row]
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "train")
            return cell!
        default:
            print("Error: Cell out of index")
            let cell = tableView.dequeueReusableCell(withIdentifier: "")
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 200
        }
        
        return 60
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsTable.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        detailsTable.separatorStyle = .none

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func exit(){
        self.dismiss(animated: true, completion: nil)
    }
   

}
