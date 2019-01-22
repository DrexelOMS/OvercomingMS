//
//  StopwatchViewController.swift
//  OvercomingMS
//
//  Created by Chris on 1/22/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {

    var seconds = 0
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    @IBOutlet weak var StopwatchTime: UILabel!
    
    @IBAction func StartButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false{
            runTimer()
        }
    }
    
    @IBAction func PauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false{
            timer.invalidate()
            self.resumeTapped = true
        }
        else {
            runTimer()
            self.resumeTapped = false
        }
    }
    
    @IBAction func ResetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        seconds = 0
        StopwatchTime.text = timeString(time:TimeInterval(seconds))
        isTimerRunning = false
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func runTimer(){
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
            isTimerRunning = true
    }
    
    @objc func updateTimer(){
            seconds = (seconds + 1)
            StopwatchTime.text = timeString(time: TimeInterval(seconds))
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let mins = Int(time) / 60 % 60
        let secs = Int(time) % 60
        
        return String(format:"%02i:%02i:%02i", hours, mins, secs)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
