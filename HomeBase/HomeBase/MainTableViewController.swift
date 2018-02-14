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
    let mainTopSectionBatterView = MainTopSectionView()
    let mainTopSectionPitcherView = MainTopSectionView()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset.top = -UIApplication.shared.statusBarFrame.height
        self.tableView.showsVerticalScrollIndicator = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 0
        case 1: return 0
        case 2: return 0
        case 3: return 0
        case 4: return 0
        default: break
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let teamInfoViewHeight = self.view.frame.height * 642/736
        let nextScheduleViewHeight = self.view.frame.height * 107/736
        let mainBlankViewHeight = self.view.frame.height * 15/736
        let mainTopSectionViewHeight = self.view.frame.height * 62/736
        
        switch section {
        case 0: return teamInfoViewHeight
        case 1: return nextScheduleViewHeight
        case 2: return mainBlankViewHeight
        case 3: return mainTopSectionViewHeight
        case 4: return mainTopSectionViewHeight
        default: break
        }
        return 30.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0: return mainTeamInfoView
        case 1: return mainNextScheduleView
        case 2: return mainBlankView
        case 3:
            mainTopSectionBatterView.sectionTitle = "타자 TOP 3"
            return mainTopSectionBatterView
        case 4:
            mainTopSectionPitcherView.sectionTitle = "투수 TOP 3"
            return mainTopSectionPitcherView
        default: break
        }
        
        return nil
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
}
