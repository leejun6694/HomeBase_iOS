//
//  RegisterTeamChoiceViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 10..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterTeamChoiceViewController: UIViewController {

    // MARK: Methods
    
    @IBAction private func createButtonDidTapped(_ sender: UIButton) {
        guard let registerTeamCreateViewController =
            self.storyboard?.instantiateViewController(
                withIdentifier: "RegisterTeamCreateViewController")
                as? RegisterTeamCreateViewController else { return }
            
        self.navigationController?.pushViewController(
            registerTeamCreateViewController,
            animated: true)
    }
    
    @IBAction private func joinButtonDidTapped(_ sender: UIButton) {
        guard let registerTeamJoinViewController =
            self.storyboard?.instantiateViewController(
                withIdentifier: "RegisterTeamJoinViewController")
                as? RegisterTeamJoinViewController else { return }
            
        self.navigationController?.pushViewController(
            registerTeamJoinViewController,
            animated: true)
    }
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = self.navigationController {
            navigationController.isNavigationBarHidden = true
            navigationController.navigationBar.barTintColor = HBColor.lightGray
        }
    }
}
