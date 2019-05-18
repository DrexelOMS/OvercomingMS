//
//  LabelExtension.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 5/18/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

extension UILabel {
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if String(font.fontName).lowercased().contains("quicksand") {
            kerning = -1
        }
    }
}
