//
//  FakeClasses.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
@testable import OvercomingMS

class MockNotificationCenter : NotificationCenterWrapper {
    var postWasCalled = false
    override func post(name: NSNotification.Name, object: Any?) {
        postWasCalled = true
    }
}

//class MockTrackingModulesDBS: TrackingModulesDBS {
//    var updateCompleteStatusCalled = false
//    
//    override func updateCompleteStatus() {
//        updateCompleteStatusCalled = true
//    }
//}
