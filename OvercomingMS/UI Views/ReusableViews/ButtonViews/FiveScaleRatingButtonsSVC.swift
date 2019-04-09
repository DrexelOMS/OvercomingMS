//
//  FiveScaleRatingButtonsSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/2/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class FiveScaleRatingButtonsSVC : CustomView {
    @IBOutlet weak var rating5: RoundedBoxShadowsTemplate!
    @IBOutlet weak var rating4: RoundedBoxShadowsTemplate!
    @IBOutlet weak var rating3: RoundedBoxShadowsTemplate!
    @IBOutlet weak var rating2: RoundedBoxShadowsTemplate!
    @IBOutlet weak var rating1: RoundedBoxShadowsTemplate!
    
    override var nibName: String {
        get {
            return "FiveScaleRatingButtonsSVC"
        }
    }
    
    override func customSetup() {
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector (self.rank1Click(_:)))
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector (self.rank2Click(_:)))
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector (self.rank3Click(_:)))
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector (self.rank4Click(_:)))
        let gesture5 = UITapGestureRecognizer(target: self, action: #selector (self.rank5Click(_:)))

        rating1.addGestureRecognizer(gesture1)
        rating2.addGestureRecognizer(gesture2)
        rating3.addGestureRecognizer(gesture3)
        rating4.addGestureRecognizer(gesture4)
        rating5.addGestureRecognizer(gesture5)
    }
    @objc func rank1Click(_ sender:UITapGestureRecognizer){
        FoodRatingDBS().setRating(amount: 1)
        print("test1")
    }
    @objc func rank2Click(_ sender:UITapGestureRecognizer){
        FoodRatingDBS().setRating(amount: 2)
        print("test2")
    }
    @objc func rank3Click(_ sender:UITapGestureRecognizer){
        FoodRatingDBS().setRating(amount: 3)
        print("test3")
    }
    @objc func rank4Click(_ sender:UITapGestureRecognizer){
        FoodRatingDBS().setRating(amount: 4)
        print("test4")
    }
    @objc func rank5Click(_ sender:UITapGestureRecognizer){
        FoodRatingDBS().setRating(amount: 5)
        print("test5")
    }
}
