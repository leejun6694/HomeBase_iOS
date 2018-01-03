//
//  PersonalViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 2..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class PersonalViewController: UIViewController {
    
    // MARK: Methods (tmp)
    
    @IBAction func signoutButtonDidTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            
            if FBSDKAccessToken.current() != nil {
                FBSDKLoginManager().logOut()
            }
            
            let storyBoard = UIStoryboard(name: "Login", bundle: nil)
            let loginVC = storyBoard.instantiateViewController(
                withIdentifier: "LoginViewController")

            UIApplication.shared.keyWindow?.rootViewController = loginVC
        } catch {
            print("sign out error: \(error)")
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
