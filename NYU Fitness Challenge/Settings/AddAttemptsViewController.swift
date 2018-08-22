//
//  AddAttemptsViewController.swift
//  NYU Fitness Challenge
//
//  Created by William  Uchegbu on 8/20/18.
//  Copyright © 2018 William Uchegbu. All rights reserved.
//

import UIKit

class AddAttemptsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var challenges: [String] = {
        var challenges = [String]()
        for i in Events.cases().reversed() {
            challenges.append(i.rawValue)
        }
        return challenges.reversed()
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return challenges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "challengeCell", for: indexPath) as! StationCollectionViewCell
        cell.stationName.text = challenges[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = UIColor.green
        (collectionView.cellForItem(at: indexPath) as! StationCollectionViewCell).stationName.textColor = UIColor.white
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        /*collectionView.cellForItem(at: indexPath)?.contentView.backgroundColor = UIColor.clear
        (collectionView.cellForItem(at: indexPath) as! StationCollectionViewCell).stationName.textColor = UIColor.black*/
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
