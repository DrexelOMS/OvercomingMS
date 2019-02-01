//
//  TrackingModuleAbstractVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

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
    
    func resetViewStack(subView: SlidingAbstractSVC){
        if viewStack.count <= 0 {
            //Set Stack and First View Instantly
            viewStack.append(subView)
            setInstantMainView()
        }
        else {
            //otherwise make sure to animate the currentView first
            viewStack = [SlidingAbstractSVC]()
            viewStack.append(subView)
        }
    }
    
    private func setInstantMainView(){
        currentView = viewStack[0]
        currentView.parentVC = self
        mainView.addSubview(currentView)
        
        constrain(currentView, mainView) { currentView, mainView in
            currentView.top == mainView.top
            currentView.left == mainView.left
            currentView.right == mainView.right
            currentView.bottom == mainView.bottom
        }
    }
    
    func pushSubView(newSubView: SlidingAbstractSVC) {
        currentView = newSubView;
        currentView.parentVC = self
        mainView.addSubview(currentView)
        
        constrain(currentView, mainView) { currentView, mainView in
            currentView.top == mainView.top
            currentView.left == mainView.left
            currentView.right == mainView.right
            currentView.bottom == mainView.bottom
        }
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
