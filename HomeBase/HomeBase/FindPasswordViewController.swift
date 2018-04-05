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
        guard let signInViewController =
            self.storyboard?.instantiateViewController(
                withIdentifier: "SignInViewController")
                as? SignInViewController else { return }
            
        UIApplication.shared.keyWindow?.rootViewController = signInViewController
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        nameLabel.text = "\(name)님의 이메일"
        emailLabel.text = email
    }
}
