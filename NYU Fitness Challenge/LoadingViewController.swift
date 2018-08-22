//
//  LoadingViewController.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 7/12/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit
import SVProgressHUD


class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.setBackgroundColor(.clear)
        SVProgressHUD.show()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
