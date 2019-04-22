//
//  SymptomsList.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/21/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class SymptomsList {
    
    //list of lists of symptom note DBTs sorted by date sorted by date
    var symptomsDays: [[SymptomsNoteDBT]] = []
    
    init(){
        let sortedList = SymptomsNoteDBS().getAllNotesSortedByDate()
        var date = ""
        for note in sortedList {
            let noteDate = note.DateCreated

            if noteDate != date {
                symptomsDays.append([])
            }
            date = noteDate
            let index = symptomsDays.count - 1
            
            symptomsDays[index].append(note)
        }
    }
    
    func getNotesForIndex(index: Int) -> [SymptomsNoteDBT] {
        return symptomsDays[index]
    }
    
    func getCount() -> Int {
        return symptomsDays.count
    }
    
    func getTitleForIndex(index: Int) -> String {
        return symptomsDays[index][0].DateCreated
    }

}
