//
//  FinnTestingViewController.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

class FinnTestingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Open(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ExerciseStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ExerciseModuleVC") as! ExerciseModuleVC
        self.present(vc, animated: true, completion: nil)
    }

}
