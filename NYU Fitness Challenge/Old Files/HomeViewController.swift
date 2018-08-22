//
//  HomeViewController.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 4/27/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var events = ["Freethrows", "3-Point", "Nutrition", "Push-ups", "Body Squats", "Juggling", "Frisbee", "Rope"]
    var thereIsCellTapped = false
    var selectedRowIndex = -1
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventDescription")as! DescriptionTableViewCell
        
        cell.descrip.text = events[indexPath.row]
        
        return cell
    }
    
    @IBOutlet weak var eventDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedRowIndex {
            return 200
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor(named: "Chartreuse")
        
        // avoid paint the cell is the index is outside the bounds
        if self.selectedRowIndex != -1 {
            //tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor(named: "white")
        }
        */
        if selectedRowIndex != indexPath.row {
            self.thereIsCellTapped = true
            self.selectedRowIndex = indexPath.row
        }
        else {
            // there is no cell selected anymore
            self.thereIsCellTapped = false
            self.selectedRowIndex = -1
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        //tableView.cellForRow(at: indexPath)?.accessoryView?.transform.rotated(by: 111)
        
        tableView.beginUpdates()
        tableView.endUpdates()
 
    }
    
 
    
    @IBAction func logOut(_ sender: Any) {
        do{
        try FirebaseAuth.Auth.auth().signOut()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")
        present(vc, animated: true, completion: nil)
        }
        catch{}
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
