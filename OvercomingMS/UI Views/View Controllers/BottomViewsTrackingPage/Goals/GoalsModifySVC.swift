//
//  GoalsModifySVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/12/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout
import Cartography

class GoalsModifySVC: SlidingAbstractSVC, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override var nibName: String {
        get {
            return "GoalsModifySVC"
        }
    }
    
    @IBOutlet weak var backButton: SquareButtonSVC!
    @IBOutlet weak var myView: UIView!
    
    var items = ["1", "2", "3"]
    
    override func customSetup() {
        backButton.backButtonAction = backPressed
        
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "testCell")
        
        let layout = UPCarouselFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        let myCollectionView:UICollectionView = UICollectionView(frame: self.myView.frame, collectionViewLayout: layout)
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(UINib(nibName: "testCell", bundle: nil), forCellWithReuseIdentifier: "testCell")
        myCollectionView.backgroundColor = UIColor.white
        self.myView.addSubview(myCollectionView)
        
        constrain(myCollectionView, myView) { (view, superView) in
            view.top == superView.top
            view.right == superView.right
            view.bottom == superView.bottom
            view.left == superView.left
        }
        
    }
    
    func backPressed() {
        parentVC.popSubView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "testCell", for: indexPath) as! testCell
        myCell.label.text = items[indexPath.row]
        return myCell
    }
    
}
