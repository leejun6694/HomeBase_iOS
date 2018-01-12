//
//  RegisterTeamChoiceViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 10..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class RegisterTeamChoiceViewController: UIViewController {

    // MARK: Methods
    
    @IBAction func createButtonDidTapped(_ sender: UIButton) {
        if let registerTeamCreateViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "RegisterTeamCreateViewController") as? RegisterTeamCreateViewController {
            
            self.navigationController?.pushViewController(registerTeamCreateViewController, animated: true)
        }
    }
    
    @IBAction func joinButtonDidTapped(_ sender: UIButton) {
        if let registerTeamJoinViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "RegisterTeamJoinViewController") as? RegisterTeamJoinViewController {
            
            self.navigationController?.pushViewController(registerTeamJoinViewController, animated: true)
        }
    }
    
    // MARK: Life Cycles
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = true
    }
}
