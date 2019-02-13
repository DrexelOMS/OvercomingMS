//
//  ModifyAbstractSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/5/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import Cartography

class ModifyAbstractSVC : SlidingAbstractSVC, DateTimeTFIDelegate {
    
    func onDateTimeTFIDone() {
        print(dateTimeTFI.selectedStartTime)
    }
    
    @IBOutlet weak var textInputStackView: UIStackView!
    
    override var nibName: String {
        get {
            return "ModifyAbstractSVC"
        }
    }
    
    var choices : [String] {
        get {
            fatalError("Override choices")
        }
    }
    
    var tempSelectedType : String?
    var selectedType : String?
    var selectedStartTime : Date?
    var selectedLength : Int? // In minutes
    
    //TODO: replace with pickers
    @IBOutlet weak var typeTextField: UITextField!
    var dateTimeTFI = DateTimeTFI()
    @IBOutlet weak var minutesTextField: UITextField!
    @IBOutlet weak var backConfirmButtons: BackConfirmButtonSVC!
    
    override func customSetup() {
        //set the initial text and start time of the textField
        //selectedStartTime = Date()
        //timeTextField.text = OMSDateAccessor.getDateTime(date: Date())
        
        //typeTextField.delegate = self
        dateTimeTFI.delegate = self
        dateTimeTFI.parentVC = parentVC
        //minutesTextField.delegate = self
        textInputStackView.addArrangedSubview(dateTimeTFI)
        textInputStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        backConfirmButtons.leftButtonAction = BackPressed
        backConfirmButtons.rightButtonAction = ConfirmPressed
    
    }
    
    //delegate method of onTextFieldDatePickerDone() { textFieldDatePicker.getDate }
    
    override func updateColors() {
        print("remember to update colors")
    }
    
    func BackPressed() {
        parentVC.popSubView()
    }
    
    func ConfirmPressed() {
        fatalError("Override Confirm Pressed")
    }
    
    //MARK: Alternative picker method
   
//    let typePicker = UIPickerView()
//    let lengthPicker = UIDatePicker()
//    
//    //MARK: TypePicker
//    
//    func showTypePicker(){
//        //Formate Date
//        typePicker.delegate = self
//        typePicker.dataSource = self
//        if let type = selectedType {
//            typePicker.selectRow(choices.firstIndex(of: type) ?? 0, inComponent: 0, animated: false)
//        }
//        
//        //ToolBar
//        let toolbar = UIToolbar();
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTypePicker));
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker));
//        
//        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
//        
//        typeTextField.inputAccessoryView = toolbar
//        typeTextField.inputView = typePicker
//        
//    }
//    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return choices.count
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return choices[row]
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        tempSelectedType = choices[row]
//    }
//    
//    //MARK: LengthPicker
//    
//    func showLengthPicker(){
//        //Formate Date
//        lengthPicker.datePickerMode = .countDownTimer
//        lengthPicker.countDownDuration = getTimeInterval(fromMinutes: selectedLength ?? 0)
//        
//        //ToolBar
//        let toolbar = UIToolbar();
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneLengthPicker));
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker));
//        
//        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
//        
//        minutesTextField.inputAccessoryView = toolbar
//        minutesTextField.inputView = lengthPicker
//        
//    }
//    
//    //MARK: Done Picker buttons
//    
//    @objc func doneTypePicker(){
//        if let type = tempSelectedType {
//            self.selectedType = type
//            typeTextField.text = type
//        }
//        parentVC.view.endEditing(true)
//    }
//
//    @objc func doneLengthPicker(){
//        self.selectedLength = getMinutes(fromInterval: lengthPicker.countDownDuration)
//        print(getMinutes(fromInterval: lengthPicker.countDownDuration))
//        minutesTextField.text = "\(getMinutes(fromInterval: lengthPicker.countDownDuration)) .min"
//        parentVC.view.endEditing(true)
//    }
//    
//    func getMinutes(fromInterval: TimeInterval) -> Int {
//        return Int(fromInterval / 60)
//    }
//    
//    func getTimeInterval(fromMinutes: Int) -> TimeInterval {
//        return TimeInterval(fromMinutes * 60)
//    }
//    
//    @objc func cancelPicker(){
//        parentVC.view.endEditing(true)
//    }
    
    
}

class ExerciseModifyAbstractSVC : ModifyAbstractSVC {
    
    let exerciseRoutines = ExerciseHistoryDBS()
    
    override var choices : [String] {
        get {
            return ["Run", "Lift", "Push Ups"]
        }
    }
    
}
