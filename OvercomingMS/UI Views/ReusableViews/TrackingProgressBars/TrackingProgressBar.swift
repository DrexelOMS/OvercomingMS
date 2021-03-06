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
    
    //TODO rename to hasProgressBar, this is being set on the main storyboard
    @IBInspectable var hasProgressBar: Bool = true {
        didSet {
            progressBarContainer.isHidden = !hasProgressBar
            paddingView.isHidden = !hasProgressBar
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
    @IBOutlet weak var progressBarContainer: OMSRoundedBox!
    @IBOutlet weak var paddingView: UIView!
    
    var originalBackground: UIColor = UIColor.white
    
    private var isTracked = true {
        didSet {
            if isTracked {
                shadowedRoundedView.backgroundColor = colorTheme
            }
            else {
                shadowedRoundedView.backgroundColor = UIColor.lightGray
            }
            checkButton.isEnabled = isTracked
        }
    }
    
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
    }
    
    private func setRightLabel(description: String) {
        rightLabel.text = description
    }
    
    private func setColorMode(completed: Bool) {
        if(completed) {
            if isTracked {
                shadowedRoundedView.backgroundColor = colorTheme
            }
            else {
                shadowedRoundedView.backgroundColor = UIColor.lightGray
            }
            leftLabel.textColor = UIColor.white
            rightLabel.textColor = UIColor.white
            checkButton.setImage(UIImage(named: "QuickCompleteReversed"), for: .normal)
            progressBarContainer.isHidden = true
            paddingView.isHidden = true
        }
        else {
            shadowedRoundedView.backgroundColor = originalBackground
            leftLabel.textColor = UIColor.black
            rightLabel.textColor = UIColor.black
            checkButton.setImage(UIImage(named: "QuickComplete"), for: .normal)
            progressBarContainer.isHidden = false
            paddingView.isHidden = false
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
            shadowedRoundedView.clickable = false
            
            originalBackground = UIColor(rgb: 0xF8F8F8)
            shadowedRoundedView.backgroundColor = originalBackground
            shadowedRoundedView.backgroundColor = originalBackground
        }
    }
    
    @objc private func leftContainerPressed(tapGestureRecognizer: UITapGestureRecognizer){
        if isTracked {
            delegate?.didPressLeftContainer(self)
        }
    }
    
    @IBAction private func checkButtonPressed(_ sender: UIButton) {
        if isTracked {
            delegate?.didPressCheckButton(self)
        }
    }
    
    func update(trackingDBS: TrackingModulesDBS, isTracked: Bool = true) {
        self.isTracked = isTracked
        if isTracked {
            setColorMode(completed: trackingDBS.getPercentageComplete() >= 100)
            setRightLabel(description: trackingDBS.getTrackingDescription())
            
            checkButton.isEnabled = trackingDBS.getPercentageComplete() < 100
            
            if hasProgressBar {
                setProgressValue(value: trackingDBS.getPercentageComplete())
            }
            else {
                progressBarContainer.isHidden = true
                paddingView.isHidden = true
            }
        }
        else {
            // TODO: fix issue where right label description cannot be ""
            self.setRightLabel(description: " ")
            setColorMode(completed: true)

            if !hasProgressBar {
                progressBarContainer.isHidden = true
                paddingView.isHidden = true
            }
        }
    }
    
    override func layoutSubviews() {
        DispatchQueue.main.async {
            var compBarThickness = self.frame.height * 2 / 9
            if compBarThickness > 16 {
                compBarThickness = 16
            }
            else if compBarThickness < 10 {
                compBarThickness = 10
            }
            
            self.progressBarContainer.cornerRadius = compBarThickness / 2
            self.linearProgressBar.barThickness = compBarThickness
            
            var viewHeight = self.frame.height
            if viewHeight > 65 {
                viewHeight = 65
            }
            else if viewHeight < 45 {
                viewHeight = 45
            }
            
            self.shadowedRoundedView.cornerRadius = viewHeight / 4
            self.roundedView.cornerRadius = viewHeight / 4
            
            let bigFontSize = compBarThickness + 7
            let smallFontSize = compBarThickness + 3
            
            self.leftLabel.font = UIFont(name: self.leftLabel.font.fontName, size: bigFontSize)
            self.rightLabel.font = UIFont(name: self.rightLabel.font.fontName, size: smallFontSize)
        }
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
