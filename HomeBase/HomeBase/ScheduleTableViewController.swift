//
//  ScheduleTableViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 23..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController {
    
    // MARK: Properties
    
    let scheduleRecentView = ScheduleRecentView()
    let monthlySectionHeaderView = ScheduleMonthlySectionHeaderView()
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.contentInset.top = -UIApplication.shared.statusBarFrame.height
        self.tableView.allowsSelection = false
        self.tableView.bounces = false
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let recentViewHeight = CGFloat(self.view.frame.size.height * 346/736).rounded()
        let monthlySectionHeaderViewHeight = CGFloat(self.view.frame.size.height * 57/736).rounded()
        
        switch section {
        case 0: return recentViewHeight
        default: return monthlySectionHeaderViewHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0: return scheduleRecentView
        default: return monthlySectionHeaderView
        }
    }
    
}
