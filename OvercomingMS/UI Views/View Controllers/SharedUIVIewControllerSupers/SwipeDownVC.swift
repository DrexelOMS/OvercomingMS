//
//  SwipeDownVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class SwipeDownVC : DismissableVC {
    
    let contentStackView = UIStackView()
    var pullBarSVC: PullBarSVC = PullBarSVC()
    
    var theme : UIColor = UIColor.gray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContentStackView()
        pullBarSVC.colorTheme = theme.withAlphaComponent(0.6)
        view.backgroundColor = theme.withAlphaComponent(0.6)
        setupGestures()
    }
    
    private func setupContentStackView() {
        let contentView = UIView()
        contentView.backgroundColor = DesignConstants.DEFAULT_BACKGROUND_COLOR
        self.view.addSubview(contentView)
        if #available(iOS 11.0, *) {
            constrain(contentView, self.view.safeAreaLayoutGuide) { (view, superView) in
                view.top == superView.top
                view.right == superView.right
                view.bottom == superView.bottom
                view.left == superView.left
            }
        } else {
            NSLayoutConstraint.activate([
                contentView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0),
                bottomLayoutGuide.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
                ])
            
            constrain(contentView, self.view) { (view, superView) in
                view.right == superView.right
                view.left == superView.left
            }
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
}
