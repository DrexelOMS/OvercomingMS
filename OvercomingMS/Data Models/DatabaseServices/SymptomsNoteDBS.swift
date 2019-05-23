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
            return TrackingModulesDBS(editingDate: globalCurrentDate).getTrackingDay()
        }
    }
    
    func addNote(note: String, symptomsRating: Int, timeOfDay: Date, dateCreated: String) {
        do {
            try realm.safeWrite() {
                let item = SymptomsNoteDBT()
                item.Note = note
                item.TimeOfDay = timeOfDay
                item.DateCreated = dateCreated
                item.SymptomsRating = symptomsRating
                day.symptomsNoteDT.append(item)
            }
        } catch {
            print("Error updating Symptom Notes : \(error)" )
        }
        
    }
    
    func getTodaysNotes() -> [SymptomsNoteDBT] {
        let notes = day.symptomsNoteDT
        let sortedList = notes.sorted(by: { $0.TimeOfDay < $1.TimeOfDay })
        return sortedList
    }
    
    func getAllNotesSortedByDate() -> [SymptomsNoteDBT] {
        let results: Results<SymptomsNoteDBT> = realm.objects(SymptomsNoteDBT.self)
        let converted = results.reduce(List<SymptomsNoteDBT>()) { (list, element) -> List<SymptomsNoteDBT> in
            list.append(element)
            return list
        }
        let sortedList = converted.sorted(by: { OMSDateAccessor().greaterThanComparison(left: OMSDateAccessor.getFullDate(date: $0.DateCreated), right: OMSDateAccessor.getFullDate(date: $1.DateCreated)) })
        return sortedList
    }
    
    
    func deleteNote(item: SymptomsNoteDBT) {
        do {
            try realm.safeWrite() {
                realm.delete(item)
            }
        } catch {
            print("Error update Symptom Notes: \(error)")
        }
    }
    
    func editNote(oldItem: SymptomsNoteDBT, newItem: SymptomsNoteDBT) {
        do {
            try realm.safeWrite() {
                oldItem.Note = newItem.Note
                oldItem.TimeOfDay = newItem.TimeOfDay
                oldItem.SymptomsRating = newItem.SymptomsRating
            }
        } catch {
            print("Error update Symptom Notes: \(error)")
        }
    }
    
}
