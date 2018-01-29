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
        if let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            
            UIApplication.shared.keyWindow?.rootViewController = loginViewController
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
