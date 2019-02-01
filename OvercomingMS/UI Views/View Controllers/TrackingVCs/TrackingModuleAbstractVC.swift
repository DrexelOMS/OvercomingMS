//
//  TrackingModuleAbstractVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

@IBDesignable
class TrackingModuleAbstractVC: SwipeDownCloseViewController {
    
    @IBInspectable var theme : UIColor = UIColor.blue
    
    //var progressBar : TrackingModuleProgressBar
    
    @IBOutlet var mainView : UIView!
    
    var currentView : SlidingAbstractSVC!
    
    var viewStack : [SlidingAbstractSVC] = [SlidingAbstractSVC]()
    
    //var dataIO: IDataIO
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func setCurrentView() {
        
    }
    
    func slideViewIn(viewToShow: UIView, viewToRemove: UIView){
    
    }

    func slideViewOut(viewToShow: UIView, viewToRemove: UIView){
        
    }
    
    func slideOutToDefault(viewToRemove: UIView){
        
    }
    
    func updateProgressBar(mainValue: Int, subValue: Int){
        
    }
    
}
