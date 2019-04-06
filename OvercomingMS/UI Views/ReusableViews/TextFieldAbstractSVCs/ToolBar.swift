//
//  ToolBar.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/6/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

protocol ToolBarDelegate {
    func donePressed()
    func cancelPressed()
}

class ToolBar {
    
    var delegate : ToolBarDelegate?
    
    func getToolBar(isDoneEnabled: Bool = true, isCancelEnabled: Bool = true) -> UIToolbar{
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        return toolbar
    }
    
    @objc private func donePressed() {
        delegate?.donePressed()
    }
    
    @objc private func cancelPressed() {
        delegate?.cancelPressed()
    }
    
}
