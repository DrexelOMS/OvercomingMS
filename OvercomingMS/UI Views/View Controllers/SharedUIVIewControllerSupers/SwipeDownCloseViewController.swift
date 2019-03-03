//
//  SwipeDownCloseViewController.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

//NOTE: you must add a Pan Gesture Recognizer to the view controller, and ctrl drag from it to the view controller icon (white square in yellow square) and make it the delegate, and then connect to this IBAction, unless I can add the gesture recognizer in code

class SwipeDownCloseViewController: DismissableVC, UIGestureRecognizerDelegate {
    
//    private var panGesture = UIPanGestureRecognizer()
//
//    private var swipeDownYThreshold = 100
//    private var restoreToFullAnimationTime = 0.3
//
//    private var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
//    private var initialFrameWidth : Float = 0.0
//    private var initialFrameHeight : Float = 0.0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
//        view.isUserInteractionEnabled = true
//        view.addGestureRecognizer(panGesture)
//
//        initialFrameWidth = Float(view.bounds.width)
//        initialFrameHeight = Float(view.bounds.height)
//
//    }
//
//    //TODO: repair to take the changing safe area
//    @objc func draggedView(_ sender: UIPanGestureRecognizer) {
//
//        let touchPoint = sender.location(in: self.view?.window)
//        if sender.state == UIGestureRecognizer.State.began {
//            initialTouchPoint = touchPoint
//        }
//        else if sender.state == UIGestureRecognizer.State.changed {
//            if touchPoint.y - initialTouchPoint.y > 0 {
//                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: CGFloat(initialFrameWidth), height: CGFloat(initialFrameHeight))
//            }
//        }
//        else if sender.state == UIGestureRecognizer.State.ended {
//            if touchPoint.y - initialTouchPoint.y > CGFloat(swipeDownYThreshold) {
//                dismiss()
//            }
//            else {
//                UIView.animate(withDuration: restoreToFullAnimationTime) {
//                    self.view.frame = CGRect(x: 0, y: 0, width: CGFloat(self.initialFrameWidth), height: CGFloat(self.initialFrameHeight))
//                }
//            }
//        }
//    }
    
    let contentStackView = UIStackView()
    var pullBarSVC: PullBarSVC = PullBarSVC()
   
    var theme : UIColor = UIColor.gray
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContentStackView()
        pullBarSVC.colorTheme = theme.withAlphaComponent(0.6)
        view.backgroundColor = theme.withAlphaComponent(0.6)
        
        setupViews()
        
        setupGestures()
    }
        
    private func setupContentStackView() {
        let contentView = UIView()
        contentView.backgroundColor = DesignConstants.DEFAULT_BACKGROUND_COLOR
        self.view.addSubview(contentView)
        constrain(contentView, self.view.safeAreaLayoutGuide) { (view, superView) in
            view.top == superView.top
            view.right == superView.right
            view.bottom == superView.bottom
            view.left == superView.left
        }
        
        contentView.addSubview(contentStackView)
        contentStackView.axis = .vertical
        constrain(contentStackView, contentView) { (stackView, superView) in
            stackView.top == superView.top
            stackView.right == superView.right
            stackView.bottom == superView.bottom
            stackView.left == superView.left
        }
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupGestures() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture(gesture:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeDown)
        
        pullBarSVC.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pullBarTapped(gesture: )))
        pullBarSVC.addGestureRecognizer(tapGesture)
    }
    
    func addViewsBeforeMain() {
        
    }
    
    func addViewsAfterMain() {
        
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            if swipeGesture.direction == UISwipeGestureRecognizer.Direction.down {
                dismiss()
            }
        }
    }
    
    @objc func pullBarTapped(gesture: UITapGestureRecognizer) {
        self.dismiss()
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
    
    func initializeviewStack(defaultView: SlidingAbstractSVC) {
        
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





