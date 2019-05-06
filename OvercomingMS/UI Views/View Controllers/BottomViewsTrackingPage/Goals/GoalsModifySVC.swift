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
    
    @IBOutlet weak var backButton: BackConfirmButtonsSVC!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var header: TitleDescriptionHeaderSVC!
    @IBOutlet weak var currentGoalLabel: UILabel!
    @IBOutlet weak var goalUnitLabel: UILabel!
    @IBOutlet weak var goalContainer: UIView!
    @IBOutlet weak var omsRecommendedGoal: UILabel!
    
    let imageNames = ["Sad", "Meh", "Happy", "Excited"]
    
    var low = 1
    var high = 120
    var inc = 1
    var goal: Int = 1
    var Module: Modules = .Exercise
    
    private var items = [Int]()
    private var currentPage: Int = 0
    
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
    
    convenience init(low: Int, high: Int) {
        self.init()
        
        self.low = low
        self.high = high
    }
    
    override func customSetup() {
        
        backButton.leftButtonAction = backPressed
        backButton.rightButtonAction = confirmPressed
        
        setupLayout()
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "GoalsPickerCell", bundle: nil), forCellWithReuseIdentifier: "GoalsPickerCell")
        
    }
    
    func setupLayout() {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.fixed(spacing: -5)
        
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    override func initialize(parentVC: SlidingStackVC) {
        super.initialize(parentVC: parentVC)
        
        for i in stride(from: low, to: high + 1, by: inc) {
            items.append(i)
        }
    }
    
    override func reload() {
        currentPage = items.index(of: goal)!
        collectionView.scrollToItem(at: IndexPath(item: currentPage, section: 0), at: .centeredHorizontally, animated: false)
    }
    
    func backPressed() {
        let cancelPage = ConfirmationFactory.GoalsConfirmation()
        cancelPage.methodToRunOnConfirm = {}
        cancelPage.resetToDefault = true
        parentVC.pushSubView(newSubView: cancelPage)
    }
    
    func confirmPressed(){
        switch Module {
        case .Food:
            ProgressBarConfig.foodRatingGoal = items[currentPage]
            break
        case .Omega3:
            ProgressBarConfig.omega3Goal = items[currentPage]
            break
        case .VitaminD:
            ProgressBarConfig.vitaminDGoal = items[currentPage]
            break
        case .Exercise:
            ProgressBarConfig.exerciseGoal = items[currentPage]
        break
        case .Meditation:
            ProgressBarConfig.meditationGoal = items[currentPage]
            break
        default:
            break
        }
        parentVC.resetToDefaultView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GoalsPickerCell", for: indexPath) as! GoalsPickerCell
        myCell.setLabelText(String(items[indexPath.row]))
        return myCell
    }
    
    func setImageViewGoal(index: Int) {
        for subUIView in goalContainer.subviews as [UIView] {
            subUIView.removeFromSuperview()
        }
        let imageView = UIImageView(image: UIImage(named: imageNames[index]))
        goalContainer.addSubview(imageView)
        constrain(imageView, goalContainer) { (view, superView) in
            view.top == superView.top
            view.bottom == superView.bottom
            view.centerX == superView.centerX
            view.height == view.width
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        if (Module == .Food) {
            goalUnitLabel.text = ProgressBarConfig.foodDescriptions[currentPage + 1]
            setImageViewGoal(index: currentPage)
        }
        else {
            currentGoalLabel.text = String(items[currentPage])
        }
    }
    
}
