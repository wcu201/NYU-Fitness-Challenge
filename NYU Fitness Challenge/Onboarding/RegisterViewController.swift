//
//  RegisterViewController.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 5/14/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var registerBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.layer.cornerRadius = 10
        registerBTN.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
