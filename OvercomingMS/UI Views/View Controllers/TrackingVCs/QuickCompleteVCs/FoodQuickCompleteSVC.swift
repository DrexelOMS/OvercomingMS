//
//  FoodQuickCompleteSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/3/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class FoodQuickCompleteSVC: SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "FoodQuickCompleteSVC"
        }
    }
    
    @IBOutlet weak var Rank1Item: RoundedBoxShadowsTemplate!
    @IBOutlet weak var Rank2Item: RoundedBoxShadowsTemplate!
    @IBOutlet weak var Rank3Item: RoundedBoxShadowsTemplate!
    @IBOutlet weak var Rank4Item: RoundedBoxShadowsTemplate!
    @IBOutlet weak var Rank5Item: RoundedBoxShadowsTemplate!
    
    override func customSetup() {
        
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
        FoodRatingDBS().setRating(amount: 1)
        parentVC.dismiss()
    }
    
    @objc private func Rank2ItemPressed(tapGestureRecognizer: UITapGestureRecognizer){
        FoodRatingDBS().setRating(amount: 2)
        parentVC.dismiss()
    }
    
    @objc private func Rank3ItemPressed(tapGestureRecognizer: UITapGestureRecognizer){
        FoodRatingDBS().setRating(amount: 3)
        parentVC.dismiss()
    }
    
    @objc private func Rank4ItemPressed(tapGestureRecognizer: UITapGestureRecognizer){
        FoodRatingDBS().setRating(amount: 4)
        parentVC.dismiss()
    }
    
    @objc private func Rank5ItemPressed(tapGestureRecognizer: UITapGestureRecognizer){
        FoodRatingDBS().setRating(amount: 5)
        parentVC.dismiss()
    }
    
}
