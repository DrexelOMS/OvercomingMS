//
//  NotifcationCenterWrapper.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 5/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class NotificationCenterWrapper {
    
    func post(name: NSNotification.Name, object: Any?) {
        NotificationCenter.default.post(name: name, object: object)
    }
    
    func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
    
    func removeObserver(_ observer: Any, name: NSNotification.Name?, object: Any?) {
        NotificationCenter.default.removeObserver(observer, name: name, object: object)
    }
    
}
