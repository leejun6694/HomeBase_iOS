//
//  ScheduleDetailTableViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 3. 3..
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
    
    private let scheduleDetailInfoView = ScheduleDetailInfoView()
    private let cellReuseIdendifier = "playerCell"
    
    // MARK: Methods
    
    @objc private func recordPlayerButtonDidTapped(_ sender: UIButton) {
        if let scheduleDetailRecordPlayerViewController = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleDetailRecordPlayerViewController") as? ScheduleDetailRecordPlayerViewController {
            
            self.navigationController?.navigationBar.alpha = 0.5
            self.tableView.alpha = 0.5
            
            self.tabBarController?.definesPresentationContext = false
            scheduleDetailRecordPlayerViewController.modalPresentationStyle = .overFullScreen
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension ScheduleDetailTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 0
        default: return 10
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
        return scheduleDetailInfoView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier,
                                                 for: indexPath) as! ScheduleDetailPlayerCell
        cell.recordPlayerButton.addTarget(self,
                                          action: #selector(recordPlayerButtonDidTapped(_:)),
                                          for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.frame.size.height * 75/736).rounded()
    }
}