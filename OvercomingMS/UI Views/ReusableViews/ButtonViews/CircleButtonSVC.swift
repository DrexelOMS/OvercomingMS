//
//  CircleButtonSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/31/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class CircleButtonSVC: CustomView, ButtonDelegate {
    
    override var nibName: String {
        get {
            return "CircleButtonSVC"
        }
    }
    
    @IBInspectable var buttonImage: UIImage? {
        didSet {
            if let image = buttonImage {
                setButtonImage(image: image)
            }
        }
    }
    @IBInspectable var labelName: String? {
        didSet {
            if let label = labelName {
                self.label.text = label
            }
        }
    }
    
    @IBOutlet weak var button: CustomButton!
    @IBOutlet weak var label: UILabel!
    
    var buttonAction : (() -> ())?
    
    var colorTheme : UIColor = UIColor.black {
        didSet {
            button.setTitleColor(UIColor(rgb: 0x333333), for: .normal)
        }
    }
    
    convenience init(image: UIImage, label: String) {
        self.init()
        
        setButtonImage(image: image)
        self.label.text = label
    }
    
    private func setButtonImage(image: UIImage) {
        let tintedImage = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = colorTheme
        button.imageEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
    }
    
    override func customSetup() {
        button.aggregator = self
    }
    
    func setEnabled(enabled: Bool) {
        button.isEnabled = enabled
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let buttonAction = buttonAction else {
            fatalError("ButtonAction not set")
        }
        buttonAction()
    }
    
    func isHighlighted(highlighted: Bool) {
        if highlighted {
            button.backgroundColor = UIColor.gray
        }
        else {
            button.backgroundColor = UIColor.white
        }
    }
    
}
