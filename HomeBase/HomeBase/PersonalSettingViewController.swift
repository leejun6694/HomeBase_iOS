//
//  PersonalSettingViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 25..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth

class PersonalSettingViewController: UIViewController {
    
    // MARK: Properties
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "설정"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    // MARK: Methods
    
    @IBAction func signOutButtonDidTapped(_ sender: UIButton) {
        if let user = Auth.auth().currentUser {
            do {
                print("sign out: \(user.email ?? "default")")
                try Auth.auth().signOut()
                
                let storyBoard = UIStoryboard(name: "Start", bundle: nil)
                let signInViewController = storyBoard.instantiateInitialViewController()
                
                UIApplication.shared.keyWindow?.rootViewController = signInViewController
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.backBarButtonItem =
            UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        self.view.backgroundColor = HBColor.lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = self.navigationController {
            navigationController.hidesBarsOnSwipe = false
        }
    }
}
