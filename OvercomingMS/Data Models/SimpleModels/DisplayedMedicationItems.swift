//
//  DisplayedMedicationItems.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class DisplayedMedicationItems{
    
    var medicationsTracked: [SavedMedicationDBT]
    var medicationsNotTracked: [SavedMedicationDBT]
    
    init(trackedMeds: List<SavedMedicationDBT>, untrackedMeds: List<SavedMedicationDBT>){
        let sortedTracked = trackedMeds.sorted(by: { $0.TimeOfDay < $1.TimeOfDay })
        medicationsTracked = sortedTracked
        let sortedUntracked = untrackedMeds.sorted(by: { $0.TimeOfDay < $1.TimeOfDay })
        medicationsNotTracked = sortedUntracked
    }
    
    func hasUntrackedMeds() -> Bool {
        return medicationsNotTracked.count > 0
    }
    
    func getTotalMedCount() -> Int{
        return medicationsTracked.count + medicationsNotTracked.count
    }
}
