//
//  ScheduleDetailTableViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 3. 3..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth

class ScheduleDetailTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var teamData: HBTeam!
    var cellSchedule: HBSchedule!
    var playerList = [HBPlayer]()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "기록 입력"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    let scheduleDetailInfoView = ScheduleDetailInfoView()
    private let cellReuseIdendifier = "playerCell"
    
    // MARK: Methods
    
    private func tableViewReloadData() {
        viewDisabled(self.view)
        self.navigationController?.view.isUserInteractionEnabled = false
        
        guard let currentUser = Auth.auth().currentUser else { return }
        CloudFunction.getUserDataWith(currentUser) {
            (user, error) in
            
            if let user = user {
                CloudFunction.getSchedulesDataWith(
                self.cellSchedule.sid,
                teamCode: user.teamCode) {
                    (scheduleData, error) in
                    
                    if let scheduleData = scheduleData {
                        self.cellSchedule = scheduleData
                    }
                    
                    CloudFunction.getTeamDataWith(user.teamCode) {
                        (teamData, error) in
                        
                        if let teamData = teamData {
                            self.teamData = teamData
                            self.playerList = teamData.members
                            self.playerList = self.playerList.sorted(
                                    by: { $0.backNumber < $1.backNumber })
                            
                            self.tableView.reloadData()
                            self.viewEnabled(self.view)
                            self.navigationController?.view.isUserInteractionEnabled = true
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
    
    @objc private func matchResultButtonDidTapped(_ sender: UIButton) {
        guard let scheduleDetailRecordMatchViewController = self.storyboard?.instantiateViewController(
            withIdentifier: "ScheduleDetailRecordMatchViewController")
            as? ScheduleDetailRecordMatchViewController else { return }
            
        self.navigationController?.navigationBar.alpha = 0.5
        self.tableView.alpha = 0.5
        
        self.tabBarController?.definesPresentationContext = false
        scheduleDetailRecordMatchViewController.modalPresentationStyle = .overFullScreen
        
        let sid = cellSchedule.sid
        scheduleDetailRecordMatchViewController.sid = sid
        
        let infoHomeScore = scheduleDetailInfoView.homeTeamScore
        let infoOpponentScore = scheduleDetailInfoView.opponentTeamScore
        
        if infoHomeScore != -1, infoOpponentScore != -1 {
            scheduleDetailRecordMatchViewController.homeScore = infoHomeScore
            scheduleDetailRecordMatchViewController.opponentScore = infoOpponentScore
        }
        
        self.present(
            scheduleDetailRecordMatchViewController,
            animated: true,
            completion: nil)
    }
    
    @objc private func recordPlayerButtonDidTapped(_ sender: UIButton) {
        guard let scheduleDetailRecordPlayerViewController = self.storyboard?.instantiateViewController(
            withIdentifier: "ScheduleDetailRecordPlayerViewController")
            as? ScheduleDetailRecordPlayerViewController else { return }
            
        self.navigationController?.navigationBar.alpha = 0.5
        self.tableView.alpha = 0.5
        
        self.tabBarController?.definesPresentationContext = false
        scheduleDetailRecordPlayerViewController.modalPresentationStyle = .overFullScreen
        
        let sid = cellSchedule.sid
        let player = playerList[sender.tag]
        
        if let record = cellSchedule.records[player.pid] {
            scheduleDetailRecordPlayerViewController.record = record
        }
        
        scheduleDetailRecordPlayerViewController.sid = sid
        scheduleDetailRecordPlayerViewController.pid = player.pid
        scheduleDetailRecordPlayerViewController.player = player
        self.present(
            scheduleDetailRecordPlayerViewController,
            animated: true,
            completion: nil)
    }
    
    @objc private func refreshControlDidChanged(_ sender: UIRefreshControl) {
        tableViewReloadData()
        sender.endRefreshing()
    }
    
    @IBAction func unwindToDetailView(segue: UIStoryboardSegue) {
        self.navigationController?.navigationBar.alpha = 1.0
        self.tableView.alpha = 1.0
        
        tableViewReloadData()
    }
    
    @IBAction func cancelToDetailView(segue: UIStoryboardSegue) {
        self.navigationController?.navigationBar.alpha = 1.0
        self.tableView.alpha = 1.0
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
        self.navigationItem.titleView = titleLabel
        
        self.tableView.register(
            ScheduleDetailPlayerCell.self,
            forCellReuseIdentifier: cellReuseIdendifier)
        
        setupRefreshControl()
        self.playerList = teamData.members
        self.playerList = self.playerList.sorted(
            by: { $0.backNumber < $1.backNumber })
        
        scheduleDetailInfoView.homeTeamButton.addTarget(
            self,
            action: #selector(matchResultButtonDidTapped(_:)),
            for: .touchUpInside)
        scheduleDetailInfoView.opponentTeamButton.addTarget(
            self,
            action: #selector(matchResultButtonDidTapped(_:)),
            for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = HBColor.lightGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableViewReloadData()
    }
}

extension ScheduleDetailTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 0
        default: return teamData.members.count
        }
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
        scheduleDetailInfoView.opponentTeam = cellSchedule.opponentTeam
        scheduleDetailInfoView.matchDate = cellSchedule.matchDate
        scheduleDetailInfoView.matchPlace = cellSchedule.matchPlace
        
        scheduleDetailInfoView.homeTeamScore = cellSchedule.homeScore
        scheduleDetailInfoView.opponentTeamScore = cellSchedule.opponentScore
        
        guard let currentUser = Auth.auth().currentUser else { return nil }
        if currentUser.uid != teamData.admin {
            scheduleDetailInfoView.homeTeamButton.isEnabled = false
            scheduleDetailInfoView.opponentTeamButton.isEnabled = false
        }
        
        return scheduleDetailInfoView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseIdendifier,
            for: indexPath) as! ScheduleDetailPlayerCell
        
        cell.selectionStyle = .none
        
        if indexPath.row % 2 == 0 {
            cell.baseView.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        }
        
        let player = playerList[indexPath.row]
        cell.backNumber = player.backNumber
        cell.name = player.name
        
        cell.recordPlayerButton.tag = indexPath.row
        if let currentUser = Auth.auth().currentUser {
            if currentUser.uid == teamData.admin {
                cell.recordPlayerButton.addTarget(
                    self,
                    action: #selector(recordPlayerButtonDidTapped(_:)),
                    for: .touchUpInside)
                cell.recordPlayerButton.isUserInteractionEnabled = true
            } else {
                cell.recordPlayerButton.setTitle("결과 보기", for: .normal)
                cell.recordPlayerButton.isUserInteractionEnabled = false
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.frame.size.height * 82/736).rounded()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let scheduleDetailLoadPlayerViewController = self.storyboard?.instantiateViewController(
            withIdentifier: "ScheduleDetailLoadPlayerViewController")
            as? ScheduleDetailLoadPlayerViewController else { return }
        
        self.navigationController?.navigationBar.alpha = 0.5
        self.tableView.alpha = 0.5
        
        self.tabBarController?.definesPresentationContext = false
        scheduleDetailLoadPlayerViewController.modalPresentationStyle = .overFullScreen
        
        let player = playerList[indexPath.row]

        if let record = cellSchedule.records[player.pid] {
            scheduleDetailLoadPlayerViewController.record = record
        }

        scheduleDetailLoadPlayerViewController.player = player
        self.present(
            scheduleDetailLoadPlayerViewController,
            animated: true,
            completion: nil)
    }
}
