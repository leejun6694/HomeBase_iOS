//
//  FindEmailViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 25..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class FindEmailViewController: UIViewController {

    // MARK: Properties
    
    var name: String = ""
    var emails: [String] = []
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var emailTextView: UITextView!
    
    // MARK: Methods
    
    @IBAction private func signInButtonDidTapped(_ sender: UIButton) {
        if let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            
            UIApplication.shared.keyWindow?.rootViewController = loginViewController
        }
    }
    
    @IBAction func forgotPasswordButtonDidTapped(_ sender: UIButton) {
        if let forgotPasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController {
            
            self.navigationController?.pushViewController(forgotPasswordViewController, animated: true)
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "\(name)님의 등록 이메일은"
        emailTextView.isScrollEnabled = false
        for (index, email) in emails.enumerated() {
            if (index + 1) == emails.count {
                emailTextView.text.append("\(email)")
            } else {
                emailTextView.text.append("\(email)" + "\n")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emailTextView.isScrollEnabled = true
    }
}
