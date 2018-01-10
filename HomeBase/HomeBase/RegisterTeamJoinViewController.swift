//
//  RegisterTeamJoinViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 10..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class RegisterTeamJoinViewController: UIViewController {
    
    // MARK: Methods
    
    @IBAction func doneButtonDidTapped(_ sender: UIButton) {
        if let registerUserInfoViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterUserInfoViewController") as? RegisterUserInfoViewController {
            
            self.navigationController?.pushViewController(registerUserInfoViewController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
}
