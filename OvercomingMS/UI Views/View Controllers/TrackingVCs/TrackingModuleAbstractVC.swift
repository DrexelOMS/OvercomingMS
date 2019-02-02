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
    var previousView : SlidingAbstractSVC!
    var viewStack : [SlidingAbstractSVC]!
    
    private enum SlideMode { case Instant, RightToLeft, LeftToRight }
    
    
    
    
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
        
        setMainView(slideMode: .Instant)
    }
    
    func pushSubView(newSubView: SlidingAbstractSVC) {
        previousView = currentView
        currentView = newSubView;
        viewStack.append(currentView)
        
        setMainView(slideMode: .RightToLeft)

    }
    
    func popSubView() {
        previousView = currentView
        viewStack.remove(at: viewStack.count - 1)
        currentView = viewStack[viewStack.count - 1];
        
        setMainView(slideMode: .LeftToRight)
    }
    
    func resetToDefaultView(){
        //otherwise make sure to animate the currentView first
        previousView = currentView
        viewStack = [SlidingAbstractSVC]()
        viewStack.append(defaultView)
        currentView = viewStack[0]
        
        setMainView(slideMode: .LeftToRight)
    }
    
    private func setMainView(slideMode: SlideMode){
        currentView.parentVC = self
        
        currentView.frame = mainView.bounds
        currentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mainView.addSubview(currentView)
        
        switch(slideMode){
            
        case .RightToLeft:
            slideRightToLeft()
            break
            
        case .LeftToRight:
            slideLeftToRight()
            break
            
        default:
            break;
            
        }
        
//                constrain(self.currentView, self.mainView) { currentView, mainView in
//                    currentView.top == mainView.top
//                    currentView.left == mainView.left
//                    currentView.right == mainView.right
//                    currentView.bottom == mainView.bottom
//                }

        
    }
    
    private func slideRightToLeft() {
        
        currentView.frame.origin.x += mainView.frame.width
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            
            self.previousView.frame.origin.x -= self.mainView.frame.width
            self.currentView.frame.origin.x -= self.mainView.frame.width
            
        }, completion: { finished in
            print("Napkins opened!")
            self.previousView.removeFromSuperview()
            self.currentView.frame = self.mainView.bounds
            self.currentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        })
    }
    
    private func slideLeftToRight() {
        
        currentView.frame.origin.x -= mainView.frame.width
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            
            self.previousView.frame.origin.x += self.mainView.frame.width
            self.currentView.frame.origin.x += self.mainView.frame.width
            
        }, completion: { finished in
            print("Napkins opened!")
            self.previousView.removeFromSuperview()
            self.currentView.frame = self.mainView.bounds
            self.currentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        })
    }
    
    func updateProgressBar(mainValue: Int, subValue: Int){
        
    }
    
}
