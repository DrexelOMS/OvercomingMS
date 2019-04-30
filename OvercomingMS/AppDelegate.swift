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
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
        do {
            _ = try Realm()
        } catch {
            print("Error initialising new realm, \(error)")
        }
        
        //reset user defaults and realm
        //        let defaults = UserDefaults.standard
        //        let dictionary = defaults.dictionaryRepresentation()
        //        dictionary.keys.forEach { key in
        //            defaults.removeObject(forKey: key)
        //        }
        //        try! realm.write {
        //            realm.deleteAll()
        //        }
        
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
            defaults.set(Date().addingTimeInterval(-60*60*24), forKey: "FirstOpenDate")
        }
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        _ = OMSDateAccessor().todaysDate
    }
    
}

