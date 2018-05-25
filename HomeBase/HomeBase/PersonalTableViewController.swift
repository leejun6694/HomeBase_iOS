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
        
        self.tableView.contentInset.top = -UIApplication.shared.statusBarFrame.height
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
        case 0: return CGFloat(self.view.frame.size.height * 587/736).rounded()
        case 1: return CGFloat(self.view.frame.size.height * 518/736).rounded()
        default: return 0.0
        }
    }
}
