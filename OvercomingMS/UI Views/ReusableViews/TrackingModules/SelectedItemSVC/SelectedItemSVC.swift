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
}
