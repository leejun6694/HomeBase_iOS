//
//  FindPasswordViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 29..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class FindPasswordViewController: UIViewController {
    
    // MARK: Properties
    
    var name: String = ""
    var email: String = ""
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    
    // MARK: Methods
    
    @IBAction private func signInButtonDidTapped(_ sender: UIButton) {
        if let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            
            UIApplication.shared.keyWindow?.rootViewController = loginViewController
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        nameLabel.text = "\(name)님의 이메일"
        emailLabel.text = email
    }
}
