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
    
    let motivationalMessages = ["Great job!", "Great Work", "You Can Do It"]
    
    @IBOutlet weak var daysInARow: UILabel!
    @IBOutlet weak var perfectDaysLabel: UILabel!
    @IBOutlet weak var circlesLabel: UILabel!
    @IBOutlet weak var trackingLabel: UILabel!
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var goalMessageStackView: UIStackView!
    @IBOutlet weak var mainView: BottomRoundCornersUIView!
    
    @IBOutlet weak var circleImage: UIImageView!
    var originalSelectedTextColor = UIColor(rgb: 0x333333)
    var originalOffTextColor = UIColor(rgb: 0x959595)
    var contrastSelectedTextColor = UIColor.white
    var contrastOffTextColor = UIColor.white
    
    enum SelectedMenuItem {case Tracking, Circles, History}
    var currentMenuItem: SelectedMenuItem = .Tracking
    var coloredMode: Bool = false
    
    let messageLabel = UILabel()
    
    weak var messageUpdateThread: Timer?
    weak var motivationUpdateThread: Timer?
    
    override func customSetup() {
        //displayTrackingMessage(colorTheme: UIColor.blue, message: "test")
        daysInARow.text = "0 in a row!"
        perfectDaysLabel.text = "0 great days!"
        
        messageLabel.adjustsFontSizeToFitWidth = true
        messageLabel.font = UIFont(name:"Avenir-Medium", size: messageLabel.font.pointSize)
        startMotivationStartThread()
    }
    
    func setLabelColors(colored: Bool = false) {
        coloredMode = colored
        
        var mainColor = originalSelectedTextColor
        var offColor = originalOffTextColor
        if colored {
            mainColor = contrastSelectedTextColor
            offColor = contrastOffTextColor
            circleImage.image = UIImage(named: "circle-white")
            messageLabel.textColor = UIColor.white
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont(name:"Avenir-Heavy", size: messageLabel.font.pointSize)
        }
        else {
            circleImage.image = UIImage(named: "circle")
            messageLabel.font = UIFont(name:"Avenir-Medium", size: messageLabel.font.pointSize)
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
        
        self.mainView.fillColor = colorTheme
        self.setLabelColors(colored: true)
        
        showMessageLabel()
    }
    
    func displayPreviousDateMessage() {
        messageLabel.text = "You are editing a past day!"
        
        self.mainView.fillColor = UIColor.gray
        self.setLabelColors(colored: true)
            
        showMessageLabel()
    }
    
    func startRestoreThread() {
        messageUpdateThread = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.restore), userInfo: nil, repeats: false)
    }
    
    func stopRestoreThread() {
        messageUpdateThread?.invalidate()
        stopMotivationThread()
    }
    
    @objc func restore() {
        mainView.fillColor = UIColor.white
        
        setLabelColors()
        
        hideMessageLabel()
        
        startMotivationStartThread()
    }
    
    func startMotivationStartThread() {
        motivationUpdateThread?.invalidate()
        motivationUpdateThread = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.showMotivationMessage), userInfo: nil, repeats: false)
    }
    
    func startMotivationEndThread() {
        motivationUpdateThread?.invalidate()
        motivationUpdateThread = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.hideMotivationMessage), userInfo: nil, repeats: false)
    }
    
    @objc func showMotivationMessage() {
        messageLabel.textAlignment = .center
        let index = Int.random(in: 0 ... motivationalMessages.count - 1)
        messageLabel.text = motivationalMessages[index]
        messageLabel.textColor = UIColor.black

        showMessageLabel()
        
        startMotivationEndThread()
    }
    
    @objc func hideMotivationMessage() {
        hideMessageLabel()
        
        startMotivationStartThread()
    }
    
    func stopMotivationThread() {
        motivationUpdateThread?.invalidate()
    }
    
    private func hideMessageLabel() {
        daysInARow.isHidden = false
        perfectDaysLabel.isHidden = false
        messageLabel.removeFromSuperview()
    }
    
    private func showMessageLabel() {
        daysInARow.isHidden = true
        perfectDaysLabel.isHidden = true
        goalMessageStackView.addArrangedSubview(messageLabel)
    }
    
    // if appropriate, make sure to stop your timer in `deinit`
    
    deinit {
        stopRestoreThread()
        restore()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var rate = 1 - ((100 -  frame.height)) / 20
        rate = rate > 1 ? 1 : (rate < 0 ? 0 : rate)
        
        let bigFontSize = 20 + (6) * rate
        let fontSize = 16 + (6) * rate
        let smallSize = 14 + (6) * rate
        

        trackingLabel.font = UIFont(name: trackingLabel.font.fontName, size: bigFontSize)
        circlesLabel.font = UIFont(name: circlesLabel.font.fontName, size: fontSize)
        historyLabel.font = UIFont(name: historyLabel.font.fontName, size: fontSize)
        
        messageLabel.font = UIFont(name: daysInARow.font.fontName, size: smallSize)
        daysInARow.font = UIFont(name:daysInARow.font.fontName, size: smallSize)
        perfectDaysLabel.font = UIFont(name:perfectDaysLabel.font.fontName, size: smallSize)
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
    static let didTodaysDateChange = Notification.Name("didTodaysDateChange")
}
