//
//  BlueButtonUIView.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ContinueButtonSVC: CustomView {

    override var nibName: String {
        get {
            return "ContinueButtonSVC"
        }
    }
    
    var colorTheme: UIColor = UIColor.white {
        didSet {
            setColors()
        }
    }
    
    @IBOutlet weak var buttonView: UIView!
    var continueButtonAction : (() -> ())?
    @IBOutlet weak var continueIcon: UIImageView!
    
    override func customSetup() {
        setColors()
        
        let tintedImage = continueIcon.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        continueIcon.image = tintedImage
        continueIcon.tintColor = UIColor.white
        
        buttonView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonPressed(tapGestureRecognizer: )))
        buttonView.addGestureRecognizer(tapGesture)
    }
    
    private func setColors(){
        buttonView.backgroundColor = colorTheme.withAlphaComponent(0.6)
    }
    
    @objc private func buttonPressed(tapGestureRecognizer: UITapGestureRecognizer){
        guard let continueButtonAction = continueButtonAction else {
            fatalError("ButtonAction not set")
        }
        continueButtonAction()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        buttonView.backgroundColor = colorTheme.withAlphaComponent(0.6)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        buttonView.backgroundColor = colorTheme
    }

}
