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
    
    @IBInspectable var title: String = ""
    
    @IBInspectable var length: Int = 15 {
        didSet {
            timeLabel.text = "\(length) min."
        }
    }
    
    @IBInspectable var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var buttonAction: ((_ length: Int, _ type: String) -> ())!
    @IBOutlet weak var buttonView: RoundedBoxShadowsTemplate!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func customSetup() {
        buttonView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonPressed(tapGestureRecognizer: )))
        buttonView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func buttonPressed(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let buttonAction = buttonAction else {
            fatalError("ButtonAction not set")
        }
        buttonAction(length, title)
    }
    
    override func layoutSubviews() {
        DispatchQueue.main.async {
            var rate = 1 - (150 - self.stackView.frame.height) / 50
            rate = rate > 1 ? 1 : (rate < 0 ? 0 : rate)
            
            let fontSize = 16 + (6) * rate
            
            self.timeLabel.font = UIFont(name: self.timeLabel.font.fontName, size: fontSize)
        }
    }
    
}
