
import UIKit
import Cartography

class MeditationAbstractSVC : ModifyAbstractSVC {
    let meditationHistory  = MeditationHistoryDBS()
    
    var selectedType : String? {
        get {
            return typeTFI.selectedType
        }
        set {
            typeTFI.selectedType = newValue
        }
    }
    var selectedStartTime : Date? {
        get {
            return dateTimeTFI.selectedStartTime
        }
        set {
            dateTimeTFI.selectedStartTime = newValue
        }
    }
    var selectedLength : Int?  { // In minutes
        get {
            return lengthTFI.selectedLength
        }
        set {
            lengthTFI.selectedLength = newValue
        }
    }
    
    var typeTFI = ExerciseTypeTFI()
    var dateTimeTFI = DateTimeTFI()
    var lengthTFI = LengthTFI()
    
    override func customSetup() {
        //set the initial text and start time of the textField
        selectedStartTime = Date()
        
        textInputStackView.addArrangedSubview(typeTFI)
        textInputStackView.addArrangedSubview(dateTimeTFI)
        textInputStackView.addArrangedSubview(lengthTFI)
        textInputStackView.translatesAutoresizingMaskIntoConstraints = false
        
        backConfirmButtons.leftButtonAction = BackPressed
        backConfirmButtons.rightButtonAction = ConfirmPressed
        
    }
    
    override func initialize(parentVC: TrackingModuleAbstractVC) {
        super.initialize(parentVC: parentVC)
        
    }
    
}
