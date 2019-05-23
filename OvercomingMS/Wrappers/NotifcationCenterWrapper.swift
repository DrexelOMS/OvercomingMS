//
//  NotifcationCenterWrapper.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 5/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation

class NotificationCenterWrapper {
    
    func post(name: NSNotification.Name, object: Any?) {
        NotificationCenter.default.post(name: name, object: object)
    }
    
}
