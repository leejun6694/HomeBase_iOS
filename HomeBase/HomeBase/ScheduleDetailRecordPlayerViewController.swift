//
//  ScheduleDetailRecordPlayerViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 3. 5..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleDetailRecordPlayerViewController: UIViewController {

    // MARK: Properites
    
    var player: HBPlayer!
    
    @IBOutlet private var scheduleDetailRecordPlayerHeaderView: ScheduleDetailRecordPlayerHeaderView!
    private let cellReuseIdendifier = "recordPlayerCell"
    
    @IBOutlet var tableView: UITableView!
    
    private lazy var footerView: UIView = {
        let footerView = UIView(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: self.view.frame.size.width,
                                              height: 50.0))
        footerView.backgroundColor = .white
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        return footerView
    }()
    
    // MARK: Methods
    
    @objc private func cancelButtonDidTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToDetailView", sender: self)
    }
    
    @objc private func batterButtonDidTapped(_ sender: UIButton) {
        scheduleDetailRecordPlayerHeaderView.batterButtonState = true
        
        self.tableView.reloadData()
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @objc private func pitcherButtonDidTapped(_ sender: UIButton) {
        scheduleDetailRecordPlayerHeaderView.batterButtonState = false
        
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        self.tableView.reloadData()
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(ScheduleDetailRecordPlayerTableViewCell.self,
                                forCellReuseIdentifier: cellReuseIdendifier)
        self.tableView.allowsSelection = false
        self.tableView.bounces = false
        self.tableView.tableFooterView = footerView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        scheduleDetailRecordPlayerHeaderView.name = player.name
        
        scheduleDetailRecordPlayerHeaderView.cancelButton.addTarget(
            self, action: #selector(cancelButtonDidTapped(_:)), for: .touchUpInside)
        
        scheduleDetailRecordPlayerHeaderView.batterButton.addTarget(
            self, action: #selector(batterButtonDidTapped(_:)), for: .touchUpInside)
        scheduleDetailRecordPlayerHeaderView.pitcherButton.addTarget(
            self, action: #selector(pitcherButtonDidTapped(_:)), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        self.view.isOpaque = false
        
        self.view.frame.origin.y = self.view.bounds.origin.y + 50.0
    }
}

extension ScheduleDetailRecordPlayerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scheduleDetailRecordPlayerHeaderView.batterButtonState {
            return 13
        } else {
            return 11
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseIdendifier,
            for: indexPath) as! ScheduleDetailRecordPlayerTableViewCell
        
        if scheduleDetailRecordPlayerHeaderView.batterButtonState {
            switch indexPath.row {
            case 0: cell.headText = "1루타"
            case 1: cell.headText = "2루타"
            case 2: cell.headText = "3루타"
            case 3: cell.headText = "홈런"
            case 4: cell.headText = "볼넷"
            case 5: cell.headText = "사구"
            case 6: cell.headText = "희생타"
            case 7: cell.headText = "도루"
            case 8: cell.headText = "삼진"
            case 9: cell.headText = "땅볼"
            case 10: cell.headText = "뜬공"
            case 11: cell.headText = "득점"
            case 12: cell.headText = "타점"
            default: break
            }
        } else {
            switch indexPath.row {
            case 0: cell.headText = "승리"
            case 1: cell.headText = "패배"
            case 2: cell.headText = "홀드"
            case 3: cell.headText = "세이브"
            case 4: cell.headText = "이닝"
            case 5: cell.headText = "삼진"
            case 6: cell.headText = "자책점"
            case 7: cell.headText = "피안타"
            case 8: cell.headText = "피홈런"
            case 9: cell.headText = "볼넷"
            case 10: cell.headText = "사구"
            default: break
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.frame.size.height * 104.5/736).rounded()
    }
}
