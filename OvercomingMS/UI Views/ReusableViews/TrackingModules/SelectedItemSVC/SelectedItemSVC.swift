//
//  SelectedItemSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SelectedItemSVC : SlidingAbstractSVC {
    
    override var nibName: String {
        get {
            return "SelectedItemSVC"
        }
    }
    
    @IBOutlet weak var middleStackView: UIStackView!
    @IBOutlet weak var topSubLabel: UILabel!
    @IBOutlet weak var topMainLabel: UILabel!
    @IBOutlet weak var middleSubLabel: UILabel!
    @IBOutlet weak var middleMainLabel: UILabel!
    @IBOutlet weak var middleFrequencyLabel: UILabel!
    @IBOutlet weak var bottomSubLabel: UILabel!
    @IBOutlet weak var bottomMainLabel: UILabel!
    
    @IBOutlet weak var labelsStackView: UIStackView!
    @IBOutlet weak var buttonStackView: UIStackView!
    
    var editButton : CircleButtonSVC!
    var repeatButton : CircleButtonSVC!
    var deleteButton : CircleButtonSVC!
    
    @IBOutlet weak var backButton: SquareButtonSVC!
    
    override func customSetup() {
        middleFrequencyLabel.isHidden = true
        
        editButton = CircleButtonFactory.EditButton()
        editButton.buttonAction = editButtonPressed
        buttonStackView.addArrangedSubview(editButton)
        
        repeatButton = CircleButtonFactory.RepeatButton()
        repeatButton.buttonAction = repeatButtonPressed
        buttonStackView.addArrangedSubview(repeatButton)
        
        deleteButton = CircleButtonFactory.DeleteButton()
        deleteButton.buttonAction = deleteButtonPressed
        buttonStackView.addArrangedSubview(deleteButton)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.backButtonAction = backButtonPressed
    }
    
    override func updateColors() {
        backButton.colorTheme = parentVC.theme
    }
    
    private func backButtonPressed() {
        parentVC.popSubView()
    }
    
    func editButtonPressed(){
        fatalError("Override Edit Button Pressed")
    }
    
    func repeatButtonPressed(){
        fatalError("Override Repeat Button Pressed")
    }
    
    func deleteButtonPressed(){
        fatalError("Override Delete Button Pressed")
    }
    
    override func didLayoutSubviews(){
        // minimum font size 80, max font size 120
        // minimum height = 72, max height = 150
        DispatchQueue.main.async {
            print(self.middleStackView.frame.height)
        }
        let rate = 1 - ((90 - middleStackView.frame.height)) / 20

        let bigFontSize = 24  + (10) * rate
        let smallFontSize = 18  + (8) * rate
        let miniFontSize = 14 + (6) * rate

        DispatchQueue.main.async {
            self.topMainLabel.font = UIFont(name: self.topMainLabel!.font.fontName, size: bigFontSize)
            self.topSubLabel.font = UIFont(name: self.topSubLabel!.font.fontName, size: smallFontSize)
            
            self.middleMainLabel.font = UIFont(name: self.middleMainLabel!.font.fontName, size: bigFontSize)
            self.middleSubLabel.font = UIFont(name: self.middleSubLabel!.font.fontName, size: smallFontSize)
            self.middleFrequencyLabel.font = UIFont(name: self.middleFrequencyLabel!.font.fontName, size: miniFontSize)
            
            self.bottomMainLabel.font = UIFont(name: self.bottomMainLabel!.font.fontName, size: bigFontSize)
            self.bottomSubLabel.font = UIFont(name: self.bottomSubLabel!.font.fontName, size: smallFontSize)
        }
    }
}
