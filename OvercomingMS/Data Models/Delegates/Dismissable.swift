//
//  Dismissable.swift
//  OvercomingMS
//
//  Created by Vincent Finn on 2/1/19.
//  Copyright © 2019 DrexelOMS. All rights reserved.
//

import UIKit

protocol DismissalDelegate : class {
    func finishedShowing(viewController: UIViewController)
}

protocol Dismissable : class {
    var dismissalDelegate : DismissalDelegate? {get set}
}
