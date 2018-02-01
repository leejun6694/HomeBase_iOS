//
//  RegisterTeamCompleteCopyViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 2..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class RegisterTeamCompleteCopyViewController: UIViewController {

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sleep(1)
        self.dismiss(animated: false, completion: nil)
    }
}
