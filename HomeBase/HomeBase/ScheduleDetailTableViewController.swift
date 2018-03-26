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
    var arrayOfKeys = [String]()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "기록 입력"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    private let scheduleDetailInfoView = ScheduleDetailInfoView()
    private let cellReuseIdendifier = "playerCell"
    
    // MARK: Methods
    
    @objc private func matchResultButtonDidTapped(_ sender: UIButton) {
        if let scheduleDetailRecordMatchViewController = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleDetailRecordMatchViewController") as? ScheduleDetailRecordMatchViewController {
            
            self.navigationController?.navigationBar.alpha = 0.5
            self.tableView.alpha = 0.5
            
            self.tabBarController?.definesPresentationContext = false
            scheduleDetailRecordMatchViewController.modalPresentationStyle = .overFullScreen
            
            self.present(scheduleDetailRecordMatchViewController,
                         animated: true,
                         completion: nil)
        }
    }
    
    @objc private func recordPlayerButtonDidTapped(_ sender: UIButton) {
        if let scheduleDetailRecordPlayerViewController = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleDetailRecordPlayerViewController") as? ScheduleDetailRecordPlayerViewController {
            
            self.navigationController?.navigationBar.alpha = 0.5
            self.tableView.alpha = 0.5
            
            self.tabBarController?.definesPresentationContext = false
            scheduleDetailRecordPlayerViewController.modalPresentationStyle = .overFullScreen
            
            let sid = cellSchedule.sid
            let pid = arrayOfKeys[sender.tag]
            let player = teamData.members[pid]
            
            scheduleDetailRecordPlayerViewController.sid = sid
            scheduleDetailRecordPlayerViewController.pid = pid
            scheduleDetailRecordPlayerViewController.player = player
            self.present(scheduleDetailRecordPlayerViewController,
                         animated: true,
                         completion: nil)
        }
    }
    
    @IBAction func unwindToDetailView(segue: UIStoryboardSegue) {
        self.navigationController?.navigationBar.alpha = 1.0
        self.tableView.alpha = 1.0
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationItem.titleView = titleLabel
        
        self.tableView.register(ScheduleDetailPlayerCell.self,
                                forCellReuseIdentifier: cellReuseIdendifier)
        self.tableView.allowsSelection = false
        self.tableView.bounces = false
        
        arrayOfKeys = Array(teamData.members.keys)
        
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
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 44.0/255.0,
                                                                        green: 44.0/255.0,
                                                                        blue: 44.0/255.0,
                                                                        alpha: 1.0)
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
        let scheduleDetailInfoViewHeight = CGFloat(self.view.frame.size.height * 238/736).rounded()
        
        switch section {
        case 0: return scheduleDetailInfoViewHeight
        default: return 0.0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        scheduleDetailInfoView.opponentTeam = cellSchedule.opponentTeam
        scheduleDetailInfoView.matchDate = cellSchedule.matchDate
        scheduleDetailInfoView.matchPlace = cellSchedule.matchPlace
        
        if let currentUser = Auth.auth().currentUser {
            if currentUser.uid == teamData.admin {
                
            } else {
                scheduleDetailInfoView.homeTeamButton.isEnabled = false
                scheduleDetailInfoView.opponentTeamButton.isEnabled = false
            }
        }
        
        return scheduleDetailInfoView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier,
                                                 for: indexPath) as! ScheduleDetailPlayerCell
        
        if indexPath.row % 2 == 0 {
            cell.baseView.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        }
        
        let key = arrayOfKeys[indexPath.row]
        if let player = teamData.members[key] {
            cell.backNumber = player.backNumber
            cell.name = player.name
        }
        
        cell.recordPlayerButton.tag = indexPath.row
        if let currentUser = Auth.auth().currentUser {
            if currentUser.uid == teamData.admin {
                cell.recordPlayerButton.addTarget(self,
                                                  action: #selector(recordPlayerButtonDidTapped(_:)),
                                                  for: .touchUpInside)
            } else {
                cell.recordPlayerButton.setTitle("결과 보기", for: .normal)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.frame.size.height * 82/736).rounded()
    }
}
