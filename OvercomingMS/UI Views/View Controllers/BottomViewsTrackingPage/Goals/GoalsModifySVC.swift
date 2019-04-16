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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var currentGoalLabel: UILabel!
    @IBOutlet weak var goalUnitLabel: UILabel!
    
    var items = [String]()
    
    var currentPage: Int = 0
    var low = 1
    var high = 60
    var inc = 1
    
    var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
    
    override func customSetup() {
        backButton.backButtonAction = backPressed
        
        setupLayout()
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "GoalsPickerCell", bundle: nil), forCellWithReuseIdentifier: "GoalsPickerCell")
        
        for i in stride(from: low, to: high, by: inc) {
            items.append(String(i))
        }
    }
    
    func setupLayout() {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: 10)
        
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func backPressed() {
        parentVC.popSubView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoalsPickerCell", for: indexPath) as! GoalsPickerCell
        myCell.label.text = items[indexPath.row]
        return myCell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        currentGoalLabel.text = items[currentPage]
    }
    
    @IBAction func testPressed(_ sender: Any) {
        print(items[currentPage])
    }
    
}
