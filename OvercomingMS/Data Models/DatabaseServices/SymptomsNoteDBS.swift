//
//  SymptomsNoteDBS.swift
//  OvercomingMS
//
//  Created by Cassandra Li on 2/28/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import Foundation
import RealmSwift

class SymptomsNoteDBS {
    
    let realm = try! Realm()
    var day : TrackingDayDBT {
        get {
            return TrackingModulesDBS().getTrackingDay(date: globalCurrentDate)
        }
    }
    
    func addNote(note: String, symptomsRating: Int, dateCreated: Date) {
        do {
            try realm.write() {
                let item = SymptomsNoteDBT()
                item.Note = note
                item.DateCreated = dateCreated
                item.SymptomsRating = symptomsRating
                day.symptomsNoteDT.append(item)
            }
        } catch {
            print("Error updating Symptom Notes : \(error)" )
        }
        
    }
    
    func getTodaysNotes() -> List<SymptomsNoteDBT>? {
        return day.symptomsNoteDT
    }
    
    
    func deleteNote(item: SymptomsNoteDBT) {
        do {
            try realm.write() {
                realm.delete(item)
            }
        } catch {
            print("Error update Symptom Notes: \(error)")
        }
    }
    
    func editNote(oldItem: SymptomsNoteDBT, newItem: SymptomsNoteDBT) {
        do {
            try realm.write() {
                oldItem.Note = newItem.Note
                oldItem.DateCreated = newItem.DateCreated
                oldItem.SymptomsRating = newItem.SymptomsRating
            }
        } catch {
            print("Error update Symptom Notes: \(error)")
        }
    }
    
}
