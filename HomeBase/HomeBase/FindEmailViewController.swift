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
        guard let signInViewController =
            self.storyboard?.instantiateViewController(
                withIdentifier: "SignInViewController")
                as? SignInViewController else { return }
            
            UIApplication.shared.keyWindow?.rootViewController = signInViewController
    }
    
    @IBAction func forgotPasswordButtonDidTapped(_ sender: UIButton) {
        guard let forgotPasswordViewController =
            self.storyboard?.instantiateViewController(
                withIdentifier: "ForgotPasswordViewController")
                as? ForgotPasswordViewController else { return }
            
            self.navigationController?.pushViewController(
                forgotPasswordViewController,
                animated: true)
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
        self.navigationItem.backBarButtonItem =
            UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emailTextView.isScrollEnabled = true
    }
}
