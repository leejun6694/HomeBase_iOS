//
//  SignInErrorViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 29..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class SignInErrorViewController: UIViewController {

    // MARK: Properties
    var errorText: String = ""
    
    @IBOutlet private var errorLabel: UILabel!
    
    // MARK: Methods
    
    @IBAction func doneButtonDidTapped(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
        
        errorLabel.text = errorText
    }
}
