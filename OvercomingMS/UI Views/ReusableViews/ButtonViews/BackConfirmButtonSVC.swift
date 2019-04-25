//
//  TwoSquareButtonSVCs.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class BackConfirmButtonsSVC : CustomView, ButtonDelegate {
    
    @IBOutlet weak var LeftButton: CustomButton!
    @IBOutlet weak var RightButton: CustomButton!
    
    var leftButtonAction : (() -> ())?
    var rightButtonAction : (() -> ())?
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var confirmIcon: UIImageView!
    
    var colorTheme: UIColor = UIColor.gray
    {
        didSet {
            setColors()
        }
    }
    
    override var nibName: String {
        get {
            return "BackConfirmButtonsSVC"
        }
    }
    
    override func customSetup() {
        
        setColors()
        
        LeftButton.aggregator = self
        RightButton.aggregator = self
        
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
    
    private func setColors(){
        LeftButton.backgroundColor = colorTheme.withAlphaComponent(0.6)
        RightButton.backgroundColor = colorTheme
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
    
    func isHighlighted(highlighted: Bool, sender: CustomButton) {
        if highlighted {
            if sender == LeftButton {
                sender.backgroundColor = colorTheme.withAlphaComponent(0.8)
            }
            else if sender == RightButton {
                sender.backgroundColor = colorTheme.withAlphaComponent(0.8)
            }
        }
        else {
            setColors()
        }
    }
    
}
