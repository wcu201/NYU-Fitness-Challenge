//
//  InfoStationsVC.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/25/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import AVKit
import HMSegmentedControl

class InfoStationsVC: UIViewController {
    var newSegmentedController: HMSegmentedControl!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var stationsSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    let videoController = AVPlayerViewController()
    @IBOutlet weak var videoView: UIView!
    
    var selectedEvent = Event()
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.title = "Challenge"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let audioSession = AVAudioSession.sharedInstance()
        
        do{
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        }
        catch{}
        
        addVideo(videoURL:"/Users/williamuchegbu/Documents/GitHub/NYU-Fitness-Challenge/NYU Fitness Challenge/Videos/Brooklyn Athletic Facility Mannequin Challenge.mp4")
        addSegmentedController()
        addSgmentedControllerConstraints()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeSegValue(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            print ("Segment1")
            //self.view = Info
        }
        else {
            print ("Segment2")
            print("Testing")
            topView.isHidden = true
            stationsSegmentedControl.selectedSegmentIndex = 1
        }
    }
    
    
    @IBAction func stationsChangeSegValue(_ sender: Any) {
        if stationsSegmentedControl.selectedSegmentIndex == 0 {
            print ("Segment 1")
            topView.isHidden = false
            segmentedControl.selectedSegmentIndex = 0
        }
        else {
            print ("Segment 2")
            //self.view = Stations
        }
    }
    
    
    
    @IBAction func burpees(_ sender: Any) {
        selectedEvent = Event(eventName: "burpees")
        openDetails()
    }
    @IBAction func bike(_ sender: Any) {
        selectedEvent = Event(eventName: "bike")
        openDetails()
    }
    @IBAction func fitnessTest(_ sender: Any) {
        selectedEvent = Event(eventName: "fitness test")
        openDetails()
    }
    @IBAction func freethrow(_ sender: Any) {
        selectedEvent = Event(eventName: "freethrow")
        openDetails()
    }
    @IBAction func plank(_ sender: Any) {
        selectedEvent = Event(eventName: "plank")
        openDetails()
    }
    @IBAction func pushups(_ sender: Any) {
        selectedEvent = Event(eventName: "pushups")
        openDetails()
    }
    @IBAction func ropepull(_ sender: Any) {
        selectedEvent = Event(eventName: "rope pull")
        openDetails()
    }
    @IBAction func rowing(_ sender: Any) {
        selectedEvent = Event(eventName: "rowing")
        openDetails()
    }
    @IBAction func shuttlerun(_ sender: Any) {
        selectedEvent = Event(eventName: "shuttle run")
        openDetails()
    }
    @IBAction func squats(_ sender: Any) {
        selectedEvent = Event(eventName: "squats")
        openDetails()
    }
    
    
    func addVideo(videoURL: String){
        let path = Bundle.main.path(forResource: "challengeVideo", ofType: "mp4")
        let url = URL(fileURLWithPath: path!)
        
        let video = AVPlayer(url: url)
        videoController.player = video
        videoController.view.frame = CGRect(x: 0, y: 0, width: videoView.frame.width, height: videoView.frame.height)
        //videoController.entersFullScreenWhenPlaybackBegins = true
        //videoController.player?.play()
        videoView.addSubview(videoController.view)
    }
    
    
    func openDetails(){
        performSegue(withIdentifier: "toDescription", sender: self)
    }
    
    //adds new segmented controller to view
    func addSegmentedController(){
        newSegmentedController = HMSegmentedControl(frame: CGRect(x: 0, y: 85, width: self.view.frame.width, height: 50))
        newSegmentedController.selectionStyle = .fullWidthStripe
        newSegmentedController.selectionIndicatorColor = UIColor(red: 87/255, green: 6/255, blue: 140/255, alpha: 1.0)
        
        newSegmentedController.borderType = .bottom
        newSegmentedController.borderWidth = 5
        newSegmentedController.borderColor = UIColor(red: 87/255, green: 6/255, blue: 140/255, alpha: 1.0)
        
        //let attrs = [
        //NSAttributedStringKey.foregroundColor: UIColor.red,
        //NSAttributedStringKey.font: UIFont(name: "TruenoLt", size: 17)!
        //]
        //newSegmentedController.titleTextAttributes = attrs
        newSegmentedController.sectionTitles = ["About", "Stations"]
        newSegmentedController.addTarget(self, action: #selector(segmentChanges), for: .valueChanged)
        self.bottomView.addSubview(newSegmentedController)
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
    
    @objc func segmentChanges() {
        if newSegmentedController.selectedSegmentIndex == 1 {
            topView.isHidden = true
        }
        else {
            topView.isHidden = false
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! StationDetailsVC
        vc.event = self.selectedEvent
        vc.navigationItem.title = selectedEvent.name
    }
    

}
