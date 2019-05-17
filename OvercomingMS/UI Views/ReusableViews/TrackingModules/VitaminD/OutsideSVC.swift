//
//  OutsideSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 4/4/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class OutsideSVC: SlidingAbstractSVC, UITableViewDelegate, UITableViewDataSource {
    
    override var nibName: String {
        get {
            return "OutsideSVC"
        }
    }
    
    let outsideDescriptions = ["Vitamin D is made by the body when the skin is exposed to the sun’s UVB rays.",
    "The UV index shows the intensity of UV rays from the sun. Check online to find the UV index forecast for where you are; the higher the index reading, the shorter the time you will need to spend in the sun",
    "If you live in a cooler climate, you are unlikely to be able to produce enough vitamin D in the winter months and will need to take supplements (5,000 – 10,000 IU vitamin D3 daily)",
    "The time needed to achieve the desired amount of vitamin D is dependent on the UV index locally. This may be achieved in just a few minutes at midday (e.g. 10 -15 mins when the UV index is 7 and your skin is mostly uncovered, if the UV index is 14 it would be half that time).",
    "Remember the UV forecast shows what exposure will be at 12 Midday, it will be lower in the morning and later in the afternoon. If you are going out at 10.00 am for example, you can spend a third longer in the sun without protection.",
    "If the weather is cloudy, you probably aren’t getting your required amount of vitamin D. Note: you also cannot get vitamin D through windows, as glass will absorb UVB rays.",
    "OMS suggests as close to full-body skin exposure as possible.  Clothing will prevent most UVB rays from reaching the skin. Exposing a smaller area of skin for longer doesn't work, because once a given patch of skin produces its daily dose of vitamin D, no more can be made that day.",
    "People with dark skin, such as those of African, people African-Caribbean or South-Asian origin, will need to spend longer in the sun to produce the same amount of vitamin D as someone with light skin.",
    "Even SPF 8 almost completely eliminates UVB rays from reaching the skin, thereby preventing vitamin D manufacture.  OMS advises that you expose the skin to sunlight before applying sunscreen.",
    "If the skin starts to become red or painful, then regardless of length of time, sunscreen should be applied immediately to prevent burning.  It has been shown that small, regular doses of sun exposure may actually be protective against skin cancers, but the skin should not be allowed to burn. The same principle applies to children."]
    let outsideImageNames = ["Exposure", "", "", "TimeSpent", "", "Weather", "Exposure", "Complexion", "", ""]
    
    let defaultCellName = "OutsideCell"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: SquareButtonSVC!
    
    override func customSetup() {
        backButton.backButtonAction = backButtonPressed
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: defaultCellName, bundle: nil), forCellReuseIdentifier: defaultCellName)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    func backButtonPressed() {
        parentVC.popSubView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outsideDescriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellName, for: indexPath) as! OutsideCell
        
        cell.label.text = outsideDescriptions[indexPath.row]
    
        if outsideImageNames[indexPath.row] == "" {
            cell.cellImage.isHidden = true
        }
        else {
            cell.cellImage.isHidden = false
            cell.cellImage.image = UIImage(named: outsideImageNames[indexPath.row])
        }
        
        return cell
    }
    
}
