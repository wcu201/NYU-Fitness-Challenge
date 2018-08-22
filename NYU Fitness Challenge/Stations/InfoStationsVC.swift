//
//  InfoStationsVC.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 6/25/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import AVKit

class InfoStationsVC: UIViewController {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! StationDetailsVC
        vc.event = self.selectedEvent
        vc.navigationItem.title = selectedEvent.name
    }
    

}
