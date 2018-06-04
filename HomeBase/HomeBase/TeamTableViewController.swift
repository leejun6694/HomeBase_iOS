//
//  TeamTableViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 6. 2..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class TeamTableViewController: UITableViewController {

    // MARK: Properties
    
    var teamData: HBTeam!
    var teamLogo: UIImage!
    var playerList = [HBPlayer]()
    
    private let teamInfoView = TeamInfoView()
    private let teamDataView = TeamDataView()
    
    private let cellReuseIdendifier = "playerListCell"
    
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
            
            self.playerList = teamData.members
        }
    }
    
    
    private func tableViewReloadData() {
        viewDisabled(self.view)
        self.navigationController?.view.isUserInteractionEnabled = false
        
        guard let currentUser = Auth.auth().currentUser else { return }
        CloudFunction.getUserDataWith(currentUser) {
            (user, error) in
            
            if let user = user {
                CloudFunction.getTeamDataWith(user.teamCode) {
                    (teamData, error) in
                    
                    if let teamData = teamData {
                        self.teamData = teamData
                        self.playerList = teamData.members
                        
                        self.tableView.reloadData()
                        self.viewEnabled(self.view)
                        
                        self.navigationController?.view.isUserInteractionEnabled = true
                    }
                }
            }
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchTeamData()
        
        self.tableView.register(
            TeamPlayerListCell.self,
            forCellReuseIdentifier: cellReuseIdendifier)
        
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
        switch section {
        case 2: return 10
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0: return teamInfoView
        case 1: return teamDataView
        default: return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseIdendifier,
            for: indexPath) as! TeamPlayerListCell
        
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.isAdmin = true
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0: return CGFloat(self.view.frame.size.width * 347/414).rounded()
        case 1: return CGFloat(self.view.frame.size.height * 40/736).rounded()
        default: return 0.0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 2: return CGFloat(self.view.frame.size.height * 77/736).rounded()
        default: return 0
        }
    }
}
