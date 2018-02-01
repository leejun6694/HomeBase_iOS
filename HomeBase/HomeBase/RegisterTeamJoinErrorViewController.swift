//
//  RegisterTeamJoinErrorViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 2..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class RegisterTeamJoinErrorViewController: UIViewController {

    // MARK: Methods
    
    @IBAction func doneButtonDidTapped(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
    }
}
