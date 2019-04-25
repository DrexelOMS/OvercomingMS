//
//  TrackingToggleSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/25/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

@IBDesignable
class TrackingToggleSVC : CustomView {
    
    override var nibName: String {
        get {
            return "TrackingToggleSVC"
        }
    }
    
    @IBInspectable
    var colorTheme: UIColor? {
        didSet {
            circle.backgroundColor = colorTheme
        }
    }
    
    @IBInspectable
    var title: String? {
        didSet {
            label.text = title
        }
    }
    
    var toggleAction: ((Bool) -> ())?
    
    @IBOutlet private weak var circle: OMSRoundedBox!
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var toggle: UISwitch!
    
    override func customSetup() {
        
    }
    
    func setToggle(isEnabled: Bool) {
        toggle.isOn = isEnabled
    }
    
    @IBAction private func toggleChanged(_ sender: Any) {
        guard let toggleAction = toggleAction else {
            fatalError("forgot to set toggle Action")
        }
        
        toggleAction(toggle.isOn)
    }
}
