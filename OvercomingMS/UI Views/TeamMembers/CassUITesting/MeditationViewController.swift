//
//  File.swift
//  OvercomingMS
//
//  Created by Cassandra Li on 1/28/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit



class MeditationViewController: UIViewController {

    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func AddButton(_ sender: Any) {
        print("added!")
        performSegue(withIdentifier: "GoToAddScreen", sender: self)

    }
    
    @IBAction func BackAdd(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func TimerButton(_ sender: Any) {
        print("timer")
        performSegue(withIdentifier: "GoToTimerScreen", sender: self)
    }
    
    @IBAction func BackTimer(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func GuidedButton(_ sender: Any) {
        print("Guided")
        performSegue(withIdentifier: "GoToGuidedScreen", sender: self)
    }
    
    @IBAction func BackGuided(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
