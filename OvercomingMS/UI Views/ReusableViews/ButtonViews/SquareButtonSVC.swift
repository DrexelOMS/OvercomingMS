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
    
    var colorTheme: UIColor = UIColor.gray {
        didSet {
            setColors()
        }
    }
    
    @IBInspectable var isContinueButton: Bool = false {
        didSet {
            if isContinueButton {
                label.text = "Continue"
                backIcon.isHidden = true
                forwardIcon.isHidden = false
            }
        }
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var borderTop: UIView!
    @IBOutlet weak var buttonView: UIView!
    var backButtonAction : (() -> ())?
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var forwardIcon: UIImageView!
    
    override func customSetup() {
        setColors()
        
        let tintedImage = backIcon.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        backIcon.image = tintedImage
        backIcon.tintColor = UIColor(red: 51, green: 51, blue: 51)
        
        forwardIcon.isHidden = true
        
        buttonView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonPressed(tapGestureRecognizer: )))
        buttonView.addGestureRecognizer(tapGesture)
    }
    
    private func setColors(){
        borderTop.backgroundColor = colorTheme.withAlphaComponent(0.6)
    }
    
    @objc private func buttonPressed(tapGestureRecognizer: UITapGestureRecognizer){
        guard let backButtonAction = backButtonAction else {
            fatalError("ButtonAction not set")
        }
        backButtonAction()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        borderTop.backgroundColor = colorTheme.withAlphaComponent(0.6)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        borderTop.backgroundColor = colorTheme
    }

}
