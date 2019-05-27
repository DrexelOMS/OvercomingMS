//
//  FakeClasses.swift
//  OvercomingMSTests
//
//  Created by Vincent Finn on 5/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
@testable import OvercomingMS

class MockNotificationCenter : NotificationCenterWrapper {
    
    var postWasCalled = false
    override func post(name: NSNotification.Name, object: Any?) {
        postWasCalled = true
    }
    
    var addObserverWasCalled = 0
    override func addObserver(_ observer: Any, selector: Selector, name: NSNotification.Name?, object: Any?) {
        addObserverWasCalled += 1
    }
    
    var removeObserverWasCalled = 0
    override func removeObserver(_ observer: Any, name: NSNotification.Name?, object: Any?) {
        removeObserverWasCalled += 1
    }
}

class MockSlidingStackVC: SlidingStackVC {
    var pushWasCalled = false
    override func pushSubView(newSubView: SlidingAbstractSVC) {
        super.pushSubView(newSubView: newSubView)
        pushWasCalled = true
    }
    
    var popWasCalled = false
    override func popSubView() {
//        super.popSubView()
        popWasCalled = true
    }
    
    var presentWasCalled = false
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentWasCalled = true
    }
    
    var dismissWasCalled = false
    override func dismiss() {
        dismissWasCalled = true
    }
}

class MockTrackingModulesDBS: TrackingModulesDBS {
    var updateCompleteStatusCalled = false
    
    override func updateCompleteStatus() {
        updateCompleteStatusCalled = true
    }
}
