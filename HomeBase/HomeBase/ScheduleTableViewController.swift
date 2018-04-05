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
    var schedules: [HBSchedule] = [HBSchedule]()
    
    let dateFormatter = DateFormatter()
    
    var sectionCount = 0
    var sectionInTable = [String]()
    
    private let scheduleRecentView = ScheduleRecentView()
    private let headerCellReuseIdendifier = "monthlyHeaderSectionCell"
    private let cellReuseIdendifier = "monthlySectionCell"
    
    private lazy var addButtonView: UIView = {
        let addButton = UIView()
        addButton.backgroundColor = HBColor.lightGray
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        return addButton
    }()
    
    private lazy var addButton: UIButton = {
        let addButton = UIButton(type: .system)
        addButton.setImage(#imageLiteral(resourceName: "iconPlus"), for: .normal)
        addButton.addTarget(
            self,
            action: #selector(addButtonDidTapped(_:)),
            for: .touchUpInside)
        addButton.tintColor = UIColor.white
        addButton.backgroundColor = UIColor.clear
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        return addButton
    }()
    
    private lazy var footerView: UIView = {
        let footerView = UIView(frame: CGRect(
                x: 0.0,
                y: 0.0,
                width: self.view.frame.size.width,
                height: self.view.frame.size.height * 191/736))
        let footerImageView = UIImageView(image: #imageLiteral(resourceName: "backgroundSchedule2"))
        footerView.addSubview(footerImageView)
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
    
    private func sectionSorted() {
        var savedDate = ""
        sectionCount = 0
        sectionInTable = [String]()
        
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "yyyy-MM"
        
        for schedule in schedules {
            let currentDate = dateFormatter.string(from: schedule.matchDate)
            if savedDate != currentDate {
                savedDate = currentDate
                sectionCount += 1
                sectionInTable.append(savedDate)
            }
        }
    }
    
    private func scheduleSorted(by section: Int) -> [HBSchedule] {
        var cellSchedules = [HBSchedule]()
        
        for schedule in schedules {
            dateFormatter.locale = Locale(identifier: "ko-KR")
            dateFormatter.dateFormat = "yyyy-MM"
            let currentDate = dateFormatter.string(from: schedule.matchDate)
            
            if sectionInTable[section] == currentDate {
                cellSchedules.append(schedule)
            }
        }
        
        return cellSchedules
    }
    
    private func tableViewReloadData() {
        viewDisabled(self.view)
        
        scheduleRecentView.scheduleCount = schedules.count
        
        if let currentUser = Auth.auth().currentUser {
            CloudFunction.getUserDataWith(currentUser) {
                (user, error) in
                
                if let user = user {
                    CloudFunction.getTeamSchedulesDataWith(user.teamCode) {
                        (schedules, error) in
                        
                        if let schedules = schedules {
                            self.schedules = schedules
                            self.sectionSorted()
                            self.tableView.reloadData()
                            
                            self.viewEnabled(self.view)
                        }
                    }
                }
            }
        }
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(
            self,
            action: #selector(refreshControlDidChanged(_:)),
            for: .valueChanged)
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
    }
    
    @objc private func addButtonDidTapped(_ sender: UIButton) {
        guard let scheduleCreateViewController =
            self.storyboard?.instantiateViewController(
                withIdentifier:"ScheduleCreateViewController")
                as? ScheduleCreateViewController else { return }
            
        self.present(scheduleCreateViewController, animated: true, completion: nil)
    }
    
    @objc private func recordButtonDidTapped(_ sender: UIButton) {
        guard let scheduleDetailTableViewController =
            self.storyboard?.instantiateViewController(
            withIdentifier: "ScheduleDetailTableViewController")
                as? ScheduleDetailTableViewController else { return }
            
        let section = sender.tag / 10000
        let row = sender.tag % 10000
        
        let cellSchedules = scheduleSorted(by: section - 1)
        let cellSchedule = cellSchedules[row - 1]
        
        scheduleDetailTableViewController.teamData = teamData
        scheduleDetailTableViewController.cellSchedule = cellSchedule
        self.navigationController?.pushViewController(
            scheduleDetailTableViewController,
            animated: true)
    }
    
    @objc private func refreshControlDidChanged(_ sender: UIRefreshControl) {
        tableViewReloadData()
        sender.endRefreshing()
    }
    
    @IBAction func unwindToDetailView(segue: UIStoryboardSegue) {
        tableViewReloadData()
    }
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTeamData()
        tableViewReloadData()
        
        self.tableView.register(
            ScheduleMonthlySectionHeaderCell.self,
            forCellReuseIdentifier: headerCellReuseIdendifier)
        self.tableView.register(
            ScheduleMonthlySectionCell.self,
            forCellReuseIdentifier: cellReuseIdendifier)
        self.tableView.allowsSelection = false
        self.tableView.tableFooterView = footerView
        
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController.navigationBar.barTintColor = UIColor(
                red: 51,
                green: 215,
                blue: 253,
                alpha: 1.0)
        }
        
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
        
        self.tableView.backgroundColor = UIColor(red: 51, green: 215, blue: 253, alpha: 1.0)
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
}

extension ScheduleTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        if schedules.count == 0 {
            return 2
        } else {
            return sectionCount + 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 0
        default:
            if schedules.count == 0 {
                return 0
            } else {
                let cellSchedules = scheduleSorted(by: section - 1)
                return cellSchedules.count + 1
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let recentViewHeight =
            CGFloat(self.view.frame.size.height * 346/736).rounded()
        let noDataSectionHeaderViewHeight =
            CGFloat(self.view.frame.size.height * 127/736).rounded()
        
        switch section {
        case 0: return recentViewHeight
        default:
            if schedules.count == 0 {
                return noDataSectionHeaderViewHeight
            } else {
                return 0.0
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            scheduleRecentView.scheduleCount = schedules.count
            return scheduleRecentView
        default:
            if schedules.count == 0 {
                let noDataSectionHeaderView = ScheduleNoDataView()
                return noDataSectionHeaderView
            } else {
                let monthlySectionHeaderView = ScheduleMonthlySectionHeaderView()
                dateFormatter.locale = Locale(identifier: "ko-KR")
                dateFormatter.dateFormat = "yyyy-MM"
                if let date = dateFormatter.date(from: sectionInTable[section - 1]) {
                    monthlySectionHeaderView.matchDate = date
                }
                
                return monthlySectionHeaderView
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: headerCellReuseIdendifier,
                for: indexPath) as! ScheduleMonthlySectionHeaderCell
            
            dateFormatter.locale = Locale(identifier: "ko-KR")
            dateFormatter.dateFormat = "yyyy-MM"
            if let date = dateFormatter.date(from: sectionInTable[indexPath.section - 1]) {
                cell.matchDate = date
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: cellReuseIdendifier,
                for: indexPath) as! ScheduleMonthlySectionCell
            
            let cellSchedules = scheduleSorted(by: indexPath.section - 1)
            let cellSchedule = cellSchedules[indexPath.row - 1]
            
            cell.recordButton.tag = indexPath.section * 10000 + indexPath.row
            cell.recordButton.addTarget(
                self,
                action: #selector(recordButtonDidTapped(_:)),
                for: .touchUpInside)
            cell.opponentTeam = cellSchedule.opponentTeam
            cell.matchPlace = cellSchedule.matchPlace
            cell.matchDate = cellSchedule.matchDate
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(self.view.frame.size.height * 57/736).rounded()
        } else {
            return CGFloat(self.view.frame.size.height * 111/736).rounded()
        }
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
