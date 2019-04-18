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
        svc.bottomDescription.text = "All progress made during this session will be lost"
        return svc
    }
    
    static func RepeatConfirmation() -> ConfirmationSVC {
        let svc = ConfirmationSVC()
        svc.topDescription.text = "You are about to repeat this entry from today's achievements"
        svc.bottomDescription.text = "This new entry will contain all the same data but with the curent time"
        return svc
    }
    
    static func DeleteConfirmation() -> ConfirmationSVC {
        let svc = ConfirmationSVC()
        svc.topDescription.text = "You are about to delete this item from today's achievements"
        svc.bottomDescription.text = "You will not be able to undo this action"
        return svc
    }
    
    static func GoalsConfirmation() -> ConfirmationSVC {
        let svc = ConfirmationSVC()
        svc.topDescription.text = "You haven't saved your new goal yet!"
        svc.bottomDescription.text = "Are you sure you want to leave this page without saving?"
        return svc
    }
}
