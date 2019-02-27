//
//  DismissableVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class DismissableVC : UIViewController {
    
    var dismissalDelegate: DismissalDelegate?
    
    func dismiss() {
        self.dismiss(animated: true) {
            self.dismissalDelegate?.finishedShowing(viewController: self)
        }
    }
    
}
