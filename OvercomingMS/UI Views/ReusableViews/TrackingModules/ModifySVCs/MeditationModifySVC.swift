
import UIKit
import Cartography

class MeditationModifySVC : ModifyAbstractSVC {
    
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
    
    var typeTFI = TypeTFIFactory.MeditationTypeTFI()
    var dateTimeTFI = DateTimeTFI()
    var lengthTFI = LengthTFI()
    
    var editingMeditationItem : MeditationHistoryDBT!{
        didSet {
            selectedType = editingMeditationItem.MeditationType
            
            selectedStartTime = editingMeditationItem.StartTime
            
            selectedLength = editingMeditationItem.minutes
            
            titleLabel.text = "Confirm changes?"
        }
    }
    
    convenience init(type: String, startTime: Date, length: Int)
    {
        self.init()
        
        selectedType = type
        selectedStartTime = startTime
        selectedLength = length
    }
    
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
    
    override func ConfirmPressed() {
        
        if let type = selectedType, let startTime = selectedStartTime, let minutes = selectedLength {
            if minutes <= 0 {
                return;
            }
            
            let endTime = startTime.addingTimeInterval(TimeInterval(minutes * 60))
            
            let newItem = MeditationHistoryDBT()
            newItem.MeditationType = type
            newItem.StartTime = startTime
            newItem.EndTime = endTime
            
            if editingMeditationItem == nil {
                meditationHistory.addItem(item: newItem)
                
                parentVC.reload();
                parentVC.resetToDefaultView()
            }
            else {
                meditationHistory.updateExerciseItem(oldItem: editingMeditationItem, newItem: newItem)
                
                parentVC.reload();
                parentVC.popSubView()
            }
            
        }
        
    }

}
