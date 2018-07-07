//
//  PersonalTableViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 21..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseStorage

class PersonalTableViewController: UITableViewController {

    // MARK: Properties
    
    let headerView = PersonalHeaderView()
    let recordView = PersonalRecordView()
    
    var playerPhoto = #imageLiteral(resourceName: "personal_default")
    
    // MARK: Methods
    
    private func fetchPlayerData() {
        if let mainTabBarController = self.tabBarController as? MainTabBarController {
            headerView.playerData = mainTabBarController.playerData
            recordView.playerData = mainTabBarController.playerData
            
            if mainTabBarController.playerData.playerPhoto != "default" {
                let storageRef = Storage.storage().reference()
                let playerPhotoRef = storageRef.child(mainTabBarController.playerData.playerPhoto)
                
                playerPhotoRef.getData(maxSize: 4 * 1024 * 1024) {
                    (playerPhotoData, error) in
                    
                    self.playerPhoto = UIImage(data: playerPhotoData!) ?? #imageLiteral(resourceName: "personal_default")
                    self.headerView.playerPhoto = self.playerPhoto
                }
            }
        }
    }
    
    @objc private func settingButtonDidTapped(_ sender: UIButton) {
        guard let personalSettingViewController =
            self.storyboard?.instantiateViewController(
                withIdentifier: "PersonalSettingViewController")
                as? PersonalSettingViewController else { return }
        
        if let mainTabBarController = self.tabBarController as? MainTabBarController {
            personalSettingViewController.userData = mainTabBarController.userData
            personalSettingViewController.playerData = mainTabBarController.playerData
        }
        
        personalSettingViewController.playerPhoto = playerPhoto
        
        self.present(personalSettingViewController, animated: true, completion: nil)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPlayerData()
        
        self.view.backgroundColor = HBColor.lightGray
        self.tableView.bounces = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = self.navigationController {
            navigationController.hidesBarsOnSwipe = true
        }
        
        fetchPlayerData()
        self.tableView.reloadData()
        
        headerView.reloadGraph()
    }
}

extension PersonalTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            headerView.settingButton.addTarget(
                self,
                action: #selector(settingButtonDidTapped(_:)),
                for: .touchUpInside)
            return headerView
        case 1: return recordView
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0: return CGFloat(self.view.frame.size.height * 567/736).rounded()
        case 1: return CGFloat(self.view.frame.size.height * 518/736).rounded()
        default: return 0.0
        }
    }
}
