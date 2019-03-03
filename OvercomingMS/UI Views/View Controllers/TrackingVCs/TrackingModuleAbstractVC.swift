//
//  TrackingModuleAbstractVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/30/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class TrackingModuleAbstractVC: SwipeDownCloseViewController {
    
    //MARK: Attributes
    
    var progressBar: TrackingProgressBar = TrackingModuleProgressBar()
    var pullBarSVC: PullBarSVC = PullBarSVC()
    var mainView : UIView = UIView()
    
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
    
    //MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        // Do any additional setup after loading the view.
        updateProgressBar()
        progressBar.colorTheme = theme
        
        pullBarSVC.colorTheme = theme.withAlphaComponent(0.6)
        view.backgroundColor = theme.withAlphaComponent(0.6)
    }
    
    func addProgressBar() {
        let progressView = UIView()
        contentStackView.addArrangedSubview(progressView)
        constrain(progressView) { (view) in
            view.height == 100.0
        }
        
        progressView.addSubview(progressBar)
        
        constrain(progressBar, progressView) { (view, superView) in
            view.top == superView.top + 10
            view.right == superView.right - 20
            view.bottom == superView.bottom - 10
            view.left == superView.left + 20
        }
    }
    
    func setupViews() {

        contentStackView.addArrangedSubview(pullBarSVC)
        constrain(pullBarSVC) { (view) in
            view.height == 30.0
        }
        
        addProgressBar()
        
        contentStackView.addArrangedSubview(mainView)
    }
    
    func initializeviewStack(defaultView: SlidingAbstractSVC) {
        
        viewStack = [SlidingAbstractSVC]()
        viewStack.append(defaultView)
        
        setMainView(slideMode: .Instant)
    }
    
    func pushSubView(newSubView: SlidingAbstractSVC) {
        viewStack.append(newSubView)
        
        setMainView(slideMode: .RightToLeft)
        updateProgressBar()
    }
    
    func popSubView() {
        setMainView(slideMode: .LeftToRight)
        updateProgressBar()
    }
    
    func resetToDefaultView(){
        viewStack = [viewStack[0], topView]
        setMainView(slideMode: .LeftToRight)
        updateProgressBar()
    }
    
    //MARK: Helper methods
    
    private func setMainView(slideMode: SlideMode){
        topView.initialize(parentVC: self)
        topView.frame = mainView.bounds
        topView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        switch(slideMode){
            
        case .RightToLeft:
            mainView.addSubview(topView)
            slideRightToLeft()
            break
            
        case .LeftToRight:
            slideLeftToRight()
            break
            
        default:
            mainView.addSubview(topView)
            break;
        }
        
    }
    
    private func slideRightToLeft() {
        
        topView.frame.origin.x += mainView.frame.width
        topView.reload()
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            
            self.topView.frame.origin.x -= self.mainView.frame.width
            self.secondTopView.frame.origin.x -= self.mainView.frame.width
            
        }, completion: { finished in
            self.topView.frame = self.mainView.bounds
            self.topView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        })
    }
    
    private func slideLeftToRight() {
        
        secondTopView.reload() 
        
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
    
    //MARK: Abstract Methods
    
    func updateProgressBar(){
        
    }
    
}
