//
//  tmpViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 7..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

class tmpViewController: UIViewController {
    
    // MARK: Methods (tmp)
    
    @IBAction func signOutButtonDidTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            
            if FBSDKAccessToken.current() != nil {
                FBSDKLoginManager().logOut()
            }
            
            let storyBoard = UIStoryboard(name: "Start", bundle: nil)
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

