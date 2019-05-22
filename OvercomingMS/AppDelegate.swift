//
//  AppDelegate.swift
//  OvercomingMS
//
//  Created by Vince on 1/3/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func firstTimeInitializers() {
        //First Time initilizers must occur in order
        _ = OMSDateAccessor().todaysDate
        
        if ActiveTrackingDBS().activeTracking.count <= 0 {
            ActiveTrackingDBS().writeFirstDay()
        }
        
        let goals = GoalsDBS().goals
        if goals.count <= 0 {
            GoalsDBS().writeFirstDay()
        }
        
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "FirstOpenDate") == nil {
            // let the user go back 7 days before they first installed the app
            defaults.set(Date().addingTimeInterval(-60*60*24*7), forKey: "FirstOpenDate")
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
        do {
            _ = try Realm()
        } catch {
            print("Error initialising new realm, \(error)")
        }
        
        firstTimeInitializers()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
}

