//
//  ConfirmationFactory.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/9/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class ConfirmationFactory {
    static func CancelConfirmation() -> ConfirmationSVC {
        let svc = ConfirmationSVC()
        svc.topDescription.text = "Are you sure you want to cancel?"
        svc.bottomDescription.text = "All progress during this session will be lost."
        return svc
    }
    
    static func RepeatConfirmation() -> ConfirmationSVC {
        let svc = ConfirmationSVC()
        svc.topDescription.text = "Are you sure you want to repeat this entry?"
        svc.bottomDescription.text = "This copy will be saved in your entry list."
        return svc
    }
    
    static func DeleteConfirmation() -> ConfirmationSVC {
        let svc = ConfirmationSVC()
        svc.topDescription.text = "Are you sure you want to delete?"
        svc.bottomDescription.text = "You won’t be able to recover this entry."
        return svc
    }
    
    static func GoalsConfirmation() -> ConfirmationSVC {
        let svc = ConfirmationSVC()
        svc.topDescription.text = "You haven't saved your new goal yet!"
        svc.bottomDescription.text = "Are you sure you want to leave this page without saving?"
        return svc
    }
}
