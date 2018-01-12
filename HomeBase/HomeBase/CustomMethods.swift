//
//  CustomMethods.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 12..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: UIButton
    
    func buttonEnabled(_ button: UIButton) {
        button.alpha = 1.0
        button.isEnabled = true
    }
    
    func buttonDisabled(_ button: UIButton) {
        button.alpha = 0.5
        button.isEnabled = false
    }
}

