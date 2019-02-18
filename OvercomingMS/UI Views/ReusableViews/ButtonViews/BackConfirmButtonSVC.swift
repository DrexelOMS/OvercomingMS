//
//  TwoSquareButtonSVCs.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class BackConfirmButtonsSVC : CustomView {
    
    @IBOutlet weak var LeftButton: UIView!
    @IBOutlet weak var RightButton: UIView!
    
    var leftButtonAction : (() -> ())?
    var rightButtonAction : (() -> ())?
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var confirmIcon: UIImageView!
    
    override var nibName: String {
        get {
            return "BackConfirmButtonsSVC"
        }
    }
    
    override func customSetup() {
        
        let tintedImage = backIcon.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        backIcon.image = tintedImage
        backIcon.tintColor = UIColor.white
        
        let tintedImage2 = confirmIcon.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        confirmIcon.image = tintedImage2
        confirmIcon.tintColor = UIColor.white
        
        LeftButton.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(leftButtonPressed(tapGestureRecognizer: )))
        LeftButton.addGestureRecognizer(tapGesture)
        
        RightButton.isUserInteractionEnabled = true
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(RightButtonPressed(tapGestureRecognizer: )))
        RightButton.addGestureRecognizer(tapGesture2)
    }
    
    @objc private func leftButtonPressed(tapGestureRecognizer: UITapGestureRecognizer){
        guard let leftButtonAction = leftButtonAction else {
            fatalError("ButtonAction not set")
        }
        leftButtonAction()
    }
    
    @objc private func RightButtonPressed(tapGestureRecognizer: UITapGestureRecognizer){
        guard let rightButtonAction = rightButtonAction else {
            fatalError("ButtonAction not set")
        }
        rightButtonAction()
    }
}