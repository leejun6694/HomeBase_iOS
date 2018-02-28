//
//  ScheduleDetailTableViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 28..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleDetailTableViewController: UITableViewController {

    // MARK: Properties
    
    var teamData: HBTeam!
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "기록 입력"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    let scheduleDetailInfoView = ScheduleDetailInfoView()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleDetailInfoView.teamData = teamData
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationItem.titleView = titleLabel

        self.tableView.allowsSelection = false
        self.tableView.bounces = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let scheduleDetailInfoViewHeight =
            CGFloat(self.view.frame.size.height * 238/736).rounded()
        
        switch section {
        case 0: return scheduleDetailInfoViewHeight
        default: return 0.0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0: return scheduleDetailInfoView
        default: break
        }
        
        return nil
    }
}
