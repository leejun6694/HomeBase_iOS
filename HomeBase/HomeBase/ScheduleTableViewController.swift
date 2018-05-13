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
    var recentSchedules: [HBSchedule] = [HBSchedule]()
    
    let dateFormatter = DateFormatter()
    
    var sectionCount = 0
    var sectionInTable = [String]()
    
    private let scheduleRecentView = ScheduleRecentView()
    private let headerCellReuseIdendifier = "monthlyHeaderSectionCell"
    private let cellReuseIdendifier = "monthlySectionCell"
    private let blankCellReuseIdendifier = "blankCell"
    
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
    
    private func recentRecordChecked(_ schedules: [HBSchedule]) {
        recentSchedules.removeAll()
        
        for schedule in schedules {
            if recentSchedules.count < 6 {
                let homeScore = schedule.homeScore
                let opponentScore = schedule.opponentScore
                
                if homeScore != -1, opponentScore != -1 {
                    recentSchedules.append(schedule)
                }
            } else {
                break
            }
        }
    }
    
    private func tableViewReloadData() {
        viewDisabled(self.view)
        
        if let navigationController = self.navigationController {
            if addButtonView.isDescendant(of: navigationController.view) {
                buttonDisabled(addButton)
            }
        }
        
        scheduleRecentView.scheduleCount = schedules.count
        
        if let currentUser = Auth.auth().currentUser {
            CloudFunction.getUserDataWith(currentUser) {
                (user, error) in
                
                if let user = user {
                    CloudFunction.getTeamSchedulesDataWith(user.teamCode) {
                        (schedules, error) in
                        
                        if let schedules = schedules {
                            self.schedules = schedules
                            self.recentRecordChecked(self.schedules)
                            self.sectionSorted()
                            self.tableView.reloadData()
                            
                            self.viewEnabled(self.view)
                            if let navigationController = self.navigationController {
                                if self.addButtonView.isDescendant(
                                    of: navigationController.view) {
                                    self.buttonEnabled(self.addButton)
                                }
                            }
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
        let cellSchedule = cellSchedules[row/2]
        
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
    
    @IBAction func unwindToScheduleView(segue: UIStoryboardSegue) {
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
        self.tableView.register(
            ScheduleMonthlySectionBlankCell.self,
            forCellReuseIdentifier: blankCellReuseIdendifier)
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
                return cellSchedules.count * 2 + 1
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
            scheduleRecentView.resetRecentView()
            scheduleRecentView.scheduleCount = schedules.count
            
            for (index, recent) in recentSchedules.enumerated() {
                var record = ""
                dateFormatter.dateFormat = "M.d"
                let date = dateFormatter.string(from: recent.matchDate)
                
                let recordScore = recent.homeScore - recent.opponentScore
                if recordScore > 0 { record = "승" }
                else if recordScore < 0 { record = "패" }
                else { record = "무" }
                
                switch index {
                case 0:
                    scheduleRecentView.firstRecord = record
                    scheduleRecentView.firstDate = date
                case 1:
                    scheduleRecentView.secondRecord = record
                    scheduleRecentView.secondDate = date
                case 2:
                    scheduleRecentView.thirdRecord = record
                    scheduleRecentView.thirdDate = date
                case 3:
                    scheduleRecentView.fourthRecord = record
                    scheduleRecentView.fourthDate = date
                case 4:
                    scheduleRecentView.fifthRecord = record
                    scheduleRecentView.fifthDate = date
                default:
                    break
                }
            }
            
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let currentUser = Auth.auth().currentUser {
            if teamData.admin == currentUser.uid {
                if indexPath.row % 2 == 1 {
                    return true
                }
            }
        }
        return false
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
            
            var monthWin: Int = 0;
            var monthDraw: Int = 0;
            var monthLose: Int = 0;
            
            let cellSchedules = scheduleSorted(by: indexPath.section - 1)
            for cellSchedule in cellSchedules {
                if cellSchedule.homeScore != -1, cellSchedule.opponentScore != -1 {
                    let score = cellSchedule.homeScore - cellSchedule.opponentScore
                    
                    if score > 0 { monthWin += 1 }
                    else if score == 0 { monthDraw += 1 }
                    else { monthLose += 1 }
                }
            }
            
            cell.monthWin = monthWin
            cell.monthDraw = monthDraw
            cell.monthLose = monthLose
            
            cell.changeMonthlyRecordLabel()
            
            return cell
        } else if indexPath.row % 2 == 1 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: cellReuseIdendifier,
                for: indexPath) as! ScheduleMonthlySectionCell
            
            cell.teamData = teamData
            
            let cellSchedules = scheduleSorted(by: indexPath.section - 1)
            let cellSchedule = cellSchedules[indexPath.row/2]
            
            if cellSchedule.homeScore != -1, cellSchedule.opponentScore != -1 {
                cell.homeScore = cellSchedule.homeScore
                cell.opponentScore = cellSchedule.opponentScore
                
                let score = cellSchedule.homeScore - cellSchedule.opponentScore
                if score > 0 { cell.result = "승" }
                else if score == 0 { cell.result = "무" }
                else { cell.result = "패" }
            } else {
                cell.result = "-"
            }
            
            cell.opponentTeam = cellSchedule.opponentTeam
            cell.matchPlace = cellSchedule.matchPlace
            cell.matchDate = cellSchedule.matchDate
            
            cell.recordButton.tag = indexPath.section * 10000 + indexPath.row
            cell.recordButton.addTarget(
                self,
                action: #selector(recordButtonDidTapped(_:)),
                for: .touchUpInside)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: blankCellReuseIdendifier,
                for: indexPath) as! ScheduleMonthlySectionBlankCell
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return CGFloat(self.view.frame.size.height * 57/736).rounded()
        } else if indexPath.row % 2 == 1 {
            return CGFloat(self.view.frame.size.height * 103/736).rounded()
        } else {
            return CGFloat(self.view.frame.size.height * 8/736).rounded()
        }
    }
    
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if indexPath.row % 2 == 1 {
            let cellSchedules = self.scheduleSorted(by: indexPath.section - 1)
            let cellSchedule = cellSchedules[indexPath.row/2]
            
            let editAction = UIContextualAction(style: .normal, title: nil) {
                (ac, view, success) in

                guard let scheduleCreateViewController =
                    self.storyboard?.instantiateViewController(
                        withIdentifier: "ScheduleCreateViewController")
                        as? ScheduleCreateViewController else { return }
                
                self.dateFormatter.locale = Locale(identifier: "ko-KR")
                self.dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                let matchDate = self.dateFormatter.string(from: cellSchedule.matchDate)
                
                scheduleCreateViewController.edit = true
                scheduleCreateViewController.sid = cellSchedule.sid
                scheduleCreateViewController.opponentTeam = cellSchedule.opponentTeam
                scheduleCreateViewController.matchPlace = cellSchedule.matchPlace
                scheduleCreateViewController.matchDate = matchDate
                
                self.present(scheduleCreateViewController, animated: true, completion: nil)
                
                success(false)
            }
            editAction.image = #imageLiteral(resourceName: "iconEdit")
            editAction.backgroundColor = HBColor.darkGray

            let deleteAction = UIContextualAction(style: .destructive, title: nil) {
                (ac, view, success) in

                guard let scheduleDeleteViewController =
                    self.storyboard?.instantiateViewController(
                        withIdentifier: "ScheduleDeleteViewController")
                        as? ScheduleDeleteViewController else { return }
                
                scheduleDeleteViewController.sid = cellSchedule.sid
                scheduleDeleteViewController.modalPresentationStyle = .overCurrentContext
                self.present(scheduleDeleteViewController, animated: false, completion: nil)
                
                success(false)
            }
            deleteAction.image = #imageLiteral(resourceName: "iconDelete")
            deleteAction.backgroundColor = HBColor.lightRed

            let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
            configuration.performsFirstActionWithFullSwipe = false
            
            return configuration
        } else {
            return nil
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
