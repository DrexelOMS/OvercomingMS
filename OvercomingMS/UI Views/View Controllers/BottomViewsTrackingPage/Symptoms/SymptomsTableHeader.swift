//
//  SymptomsTableHeader.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class SymptomsTableHeader: UITableViewHeaderFooterView {
    static let reuseIdentifer = "SymptomsTableHeader"
    let customLabel = UILabel.init()
    
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = DesignConstants.DEFAULT_BACKGROUND_COLOR
        
        customLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        customLabel.textAlignment = .center
        
        customLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(customLabel)
        
        let margins = contentView.layoutMarginsGuide
        customLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        customLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        customLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        customLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
