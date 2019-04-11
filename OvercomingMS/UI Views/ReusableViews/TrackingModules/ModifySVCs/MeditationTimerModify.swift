//
//  Created by user150052 on 4/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class MeditationTimerModifySVC: ModifyAbstractSVC {
    
    var selectedLength : Int?  { // In minutes
        get {
            return lengthTFI.selectedLength
        }
        set {
            lengthTFI.selectedLength = newValue
        }
    }
    
    var lengthTFI = LengthTFI()
    
    override func customSetup() {
        //set the initial text and start time of the textField
        titleLabel.text = "How long do you want to meditate for?"
        
        textInputStackView.addArrangedSubview(lengthTFI)
        textInputStackView.translatesAutoresizingMaskIntoConstraints = false
        
        backConfirmButtons.leftButtonAction = BackPressed
        backConfirmButtons.rightButtonAction = ConfirmPressed
        
    }
    
    override func ConfirmPressed() {
        
        if let length = selectedLength {
            if length > 0 {
                parentVC.pushSubView(newSubView: MeditationTimerSVC(startingSeconds: length * 60, meditationType: "Silent"))
            }
        }
    }
}
