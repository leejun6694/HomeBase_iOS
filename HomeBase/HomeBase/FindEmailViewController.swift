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
    var email: String = ""
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    
    // MARK: Methods
    
    @IBAction func signInButtonDidTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "FindEmailToSignIn", sender: nil)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        nameLabel.text = "\(name)님의 등록 이메일은"
        emailLabel.text = email
    }
}
