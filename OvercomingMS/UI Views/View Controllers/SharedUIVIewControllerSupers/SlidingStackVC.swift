//
//  SwipeDownCloseViewController.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class SlidingStackVC: SwipeDownVC, UIGestureRecognizerDelegate {
    
    var mainView : UIView = UIView()
    var initialView: SlidingAbstractSVC!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        initializeviewStack(defaultView: initialView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        topView.didLayoutSubviews()
    }
    
    func addViewsBeforeMain() {
        
    }
    
    override func dismiss() {
        super.dismiss()
        onDismiss()
        //your codehere
    }

    var onDismiss:()->Void = {}
    
    
    func addViewsAfterMain() {
        
    }
    
    convenience init(initialView: SlidingAbstractSVC) {
        self.init()
        
        self.initialView = initialView
    }

    //MARK: Methods
    
    func setupViews() {
        
        contentStackView.addArrangedSubview(pullBarSVC)
        constrain(pullBarSVC) { (view) in
            view.height == 30.0
        }
    
        
        addViewsBeforeMain()
        contentStackView.addArrangedSubview(mainView)
        addViewsAfterMain()
    }

    
    private func initializeviewStack(defaultView: SlidingAbstractSVC) {
        
        viewStack = [SlidingAbstractSVC]()
        viewStack.append(defaultView)
        
        setMainView(slideMode: .Instant)
        reload()
    }
    
    func reload() {
        
    }
    
    func pushSubView(newSubView: SlidingAbstractSVC) {
        viewStack.append(newSubView)
        
        setMainView(slideMode: .RightToLeft)
        reload()
    }
    
    func popSubView() {
        setMainView(slideMode: .LeftToRight)
        reload()
    }
    
    func resetToDefaultView(){
        viewStack = [viewStack[0], topView]
        setMainView(slideMode: .LeftToRight)
        reload()
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
            topView.reload()
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
    
    
}





