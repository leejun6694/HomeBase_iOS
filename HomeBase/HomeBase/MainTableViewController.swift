//
//  MainTableViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 6..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    // MARK: Properties
    
    var teamData: HBTeam!
    var teamLogo: UIImage!
    var teamPhoto: UIImage!
    
    private let mainTeamInfoView = MainTeamInfoView()
    private let mainNextScheduleView = MainNextScheduleView()
    private let mainBlankView = MainBlankView()
    
    private let headerCellReuseIdendifier = "topSectionHeaderCell"
    private let cellReuseIdendifier = "topSectionCell"
    
    // MARK: Methods
    
    private func fetchTeamData() {
        if let mainTabBarController = self.tabBarController as? MainTabBarController {
            teamData = mainTabBarController.teamData
            teamLogo = mainTabBarController.teamLogo
            teamPhoto = mainTabBarController.teamPhoto
            mainTeamInfoView.teamData = teamData
            mainTeamInfoView.teamLogo = teamLogo
            mainTeamInfoView.teamPhoto = teamPhoto
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTeamData()
        
        self.tableView.contentInset.top = -UIApplication.shared.statusBarFrame.height
        self.tableView.register(
            MainTopSectionHeaderCell.self,
            forCellReuseIdentifier: headerCellReuseIdendifier)
        self.tableView.register(
            MainTopSectionCell.self,
            forCellReuseIdentifier: cellReuseIdendifier)
        self.tableView.allowsSelection = false
        self.tableView.bounces = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchTeamData()
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 0
        case 1: return 0
        case 2: return 0
        case 3: return 4
        case 4: return 0
        case 5: return 4
        default: break
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let teamInfoViewHeight = CGFloat(self.view.frame.height * 642/736).rounded()
        let nextScheduleViewHeight = CGFloat(self.view.frame.height * 107/736).rounded()
        let mainBlankViewHeight = CGFloat(self.view.frame.height * 15/736).rounded()
        
        switch section {
        case 0: return teamInfoViewHeight
        case 1: return nextScheduleViewHeight
        case 2: return mainBlankViewHeight
        case 4: return mainBlankViewHeight
        default: break
        }
        return 0.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0: return mainTeamInfoView
        case 1: return mainNextScheduleView
        case 2: return mainBlankView
        case 4: return mainBlankView
        default: break
        }
        
        return nil
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        switch indexPath.section {
        case 3:
            switch indexPath.row {
            case 0:
                let headerCell = tableView.dequeueReusableCell(
                    withIdentifier: headerCellReuseIdendifier,
                    for: indexPath) as! MainTopSectionHeaderCell
                headerCell.sectionTitle = "타자 TOP 3"
                headerCell.sectionImage = #imageLiteral(resourceName: "batterImage2")
                return headerCell
            case 1:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: cellReuseIdendifier,
                    for: indexPath) as! MainTopSectionCell
                cell.cellTitle = "타율"
                cell.sectionImage = #imageLiteral(resourceName: "batterImage3")
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: cellReuseIdendifier,
                    for: indexPath) as! MainTopSectionCell
                cell.cellTitle = "홈런"
                cell.sectionImage = #imageLiteral(resourceName: "image2")
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: cellReuseIdendifier,
                    for: indexPath) as! MainTopSectionCell
                cell.cellTitle = "도루"
                cell.sectionImage = #imageLiteral(resourceName: "image2")
                return cell
            default: break
            }
        case 5:
            switch indexPath.row {
            case 0:
                let headerCell = tableView.dequeueReusableCell(
                    withIdentifier: headerCellReuseIdendifier,
                    for: indexPath) as! MainTopSectionHeaderCell
                headerCell.sectionTitle = "투수 TOP 3"
                headerCell.sectionImage = #imageLiteral(resourceName: "pitcherImage2")
                return headerCell
            case 1:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: cellReuseIdendifier,
                    for: indexPath) as! MainTopSectionCell
                cell.cellTitle = "방어율"
                cell.sectionImage = #imageLiteral(resourceName: "pitcherImage3")
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: cellReuseIdendifier,
                    for: indexPath) as! MainTopSectionCell
                cell.cellTitle = "승리"
                cell.sectionImage = #imageLiteral(resourceName: "image2")
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: cellReuseIdendifier,
                    for: indexPath) as! MainTopSectionCell
                cell.cellTitle = "탈삼진"
                cell.sectionImage = #imageLiteral(resourceName: "image2")
                return cell
            default: break
            }
        default: break
        }

        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseIdendifier,
            for: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 3, 5:
            switch indexPath.row {
            case 0: return CGFloat(self.view.frame.size.height * 97/736).rounded()
            default: return CGFloat(self.view.frame.size.height * 223/736).rounded()
            }
        default: break
        }
        return CGFloat(self.view.frame.size.height * 223/736).rounded()
    }
}
