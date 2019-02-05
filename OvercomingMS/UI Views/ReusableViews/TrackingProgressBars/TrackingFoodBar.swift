//
//  TrackingFoodBar.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 1/27/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

protocol TrackingFoodBarDelegate : class {
    func didPressCheckButton(_ sender: TrackingFoodBar)
    func didPressLeftContainer(_ sender: TrackingFoodBar)
}

class TrackingFoodBar: CustomView {

    override var nibName: String { return "TrackingFoodBar" }
    
    weak var delegate : TrackingFoodBarDelegate?
    
    @IBOutlet private weak var leftContainerView: UIView!
    @IBOutlet private weak var rightLabel: UILabel!
    
    override func customSetup() {
        leftContainerView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(leftContainerPressed(tapGestureRecognizer: )))
        leftContainerView.addGestureRecognizer(tapGesture)
    }
    
    func setDescription(description: String){
        rightLabel.text = description
    }
    
    @objc private func leftContainerPressed(tapGestureRecognizer: UITapGestureRecognizer){
        delegate?.didPressLeftContainer(self)
    }
    
    @IBAction private func checkButtonPressed(_ sender: UIButton) {
        delegate?.didPressCheckButton(self)
    }
    

}
