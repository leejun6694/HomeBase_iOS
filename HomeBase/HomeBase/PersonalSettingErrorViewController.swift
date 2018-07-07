//
//  PersonalSettingErrorViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 7. 7..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class PersonalSettingErrorViewController: UIViewController {

    @IBAction func doneButtonDidTapped(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
    }
}
