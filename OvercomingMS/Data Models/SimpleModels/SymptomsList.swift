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
    
    func getSections() -> [SymptomsSection] {
        var symptomsDays: [SymptomsSection] = []
        let sortedList = SymptomsNoteDBS().getAllNotesSortedByDate()
        var date = ""
        for note in sortedList {
            var noteDate = note.DateCreated
            
            if noteDate != date {
                symptomsDays.append(SymptomsSection(Date: noteDate, notes: [note]))
            }
            else {
                let index = symptomsDays.count - 1
                symptomsDays[index].notes.append(note)
            }
            date = noteDate
        }
        return symptomsDays
    }

}
