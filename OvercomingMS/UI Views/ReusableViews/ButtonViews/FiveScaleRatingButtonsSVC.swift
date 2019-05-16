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
    
    @IBOutlet weak var rating1Image: UIImageView!
    @IBOutlet weak var rating2Image: UIImageView!
    @IBOutlet weak var rating3Image: UIImageView!
    @IBOutlet weak var rating4Image: UIImageView!
    @IBOutlet weak var rating5Image: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    var colorTheme: UIColor = UIColor.brown
    
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
        
        reload()
    }
    
    func reload() {
        let rating = FoodRatingDBS().getRating()
        rating1.backgroundColor = UIColor.white
        rating1Image.image = UIImage(named: "Distressed")
        rating2.backgroundColor = UIColor.white
        rating2Image.image = UIImage(named: "Sad")
        rating3.backgroundColor = UIColor.white
        rating3Image.image = UIImage(named: "Meh")
        rating4.backgroundColor = UIColor.white
        rating4Image.image = UIImage(named: "Happy")
        rating5.backgroundColor = UIColor.white
        rating5Image.image = UIImage(named: "Excited")

        switch rating {
        case 1:
            rating1.backgroundColor = colorTheme
            rating1Image.image = UIImage(named: "Distressed_white")
            break
        case 2:
            rating2.backgroundColor = colorTheme
            rating2Image.image = UIImage(named: "Sad_white")
            break
        case 3:
            rating3.backgroundColor = colorTheme
            rating3Image.image = UIImage(named: "Meh_white")
            break
        case 4:
            rating4.backgroundColor = colorTheme
            rating4Image.image = UIImage(named: "Happy_white")
            break
        case 5:
            rating5.backgroundColor = colorTheme
            rating5Image.image = UIImage(named: "Excited_white")
            break
        default:
            break
            
        }
    }
    
    @objc func rank1Click(_ sender:UITapGestureRecognizer){
        FoodRatingDBS().setRating(amount: 1)
        reload()
    }
    @objc func rank2Click(_ sender:UITapGestureRecognizer){
        FoodRatingDBS().setRating(amount: 2)
        reload()
    }
    @objc func rank3Click(_ sender:UITapGestureRecognizer){
        FoodRatingDBS().setRating(amount: 3)
        reload()
    }
    @objc func rank4Click(_ sender:UITapGestureRecognizer){
        FoodRatingDBS().setRating(amount: 4)
        reload()
    }
    @objc func rank5Click(_ sender:UITapGestureRecognizer){
        FoodRatingDBS().setRating(amount: 5)
        reload()
    }
    
    override func layoutSubviews() {
        DispatchQueue.main.async {
            var rate = 1 - ((80 - self.mainView.frame.height)) / 14
            rate = rate > 1 ? 1 : (rate < 0 ? 0 : rate)
            
            let fontSize = 14  + (6) * rate
            let font  = UIFont(name: self.label1!.font.fontName, size: fontSize)
            self.label1.font = font
            self.label2.font = font
            self.label3.font = font
            self.label4.font = font
            self.label5.font = font
        }
    }
}
