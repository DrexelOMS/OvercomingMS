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
        editButton = EditCircleButton()
        editButton.buttonAction = editButtonPressed
        buttonStackView.addArrangedSubview(editButton)
        
        repeatButton = RepeatCircleButton()
        repeatButton.buttonAction = repeatButtonPressed
        buttonStackView.addArrangedSubview(repeatButton)
        
        deleteButton = DeleteCircleButton()
        deleteButton.buttonAction = deleteButtonPressed
        buttonStackView.addArrangedSubview(deleteButton)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.backButtonAction = backButtonPressed
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
