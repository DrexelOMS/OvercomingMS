//
//  SeeMoreButtonSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/23/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit
import TOWebViewController

class SeeMoreButtonSVC : CustomView {
    
    override var nibName: String {
        get {
            return "SeeMoreButtonSVC"
        }
    }
    
    var parentVC: UIViewController!
    
    var url = "https://overcomingms.org"
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func customSetup() {
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(tapGestureRecognizer: )))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func buttonTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let webViewController = TOWebViewController(urlString: url)
        let navigation = UINavigationController.init(rootViewController: webViewController)
        
        parentVC.present(navigation, animated: true, completion: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            let rate = 1 - ((60 - self.frame.height)) / 22
            let fontSize = 12  + (4) * rate
            self.descriptionLabel.font = UIFont(name: self.descriptionLabel!.font.fontName, size: fontSize)
        }
    }
    
}
