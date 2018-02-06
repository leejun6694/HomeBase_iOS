//
//  PersonalViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 6..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth

class PersonalViewController: UIViewController {
    @IBAction func signOutButtonDidTapped(_ sender: UIButton) {
        if let user = Auth.auth().currentUser {
            do {
                print("sign out: \(user.email ?? "default")")
                try Auth.auth().signOut()
                
                let storyBoard = UIStoryboard(name: "Start", bundle: nil)
                let signInViewController = storyBoard.instantiateInitialViewController()
                
                UIApplication.shared.keyWindow?.rootViewController = signInViewController
            } catch {
                print(error)
            }
        }
    }
}
