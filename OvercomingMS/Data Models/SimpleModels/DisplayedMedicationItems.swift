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
    
    var medicationsTracked: List<SavedMedicationDBT>
    var medicationsNotTracked: List<SavedMedicationDBT>
    
    init(trackedMeds: List<SavedMedicationDBT>, untrackedMeds: List<SavedMedicationDBT>){
        medicationsTracked = trackedMeds
        medicationsNotTracked = untrackedMeds
    }
    
    func hasUntrackedMeds() -> Bool {
        return medicationsNotTracked.count > 0
    }
    
}
