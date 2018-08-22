//
//  StationsVC.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/23/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit

class StationsVC: UIViewController {
    var event = Event()
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        segmentedControl.selectedSegmentIndex = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    
    @IBAction func burpees(_ sender: Any) {
        event = Event(eventName: "burpees")
        openDetails()
    }
    @IBAction func bike(_ sender: Any) {
        event = Event(eventName: "bike")
        openDetails()
    }
    @IBAction func fitnessTest(_ sender: Any) {
        event = Event(eventName: "fitness test")
        openDetails()
    }
    @IBAction func freethrow(_ sender: Any) {
        event = Event(eventName: "freethrow")
        openDetails()
    }
    @IBAction func plank(_ sender: Any) {
        event = Event(eventName: "plank")
        openDetails()
    }
    @IBAction func pushups(_ sender: Any) {
        event = Event(eventName: "pushups")
        openDetails()
    }
    @IBAction func ropepull(_ sender: Any) {
        event = Event(eventName: "rope pull")
        openDetails()
    }
    @IBAction func rowing(_ sender: Any) {
        event = Event(eventName: "rowing")
        openDetails()
    }
    @IBAction func shuttlerun(_ sender: Any) {
        event = Event(eventName: "shuttle run")
        openDetails()
    }
    @IBAction func squats(_ sender: Any) {
        event = Event(eventName: "squats")
        openDetails()
    }
    
    
    @IBAction func segmentedControl(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            self.dismiss(animated: true, completion: {() in
                //(self.presentingViewController as! InfoStationsVC).segmentedControl.selectedSegmentIndex = 1
                
            })
        }
    }
    
    func openDetails(){
        performSegue(withIdentifier: "toDescription", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! StationDetailsVC
        vc.event = self.event
        vc.navigationItem.title = event.name
    }
    
}
