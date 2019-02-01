//
//  SwipeDownCloseViewController.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

//NOTE: you must add a Pan Gesture Recognizer to the view controller, and ctrl drag from it to the view controller icon (white square in yellow square) and make it the delegate, and then connect to this IBAction, unless I can add the gesture recognizer in code

class SwipeDownCloseViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private var panGesture = UIPanGestureRecognizer()
    
    private var swipeDownYThreshold = 100
    private var restoreToFullAnimationTime = 0.3
    
    private var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var initialFrameWidth : Float = 0.0
    private var initialFrameHeight : Float = 0.0 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(panGesture)
        
        initialFrameWidth = Float(view.bounds.width)
        initialFrameHeight = Float(view.bounds.height)
        
    }
    
    //TODO: repair to take the changing safe area
    @objc func draggedView(_ sender: UIPanGestureRecognizer) {
        
        let touchPoint = sender.location(in: self.view?.window)
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        }
        else if sender.state == UIGestureRecognizer.State.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: CGFloat(initialFrameWidth), height: CGFloat(initialFrameHeight))
            }
        }
        else if sender.state == UIGestureRecognizer.State.ended {
            if touchPoint.y - initialTouchPoint.y > CGFloat(swipeDownYThreshold) {
                self.dismiss(animated: true, completion: nil)
            }
            else {
                UIView.animate(withDuration: restoreToFullAnimationTime) {
                    self.view.frame = CGRect(x: 0, y: 0, width: CGFloat(self.initialFrameWidth), height: CGFloat(self.initialFrameHeight))
                }
            }
        }
    }
    
}





