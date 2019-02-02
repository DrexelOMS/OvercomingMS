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
    
    var defaultView : SlidingAbstractSVC!
    var topView : SlidingAbstractSVC {
        get {
            return viewStack[viewStack.count - 1]
        }
    }
    var secondTopView : SlidingAbstractSVC {
        get {
            return viewStack[viewStack.count - 2]
        }
    }
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
        
        setMainView(slideMode: .Instant)
    }
    
    func pushSubView(newSubView: SlidingAbstractSVC) {
        viewStack.append(newSubView)
        
        setMainView(slideMode: .RightToLeft)
    }
    
    func popSubView() {
        setMainView(slideMode: .LeftToRight)
    }
    
    func resetToDefaultView(){
        viewStack = [viewStack[0], topView]
        setMainView(slideMode: .LeftToRight)
    }
    
    private func setMainView(slideMode: SlideMode){
        topView.parentVC = self
        
        topView.frame = mainView.bounds
        topView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        mainView.addSubview(topView)
        
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
        
    }
    
    private func slideRightToLeft() {
        
        topView.frame.origin.x += mainView.frame.width
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            
            self.topView.frame.origin.x -= self.mainView.frame.width
            self.secondTopView.frame.origin.x -= self.mainView.frame.width
            
        }, completion: { finished in
            self.topView.frame = self.mainView.bounds
            self.topView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        })
    }
    
    private func slideLeftToRight() {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            
            self.topView.frame.origin.x += self.mainView.frame.width
            self.secondTopView.frame.origin.x += self.mainView.frame.width
            
        }, completion: { finished in
            self.secondTopView.frame = self.mainView.bounds
            self.secondTopView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.topView.removeFromSuperview()
            self.viewStack.remove(at: self.viewStack.count - 1)
        })
    }
    
    func updateProgressBarMain(mainPercentage: Int){
        print("Main percentage is now: \(mainPercentage)")
    }
    
    func updateProgressBarSub(subPercentage: Int) {
        print("Sub percentage is now: \(subPercentage)")
    }
    
}
