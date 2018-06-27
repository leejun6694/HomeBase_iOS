//
//  TeamSettingCheckViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 6. 27..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class TeamSettingCheckViewController: UIViewController {

    // MARK: Properties
    
    var teamData: HBTeam!
    var player: HBPlayer!
    
    var adminCondition = false
    var removeCondition = false
    
    @IBOutlet private var teamNameTextField: UITextField!
    @IBOutlet private var okButton: UIButton!
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
    // MARK: Methods
    
    @IBAction private func cancelButtonDidTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        
        performSegue(withIdentifier: "unwindToMemberViewSegue", sender: nil)
    }
    
    @objc private func okButtonDidTapped(_ sender: UIButton) {
        spinnerStartAnimating(spinner)
        
        guard let mainTabBarController =
            self.presentingViewController?.presentingViewController
                as? MainTabBarController else { return }
        
        if let currentUser = Auth.auth().currentUser {
            CloudFunction.getUserDataWith(currentUser) {
                (userData, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let userData = userData else { return }
                let databaseRef = Database.database().reference()
                let teamRef = databaseRef.child("teams").child(userData.teamCode)
                
                if self.adminCondition {
                    teamRef.updateChildValues(["admin": self.player.pid]) {
                        (error, ref) in
                        
                        self.teamData.admin = self.player.pid
                        mainTabBarController.teamData = self.teamData
                        
                        self.spinnerStopAnimating(self.spinner)
                        self.performSegue(withIdentifier: "unwindToTeamMainSegue", sender: nil)
                    }
                } else if self.removeCondition {
                    
                }
            }
        }
    }
    
    @objc private func textFieldConditionChecked() {
        let text = teamNameTextField.text
        
        if text == teamData.name {
            okButton.isEnabled = true
        } else {
            okButton.isEnabled = false
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear.withAlphaComponent(0.5)
        self.view.isOpaque = false
        
        teamNameTextField.addTarget(
            self,
            action: #selector(textFieldConditionChecked),
            for: .editingChanged)
        teamNameTextField.becomeFirstResponder()
        
        okButton.addTarget(
            self,
            action: #selector(okButtonDidTapped(_:)),
            for: .touchUpInside)
    }
}
