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
    
    @IBAction func signInButtonDidTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "UnwindToSignIn", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = Auth.auth().currentUser {
            do {
                print("sign out: \(user.email ?? "default")")
                try Auth.auth().signOut()
            } catch {
                print(error)
            }
        }
    }
}
