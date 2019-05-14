//
//  SettingsTrackingSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/18/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class WelcomePageSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "WelcomePageSVC"
        }
    }
    
    @IBOutlet weak var continueButton: UIView!
    @IBOutlet weak var arrow: UIImageView!
    
    override func customSetup() {
        let origImage = UIImage(named: "Forward")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        arrow.image = tintedImage
        arrow.tintColor = UIColor(red: 2, green: 162, blue: 182)
        
        continueButton.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonPressed(tapGestureRecognizer: )))
        continueButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func buttonPressed(tapGestureRecognizer: UITapGestureRecognizer){
        let tutorial = SettingsTutorialsSVC()
        tutorial.parentVC = self.parentVC
        
        parentVC.pushSubView(newSubView: tutorial)
        let deadlineTime = DispatchTime.now() + 0.5 //wait for slide to complete
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            tutorial.play()
        }
    }
    
    
}
