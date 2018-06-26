//
//  TeamSettingMemberTableViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 6. 27..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class TeamSettingMemberTableViewController: UITableViewController {

    // MARK: Properties
    
    private let cellReuseIdendifier = "teamSettingMemberCell"
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "팀원 관리"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = HBColor.lightGray
        
        self.tableView.register(
            TeamSettingMemberCell.self,
            forCellReuseIdentifier: cellReuseIdendifier)
        self.navigationItem.titleView = titleLabel
        self.tableView.allowsSelection = false
        self.tableView.bounces = false
        self.tableView.tableFooterView = UIView()
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.barTintColor = UIColor.clear
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
    }
}

extension TeamSettingMemberTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseIdendifier,
            for: indexPath) as! TeamSettingMemberCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.frame.size.height * 80/736).rounded()
    }
}
