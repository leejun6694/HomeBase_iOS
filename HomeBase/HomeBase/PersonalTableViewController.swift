//
//  PersonalTableViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 21..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class PersonalTableViewController: UITableViewController {

    // MARK: Properties
    
    let headerView = PersonalHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset.top = -UIApplication.shared.statusBarFrame.height
        self.tableView.bounces = false
    }
}

extension PersonalTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(self.view.frame.size.height * 587/736).rounded()
    }
}
