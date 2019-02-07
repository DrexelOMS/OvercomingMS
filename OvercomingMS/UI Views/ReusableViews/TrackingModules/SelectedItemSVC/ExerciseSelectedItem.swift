//
//  ExerciseSelectedItem.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/7/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import RealmSwift

class ExerciseSelectedItemSVC : SelectedItemSVC {
    
    var exerciseItem : ExerciseHistoryDBT!
    {
        didSet {
            print(exerciseItem)
        }
    }
    
    override func customSetup() {
        super.customSetup()
    }
    
    override func updateColors() {
        //Update color themes
    }
}
