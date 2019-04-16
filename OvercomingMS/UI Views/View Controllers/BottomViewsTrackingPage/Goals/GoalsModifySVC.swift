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
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items = ["1", "2", "3", "4", "5"]
    
    override func customSetup() {
        backButton.backButtonAction = backPressed
        
        setupLayout()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "testCell", bundle: nil), forCellWithReuseIdentifier: "testCell")
    }
    
    func setupLayout() {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
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
