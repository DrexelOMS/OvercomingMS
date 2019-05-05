//
//  TypeTFIFactory.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/11/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class TypeTFIFactory {
    static func ExerciseTypeTFI() -> TypeTFI {
        return TypeTFI(
            choices: ["General Exercise", "Walk", "Run", "Cycle", "Swim", "Yoga / Pilates", "List", "Row", "Sports", "Other"],
            title: "Type")
    }
    
    static func Omega3TypeTFI() -> TypeTFI {
        return TypeTFI(
            choices: ["Flaxseed Oil", "Fish Oil", "Krill Oil", "Mussel Oil", "Mammalian Oil", "ALA Oil", "Algae Oil", "Other"],
            title: "Name")
    }
    
    static func VitaminDTypeTFI() -> TypeTFI {
        return TypeTFI(
            choices: ["Vitamin", "Other"],
            title: "Type")
    }
    
    static func MeditationTypeTFI() -> TypeTFI {
        return TypeTFI(choices: ["Silent", "Guided", "Other"], title: "Type")
    }
    
    static func SeverityTypeTFI() -> TypeTFI {
        return TypeTFI(
            choices: ["1", "2", "3", "4", "5"],
           title: "Severity")
    }
    
}
