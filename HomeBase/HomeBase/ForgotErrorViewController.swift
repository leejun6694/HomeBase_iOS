//
//  ForgotErrorViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 29..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ForgotErrorViewController: UIViewController {

    // MARK: Methods
    
    @IBAction func doneButtonDidTapped(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func signUpButtonDidTapped(_ sender: UIButton) {
        guard let signUpViewController =
            self.storyboard?.instantiateViewController(
                withIdentifier: "SignUpViewController")
                as? SignUpViewController else { return }
            
        self.present(signUpViewController, animated: true, completion: nil)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
    }
}
