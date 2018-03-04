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
        
        scheduleDetailRecordPlayerHeaderView.cancelButton.addTarget(
            self, action: #selector(cancelButtonDidTapped(_:)), for: .touchUpInside)
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseIdendifier,
            for: indexPath) as! ScheduleDetailRecordPlayerTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.frame.size.height * 104.5/736).rounded()
    }
}
