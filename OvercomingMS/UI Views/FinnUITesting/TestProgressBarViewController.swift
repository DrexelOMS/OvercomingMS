//
//  TestProgressBarViewController.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/26/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class TestProgressBarViewController: UIViewController, TrackingProgressBarDelegate, TrackingFoodBarDelegate {
    
    func didPressCheckButton(_ sender: TrackingFoodBar) {
        //sender.rightLabel.text = "TestRight"
    }
    
    func didPressLeftContainer(_ sender: TrackingFoodBar) {
        //sender.leftLabel.text = "TestLeft"
    }
    
    func didPressLeftContainer(_ sender: TrackingProgressBar) {
        sender.incremementProgressValue(value: 10)
    }
    
    
    func didPressCheckButton(_ sender: TrackingProgressBar) {

        if(sender.getProgressValue() == 0){
            sender.setProgressValue(value: 100)
        } else{
            sender.setProgressValue(value: 0)
        }
    }
    
    
    @IBOutlet weak var trackingProgressBar: TrackingProgressBar!
    
    @IBOutlet weak var trackingFoodBar: TrackingFoodBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        trackingProgressBar.delegate = self;
        trackingFoodBar.delegate = self;
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
