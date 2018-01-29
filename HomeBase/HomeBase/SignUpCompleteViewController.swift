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
        if let signInViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController {
            
            UIApplication.shared.keyWindow?.rootViewController = signInViewController
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
