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
    
    var defaultView : SlidingAbstractSVC!
    
    var currentView : SlidingAbstractSVC!
    
    var viewStack : [SlidingAbstractSVC]!
    
    
    
    //var dataIO: IDataIO
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func initializeStackView(defaultView: SlidingAbstractSVC) {
        self.defaultView = defaultView
        
        viewStack = [SlidingAbstractSVC]()
        viewStack.append(self.defaultView)
        currentView = viewStack[0]
        setMainView()
    }
    
    func pushSubView(newSubView: SlidingAbstractSVC) {
        currentView = newSubView;
        viewStack.append(currentView)
        setMainView()
    }
    
    func popSubView() {
        viewStack.remove(at: viewStack.count - 1)
        currentView = viewStack[viewStack.count - 1];
        setMainView()
    }
    
    func resetToDefaultView(){
        //otherwise make sure to animate the currentView first
        viewStack = [SlidingAbstractSVC]()
        viewStack.append(defaultView)
        currentView = viewStack[0]
        setMainView()
    }
    
    private func setMainView(){
        currentView.parentVC = self
        
        mainView.subviews.forEach({ $0.removeFromSuperview() })
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
