//
//  QuickCompleteFoodVCViewController.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class QuickCompleteFoodVC: SwipeDownCloseViewController {

    @IBOutlet weak var Rank1Item: RoundCornersUIView!
    @IBOutlet weak var Rank2Item: RoundCornersUIView!
    @IBOutlet weak var Rank3Item: RoundCornersUIView!
    @IBOutlet weak var Rank4Item: RoundCornersUIView!
    @IBOutlet weak var Rank5Item: RoundCornersUIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Rank1Item.isUserInteractionEnabled = true
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(Rank1ItemPressed(tapGestureRecognizer: )))
        Rank1Item.addGestureRecognizer(tapGesture1)
        
        Rank2Item.isUserInteractionEnabled = true
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(Rank2ItemPressed(tapGestureRecognizer: )))
        Rank2Item.addGestureRecognizer(tapGesture2)
        
        Rank3Item.isUserInteractionEnabled = true
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(Rank3ItemPressed(tapGestureRecognizer: )))
        Rank3Item.addGestureRecognizer(tapGesture3)
        
        Rank4Item.isUserInteractionEnabled = true
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(Rank4ItemPressed(tapGestureRecognizer: )))
        Rank4Item.addGestureRecognizer(tapGesture4)
        
        Rank5Item.isUserInteractionEnabled = true
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(Rank5ItemPressed(tapGestureRecognizer: )))
        Rank5Item.addGestureRecognizer(tapGesture5)
        
    }
    
    @objc private func Rank1ItemPressed(tapGestureRecognizer: UITapGestureRecognizer){
        WriteFoodTrackingData().setRating(amount: 1)
        dismiss()
    }
    
    @objc private func Rank2ItemPressed(tapGestureRecognizer: UITapGestureRecognizer){
        WriteFoodTrackingData().setRating(amount: 2)
        dismiss()
    }
    
    @objc private func Rank3ItemPressed(tapGestureRecognizer: UITapGestureRecognizer){
        WriteFoodTrackingData().setRating(amount: 3)
        dismiss()
    }
    
    @objc private func Rank4ItemPressed(tapGestureRecognizer: UITapGestureRecognizer){
        WriteFoodTrackingData().setRating(amount: 4)
        dismiss()
    }
    
    @objc private func Rank5ItemPressed(tapGestureRecognizer: UITapGestureRecognizer){
        WriteFoodTrackingData().setRating(amount: 5)
        dismiss()
    }

}
