//
//  ScheduleDetailViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 3. 1..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleDetailViewController: UIViewController {

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
    
    @IBOutlet private var tableView: UITableView!
    private let cellReuseIdendifier = "playerCell"
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationItem.titleView = titleLabel
        
        tableView.register(ScheduleDetailPlayerCell.self,
                           forCellReuseIdentifier: cellReuseIdendifier)
        tableView.allowsSelection = false
        tableView.bounces = false
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension ScheduleDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier,
                                                 for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.frame.size.height * 75/736).rounded()
    }
}
