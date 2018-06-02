//
//  TeamTableViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 6. 2..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class TeamTableViewController: UITableViewController {

    // MARK: Properties
    
    var teamData: HBTeam!
    var teamLogo: UIImage!
    
    private let teamInfoView = TeamInfoView()
    
    private lazy var settingButton: UIBarButtonItem = {
        let settingButton = UIBarButtonItem(
            image: #imageLiteral(resourceName: "settingIcon"),
            style: .plain,
            target: self,
            action: #selector(settingButtonDidTapped(_:)))
        
        return settingButton
    }()
    
    // MARK: Methods
    
    @objc private func settingButtonDidTapped(_ sender: UIButton) {
        
    }
    
    private func fetchTeamData() {
        if let mainTabBarController = self.tabBarController as? MainTabBarController {
            teamData = mainTabBarController.teamData
            teamLogo = mainTabBarController.teamLogo
            teamInfoView.teamData = teamData
            teamInfoView.teamLogo = teamLogo
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchTeamData()
        
        self.tableView.bounces = false
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.barTintColor = UIColor.clear
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController.hidesBarsOnSwipe = true
            
            self.tableView.contentInset.top =
                -(UIApplication.shared.statusBarFrame.height +
                    navigationController.navigationBar.frame.size.height)
        }
        
        navigationItem.rightBarButtonItem = settingButton
    }
}

extension TeamTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0: return teamInfoView
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0: return CGFloat(self.view.frame.size.height * 394/736).rounded()
        default: return 0.0
        }
    }
}
