//
//  SignUpCompleteViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 24..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpCompleteViewController: UIViewController {
    
    // MARK: Methods
    
    @IBAction func signInButtonDidTapped(_ sender: UIButton) {       
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
