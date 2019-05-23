//
//  TrackingModuleVCFactory.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/11/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class TrackingModuleFactory {
    static func Omega3VC() -> TrackingModuleVC {
        return TrackingModuleVC(title: "Omega 3", trackingDBS: Omega3HistoryDBS(), mainViewToSet: Omega3MainSVC())
    }
    
    static func VitaminDVC() -> TrackingModuleVC {
        return TrackingModuleVC(title: "Vitamin D", trackingDBS: VitaminDHistoryDBS(), mainViewToSet: VitaminDMainSVC())
    }
    
    static func ExerciseVC() -> TrackingModuleVC {
        return TrackingModuleVC(title: "Exercise", trackingDBS: ExerciseHistoryDBS(), mainViewToSet: ExerciseMainSVC())
    }
    
    static func MeditationVC() -> TrackingModuleVC {
        return TrackingModuleVC(title: "Meditation", trackingDBS: MeditationHistoryDBS(), mainViewToSet: MeditationMainSVC())
    }
    
    static func MedicationVC() -> TrackingModuleVC {
        return TrackingModuleVC(title: "Medication", trackingDBS: SavedMedicationDBS(), mainViewToSet: MedicationMainSVC())
    }
}
