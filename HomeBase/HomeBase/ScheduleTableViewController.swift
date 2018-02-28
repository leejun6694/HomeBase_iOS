//
//  ScheduleTableViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 23..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth

class ScheduleTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var teamData: HBTeam!
    var teamLogo: UIImage!
    
    private let scheduleRecentView = ScheduleRecentView()
    private let monthlySectionHeaderView = ScheduleMonthlySectionHeaderView()
    
    private let cellReuseIdendifier = "monthlySectionCell"
    
    private lazy var addButtonView: UIView = {
        let addButton = UIView()
        addButton.backgroundColor = UIColor(red: 44.0/255.0,
                                          green: 44.0/255.0,
                                          blue: 44.0/255.0,
                                          alpha: 1.0)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        return addButton
    }()
    
    private lazy var addButton: UIButton = {
        let addButton = UIButton(type: .system)
        addButton.setImage(#imageLiteral(resourceName: "iconPlus"), for: .normal)
        addButton.addTarget(self,
                            action: #selector(addButtonDidTapped(_:)),
                            for: .touchUpInside)
        addButton.tintColor = UIColor.white
        addButton.backgroundColor = UIColor.clear
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        return addButton
    }()
    
    private lazy var footerView: UIView = {
        let footerView = UIView(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: self.view.frame.size.width,
                                              height: self.view.frame.size.height * 80/736))
        footerView.backgroundColor = UIColor(red: 192.0/255.0,
                                             green: 222.0/255.0,
                                             blue: 229.0/255.0,
                                             alpha: 1.0)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        return footerView
    }()
    
    // MARK: Methods
    
    private func fetchTeamData() {
        if let mainTabBarController = self.tabBarController as? MainTabBarController {
            teamData = mainTabBarController.teamData
            teamLogo = mainTabBarController.teamLogo
            scheduleRecentView.teamData = teamData
            scheduleRecentView.teamLogo = teamLogo
        }
    }
    
    @objc private func addButtonDidTapped(_ sender: UIButton) {
        if let scheduleCreateViewController = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleCreateViewController") as? ScheduleCreateViewController {
            
            self.present(scheduleCreateViewController, animated: true, completion: nil)
        }
    }
    
    @objc private func recordButtonDidTapped(_ sender: UIButton) {
        if let scheduleDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleDetailViewController") as? ScheduleDetailViewController {
            
            scheduleDetailViewController.teamData = teamData
            self.navigationController?.pushViewController(
                scheduleDetailViewController,
                animated: true)
        }
    }
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTeamData()

        self.tableView.register(ScheduleMonthlySectionCell.self,
                                forCellReuseIdentifier: cellReuseIdendifier)
        self.tableView.contentInset.top = -UIApplication.shared.statusBarFrame.height
        self.tableView.allowsSelection = false
        self.tableView.bounces = false
        self.tableView.tableFooterView = footerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
        if let currentUser = Auth.auth().currentUser {
            if teamData.admin == currentUser.uid {
                self.navigationController?.view.addSubview(addButtonView)
                self.navigationController?.view.addConstraints(addButtonViewConstraints())
                addButtonView.addSubview(addButton)
                addButtonView.addConstraints(addButtonConstraints())
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addButtonView.layer.cornerRadius = addButtonView.frame.size.width / 2
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let currentUser = Auth.auth().currentUser {
            if teamData.admin == currentUser.uid {
                addButton.removeFromSuperview()
                addButtonView.removeFromSuperview()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 0
        default: return 4
        }
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseIdendifier, for: indexPath) as! ScheduleMonthlySectionCell
        
        cell.recordButton.addTarget(self,
                                    action: #selector(recordButtonDidTapped(_:)),
                                    for: .touchUpInside)
        
        switch indexPath.row {
        case 0:
            cell.day = "20"
            cell.dayOfWeek = "토요일"
            cell.opponentTeam = "HomeBase"
            cell.matchDate = "2월 20일 토요일 오전 9:00"
            cell.matchPlace = "홈베이스 야구장"
        case 1:
            cell.day = "13"
            cell.dayOfWeek = "토요일"
            cell.opponentTeam = "INHA university"
            cell.matchDate = "2월 13일 토요일 오전 8:00"
            cell.matchPlace = "인하대"
        case 2:
            cell.day = "7"
            cell.dayOfWeek = "일요일"
            cell.opponentTeam = "홈베이스 야구팀"
            cell.matchDate = "2월 7일 토요일 오전 9:00"
            cell.matchPlace = "홈베이스 야구장"
        case 3:
            cell.day = "6"
            cell.dayOfWeek = "토요일"
            cell.opponentTeam = "opponent team"
            cell.matchDate = "2월 6일 토요일 오전 10:00"
            cell.matchPlace = "홈베이스 야구장"
        default: break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.frame.size.height * 111/736).rounded()
    }
}

extension ScheduleTableViewController {
    private func addButtonViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: addButtonView, attribute: .centerX, relatedBy: .equal,
            toItem: self.navigationController?.view,
            attribute: .centerX, multiplier: 351.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: addButtonView, attribute: .centerY, relatedBy: .equal,
            toItem: self.navigationController?.view,
            attribute: .centerY, multiplier: 617.5/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: addButtonView, attribute: .width, relatedBy: .equal,
            toItem: self.navigationController?.view,
            attribute: .width, multiplier: 75/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: addButtonView, attribute: .height, relatedBy: .equal,
            toItem: addButtonView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func addButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: addButton, attribute: .centerX, relatedBy: .equal,
            toItem: addButtonView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: addButton, attribute: .centerY, relatedBy: .equal,
            toItem: addButtonView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: addButton, attribute: .width, relatedBy: .equal,
            toItem: addButtonView, attribute: .width, multiplier: 30/75, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: addButton, attribute: .height, relatedBy: .equal,
            toItem: addButton, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
