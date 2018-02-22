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
    
    let mainTeamInfoView = MainTeamInfoView()
    let mainNextScheduleView = MainNextScheduleView()
    let mainBlankView = MainBlankView()
    
    let headerCellReuseIdendifier = "topSectionHeaderCell"
    let cellReuseIdendifier = "topSectionCell"
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset.top = -UIApplication.shared.statusBarFrame.height
        self.tableView.register(MainTopSectionHeaderCell.self,
                                forCellReuseIdentifier: headerCellReuseIdendifier)
        self.tableView.register(MainTopSectionCell.self,
                                forCellReuseIdentifier: cellReuseIdendifier)
        self.tableView.allowsSelection = false
        self.tableView.bounces = false
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
        let teamInfoViewHeight = self.view.frame.height * 642/736
        let nextScheduleViewHeight = self.view.frame.height * 107/736
        let mainBlankViewHeight = self.view.frame.height * 15/736
        
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
                headerCell.sectionImage = #imageLiteral(resourceName: "batterImage")
                return headerCell
            case 1:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: cellReuseIdendifier,
                    for: indexPath) as! MainTopSectionCell
                cell.cellTitle = "타율"
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: cellReuseIdendifier,
                    for: indexPath) as! MainTopSectionCell
                cell.cellTitle = "홈런"
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: cellReuseIdendifier,
                    for: indexPath) as! MainTopSectionCell
                cell.cellTitle = "도루"
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
                headerCell.sectionImage = #imageLiteral(resourceName: "pitcherImage")
                return headerCell
            case 1:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: cellReuseIdendifier,
                    for: indexPath) as! MainTopSectionCell
                cell.cellTitle = "방어율"
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: cellReuseIdendifier,
                    for: indexPath) as! MainTopSectionCell
                cell.cellTitle = "승리"
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: cellReuseIdendifier,
                    for: indexPath) as! MainTopSectionCell
                cell.cellTitle = "탈삼진"
                return cell
            default: break
            }
        default: break
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier, for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 3, 5:
            switch indexPath.row {
            case 0: return self.view.frame.size.height * 97/736
            default: return self.view.frame.size.height * 223/736
            }
        default: break
        }
        return self.view.frame.size.height * 223/736
    }
}
