//
//  HeaderSVC.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 3/6/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class HeaderSVC: CustomView {
    
    override var nibName: String {
        get {
            return "HeaderSVC"
        }
    }
    @IBOutlet weak var daysInARow: UILabel!
    @IBOutlet weak var perfectDaysLabel: UILabel!
    @IBOutlet weak var circlesLabel: UILabel!
    @IBOutlet weak var trackingLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var goalMessageStackView: UIStackView!
    @IBOutlet weak var mainView: BottomRoundCornersUIView!
    
    private var orignalSelectedTextColor = UIColor(rgb: 0x333333)
    private var orignalOffTextColor = UIColor(rgb: 0x959595)
    private var contrastSelectedTextColor = UIColor.white
    private var contrastOffTextColor = UIColor(rgb: 0xDDDDDD)
    
    enum SelectedMenuItem {case Tracking, Circles, History}
    private var currentMenuItem: SelectedMenuItem = .Tracking
    var coloredMode: Bool = false
    
    let messageLabel = UILabel()
    
    override func customSetup() {
        //displayTrackingMessage(colorTheme: UIColor.blue, message: "test")
    }
    
    func setLabelColors(colored: Bool = false) {
        coloredMode = colored
        
        var mainColor = orignalSelectedTextColor
        var offColor = orignalOffTextColor
        if colored {
            mainColor = contrastSelectedTextColor
            offColor = contrastOffTextColor
        }
        
        switch currentMenuItem {
        case .Tracking:
            trackingLabel.textColor = mainColor
            circlesLabel.textColor = offColor
            historyLabel.textColor = offColor
            break
        case .Circles:
            trackingLabel.textColor = offColor
            circlesLabel.textColor = mainColor
            historyLabel.textColor = offColor
            break
        case .History:
            trackingLabel.textColor = offColor
            circlesLabel.textColor = offColor
            historyLabel.textColor = mainColor
            break
        }
    }
    
    func displayTrackingMessage(colorTheme: UIColor, message: String) {
        
        stopRestoreThread()
        
        messageLabel.text = message
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = .center
        
        mainView.fillColor = colorTheme
        
        setLabelColors(colored: true)
        
        daysInARow.isHidden = true
        perfectDaysLabel.isHidden = true
        goalMessageStackView.addArrangedSubview(messageLabel)
    }
    
    weak var messageUpdateThread: Timer?
    
    func startRestoreThread() {
        messageUpdateThread = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.restore), userInfo: nil, repeats: false)
    }
    
    func stopRestoreThread() {
        messageUpdateThread?.invalidate()
    }
    
    @objc func restore() {
        mainView.fillColor = UIColor.white
        
        setLabelColors()
        
        messageLabel.removeFromSuperview()
        daysInARow.isHidden = false
        perfectDaysLabel.isHidden = false
    }
    
    // if appropriate, make sure to stop your timer in `deinit`
    
    deinit {
        stopRestoreThread()
        restore()
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension Notification.Name {
    static let didCompleteModule = Notification.Name("didReceiveData")
}
