//
//  ReusableTest.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/26/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import LinearProgressBar


protocol TrackingProgressBarDelegate : class {
    func didPressCheckButton(_ sender: TrackingProgressBar)
    func didPressLeftContainer(_ sender: TrackingProgressBar)
}

@IBDesignable
class TrackingProgressBar: CustomView {
    
    override var nibName: String { return "TrackingProgressBar" }
    
    weak var delegate : TrackingProgressBarDelegate?
    
    @IBInspectable private var Title: String = "Title" {
        didSet {
            let kern = leftLabel.kerning
            leftLabel.text = Title
            leftLabel.kerning = kern
        }
    }
    
    @IBInspectable var barColor: UIColor = UIColor.gray {
        didSet {
            linearProgressBar.barColor = barColor
            linearProgressBar.trackColor = barColor.withAlphaComponent(0.2)
        }
    }
    
    @IBInspectable var progressBar: Bool = true {
        didSet {
            linearProgressBar.isHidden = !progressBar
        }
    }
    
    var colorTheme : UIColor {
        get {
            return barColor
        }
        set {
            barColor = newValue
        }
    }
    @IBOutlet weak var shadowedRoundedView: OMSRoundedBox!
    @IBOutlet weak var roundedView: OMSRoundedBox!
    @IBOutlet weak var rightContainerView: UIView!
    @IBOutlet private weak var leftContainerView: UIView!
    @IBOutlet private weak var leftLabel: UILabel!
    @IBOutlet private weak var rightLabel: UILabel!
    @IBOutlet weak var linearProgressBar: LinearProgressBar!
    @IBOutlet weak var checkButton: UIButton!
    
    var originalBackground: UIColor = UIColor.white
    
    override func customSetup() {
        //set the default progress bar to full
        linearProgressBar.progressValue = 100
        
        leftContainerView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(leftContainerPressed(tapGestureRecognizer: )))
        leftContainerView.addGestureRecognizer(tapGesture)
        
    }
    
    /**
     Sets the Progress Bar to the given value *(0-100)
     */
    func incremementProgressValue(value : Float){
        linearProgressBar.progressValue += CGFloat(value);
    }
    
    private func setProgressValue(value : Int) {
        linearProgressBar.progressValue = CGFloat(value);
        setColorMode(completed: linearProgressBar.progressValue >= 100)
        
    }
    
    private func setRightLabel(description: String) {
        rightLabel.text = description
    }
    
    private func setColorMode(completed: Bool) {
        if(completed) {
            roundedView.backgroundColor = colorTheme
            leftLabel.textColor = UIColor.white
            rightLabel.textColor = UIColor.white
            checkButton.setImage(UIImage(named: "QuickCompleteReversed"), for: .normal)
            linearProgressBar.isHidden = true
        }
        else {
            roundedView.backgroundColor = originalBackground
            leftLabel.textColor = UIColor.black
            rightLabel.textColor = UIColor.black
            checkButton.setImage(UIImage(named: "QuickComplete"), for: .normal)
            linearProgressBar.isHidden = false
        }
    }
    
    func getProgressValue() -> Float{
        return Float(linearProgressBar.progressValue)
    }
    
    func setTitle(title: String) {
        Title = title
    }
    func getTitle() -> String
    {
        return Title
    }
    
    func toggleCheckMarkVisibility(isHidden: Bool) {
        self.rightContainerView.isHidden = isHidden
        if isHidden {
            shadowedRoundedView.shadowOpacity = 0
            
            originalBackground = UIColor(rgb: 0xF8F8F8)
            shadowedRoundedView.backgroundColor = originalBackground
            roundedView.backgroundColor = originalBackground
        }
    }
    
    @objc private func leftContainerPressed(tapGestureRecognizer: UITapGestureRecognizer){
        delegate?.didPressLeftContainer(self)
    }
    
    @IBAction private func checkButtonPressed(_ sender: UIButton) {
        delegate?.didPressCheckButton(self)
    }
    
    func update(trackingDBS: TrackingModulesDBS, hideBar: Bool = false) {
        if !hideBar {
            setProgressValue(value: trackingDBS.getPercentageComplete())
        }
        setRightLabel(description: trackingDBS.getTrackingDescription())
    }
}

@IBDesignable
extension UILabel {
    @IBInspectable
    public var kerning:CGFloat {
        set{
            if let currentAttibutedText = self.attributedText {
                let attribString = NSMutableAttributedString(attributedString: currentAttibutedText)
                attribString.addAttributes([NSAttributedString.Key.kern:newValue], range:NSMakeRange(0, currentAttibutedText.length))
                self.attributedText = attribString
            }
        } get {
            var kerning:CGFloat = 0
            if let attributedText = self.attributedText {
                attributedText.enumerateAttribute(NSAttributedString.Key.kern,
                                                  in: NSMakeRange(0, attributedText.length),
                                                  options: .init(rawValue: 0)) { (value, range, stop) in
                                                    kerning = value as? CGFloat ?? 0
                }
            }
            return kerning
        }
    }
}
