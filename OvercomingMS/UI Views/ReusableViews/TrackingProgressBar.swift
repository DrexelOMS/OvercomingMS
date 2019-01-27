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
class TrackingProgressBar: UIView {
    
    public var nibName: String { return "TrackingProgressBar" }
    private var contentView: UIView?
    
    weak var delegate : TrackingProgressBarDelegate?
    
    @IBOutlet internal weak var leftContainerView: UIView!
    @IBOutlet internal weak var leftLabel: UILabel!
    @IBOutlet internal weak var rightLabel: UILabel!
    @IBOutlet internal weak var linearProgressBar: LinearProgressBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        guard let view = loadViewFromNib() else { return }
        
        view.frame = self.bounds
        
        //Custom View Modifications
        
        leftContainerView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(leftContainerPressed(tapGestureRecognizer: )))
        leftContainerView.addGestureRecognizer(tapGesture)
        
        self.addSubview(view)
        contentView = view
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @objc private func leftContainerPressed(tapGestureRecognizer: UITapGestureRecognizer){
        delegate?.didPressLeftContainer(self)
    }
    
    
    /**
     Sets the Progress Bar to the given value *(0-100)
     */
    func incremementProgressValue(value : Float){
        linearProgressBar.progressValue += CGFloat(value);
    }
    
    func setProgressValue(value : Float){
        linearProgressBar.progressValue = CGFloat(value);
    }
    
    func getProgressValue() -> Float{
        return Float(linearProgressBar.progressValue)
    }
    
    @IBAction private func checkButtonPressed(_ sender: UIButton) {
        delegate?.didPressCheckButton(self)
    }
    
}
