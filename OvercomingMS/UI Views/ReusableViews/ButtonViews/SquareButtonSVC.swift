//
//  BlueButtonUIView.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SquareButtonSVC: CustomView {

    override var nibName: String {
        get {
            return "SquareButtonSVC"
        }
    }
    
    @IBOutlet weak var buttonView: UIView!
    var backButtonAction : (() -> ())?
    @IBOutlet weak var backIcon: UIImageView!
    
    override func customSetup() {
        let tintedImage = backIcon.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        backIcon.image = tintedImage
        backIcon.tintColor = UIColor.white
        
        buttonView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonPressed(tapGestureRecognizer: )))
        buttonView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func buttonPressed(tapGestureRecognizer: UITapGestureRecognizer){
        guard let backButtonAction = backButtonAction else {
            fatalError("ButtonAction not set")
        }
        backButtonAction()
    }

}
