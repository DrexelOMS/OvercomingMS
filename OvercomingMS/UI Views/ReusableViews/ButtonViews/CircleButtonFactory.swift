//
//  CircleButtonFactory.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/11/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class CircleButtonFactory {
    
    static func AddButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "Add")!, label: "Add")
    }
    
    static func EditButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "Edit")!, label: "Edit")
    }
    
    static func CancelButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "Cancel")!, label: "Cancel")
    }
    
    static func DeleteButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "Delete")!, label: "Delete")
    }
    
    static func FinishButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "Finish")!, label: "Finish")
    }
    
    static func GuidedButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "Guided")!, label: "Guided")
    }
    
    static func OutsideButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "Outside")!, label: "Outside")
    }
    
    static func RecipesButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "Recipes")!, label: "Recipes")
    }
    
    static func SavedButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "Saved")!, label: "Saved")
    }
    
    static func ScanButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "Scan")!, label: "Scan")
    }
    
    static func SearchButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "Search")!, label: "Search")
    }
    
    static func SupplementButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "Supplement")!, label: "Supplement")
    }
    
    static func TimerButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "Timer")!, label: "Timer")
    }
    
    static func RepeatButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "Repeat")!, label: "Repeat")
    }
    
    static func AddMedicationButton() -> CircleButtonSVC {
        return CircleButtonSVC(image: UIImage(named: "MedAdd")!, label: "Add")
    }
    
}
