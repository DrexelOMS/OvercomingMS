//
//  MeditationLevelButtonSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MeditationLevelButtonSVC: CustomView {
    
    override var nibName: String {
        get {
            return "MeditationLevelButtonSVC"
        }
    }
    
    var title: String {
        get {
            return "Seed"
        }
    }
    
    var length: Int {
        get {
            return 15;
        }
    }
    
    var buttonAction: ((_ length: Int, _ type: String) -> ())!
    @IBOutlet weak var buttonView: RoundedBoxShadowsTemplate!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func customSetup() {
        buttonView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonPressed(tapGestureRecognizer: )))
        buttonView.addGestureRecognizer(tapGesture)
        
        timeLabel.text = "\(length) min."
    }
    
    @objc private func buttonPressed(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let buttonAction = buttonAction else {
            fatalError("ButtonAction not set")
        }
        buttonAction(length, title)
    }
    
}

class level1MedLevelButton: MeditationLevelButtonSVC {
    
    override var length: Int {
        get {
            return 5
        }
    }
    
    override var title: String {
        get {
            return "Seed"
        }
    }
    
    override func customSetup() {
        super.customSetup()
        
        imageView.image = UIImage(named: title)
    }
}

class level2MedLevelButton: MeditationLevelButtonSVC {
    
    override var length: Int {
        get {
            return 15
        }
    }
    
    override var title: String {
        get {
            return "Sprout"
        }
    }
    
    override func customSetup() {
        super.customSetup()
        
        imageView.image = UIImage(named: title)
    }
}

class level3MedLevelButton: MeditationLevelButtonSVC {
    
    override var length: Int {
        get {
            return 30
        }
    }
    
    override var title: String {
        get {
            return "Flower"
        }
    }
    
    override func customSetup() {
        super.customSetup()
        
        imageView.image = UIImage(named: title)
    }
}

class level4MedLevelButton: MeditationLevelButtonSVC {
    
    override var length: Int {
        get {
            return 45
        }
    }
    
    override var title: String {
        get {
            return "Tree"
        }
    }
    
    override func customSetup() {
        super.customSetup()
        
        imageView.image = UIImage(named: title)
    }
}
