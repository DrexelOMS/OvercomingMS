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
    
    let nibName = "TrackingProgressBar"
    var contentView: UIView?
    
    weak var delegate : TrackingProgressBarDelegate?
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var leftContainerView: UIView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var linearProgressBar: LinearProgressBar!
    
    @IBAction func checkButtonPressed(_ sender: UIButton) {
        delegate?.didPressCheckButton(self)
    }
    
    var cornerRadius : CGFloat = 25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        guard let view = loadViewFromNib() else { return }
        
        view.frame = self.bounds
        
        //Custom View Modifications
        mainView.layer.cornerRadius = cornerRadius;
        mainView.layer.masksToBounds = true;
        
        leftContainerView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(leftContainerPressed(tapGestureRecognizer: )))
        leftContainerView.addGestureRecognizer(tapGesture)
        
        self.addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    @objc func leftContainerPressed(tapGestureRecognizer: UITapGestureRecognizer){        
        delegate?.didPressLeftContainer(self)
    }
    
}
