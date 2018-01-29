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
    
    @IBAction func signInButtonDidTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "FindEmailToSignIn", sender: nil)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emailTextView.isScrollEnabled = true
    }
}
