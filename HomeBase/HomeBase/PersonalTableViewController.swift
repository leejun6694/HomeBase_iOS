//
//  PersonalTableViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 21..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class PersonalTableViewController: UITableViewController {

    // MARK: Properties
    
    let headerView = PersonalHeaderView()
    let recordView = PersonalRecordView()
    
    private lazy var settingButton: UIBarButtonItem = {
        let settingButton = UIBarButtonItem(
            image: #imageLiteral(resourceName: "settingIcon"),
            style: .plain,
            target: self,
            action: #selector(settingButtonDidTapped(_:)))

        return settingButton
    }()
    
    // MARK: Methods
    
    private func fetchPlayerData() {
        if let mainTabBarController = self.tabBarController as? MainTabBarController {
            headerView.playerData = mainTabBarController.playerData
            recordView.playerData = mainTabBarController.playerData
        }
    }
    
    @objc private func settingButtonDidTapped(_ sender: UIButton) {
        guard let personalSettingViewController =
            self.storyboard?.instantiateViewController(
                withIdentifier: "PersonalSettingViewController") as? PersonalSettingViewController else { return }
        
        self.navigationController?.pushViewController(
            personalSettingViewController, animated: true)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPlayerData()
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.barTintColor = HBColor.lightGray
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
        navigationItem.rightBarButtonItem = settingButton
        
        self.tableView.bounces = false
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
        case 0: return headerView
        case 1: return recordView
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0: return CGFloat(self.view.frame.size.height * 527/736).rounded()
        case 1: return CGFloat(self.view.frame.size.height * 518/736).rounded()
        default: return 0.0
        }
    }
}
