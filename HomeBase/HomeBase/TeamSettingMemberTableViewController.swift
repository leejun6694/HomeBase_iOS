//
//  TeamSettingMemberTableViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 6. 27..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseStorage

class TeamSettingMemberTableViewController: UITableViewController {

    // MARK: Properties
    
    var teamData: HBTeam!
    var playerList = [HBPlayer]()
    
    private let cellReuseIdendifier = "teamSettingMemberCell"
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "팀원 관리"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    // MARK: Methods
    
    private func sortPlayerList() {
        playerList = teamData.members
        playerList = playerList.sorted(
            by: { $0.backNumber < $1.backNumber })
        
        for (index, player) in playerList.enumerated() {
            if player.pid == teamData.admin {
                playerList.remove(at: index)
            }
        }
    }
    
    @objc private func moreButtonDidTapped(_ sender: UIButton) {
        guard let teamSettingMoreViewController = self.storyboard?.instantiateViewController(
            withIdentifier: "TeamSettingMoreViewController")
            as? TeamSettingMoreViewController else { return }
        
        self.navigationController?.navigationBar.alpha = 0.5
        self.tableView.alpha = 0.5
        
        self.tabBarController?.definesPresentationContext = false
        teamSettingMoreViewController.modalPresentationStyle = .overFullScreen
        
        teamSettingMoreViewController.teamData = teamData
        teamSettingMoreViewController.player = playerList[sender.tag]
        
        self.present(teamSettingMoreViewController, animated: true, completion: nil)
    }
    
    @IBAction func unwindToMemberViewSegue(_ segue: UIStoryboardSegue) {
        self.navigationController?.navigationBar.alpha = 1.0
        self.tableView.alpha = 1.0
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sortPlayerList()
        
        self.view.backgroundColor = HBColor.lightGray
        
        self.tableView.register(
            TeamSettingMemberCell.self,
            forCellReuseIdentifier: cellReuseIdendifier)
        self.navigationItem.titleView = titleLabel
        self.tableView.allowsSelection = false
        self.tableView.bounces = false
        self.tableView.tableFooterView = UIView()
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.barTintColor = UIColor.clear
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
    }
}

extension TeamSettingMemberTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellReuseIdendifier,
            for: indexPath) as! TeamSettingMemberCell
        
        if playerList[indexPath.row].playerPhoto != "default" {
            let storageRef = Storage.storage().reference()
            let playerPhotoRef = storageRef.child(playerList[indexPath.row].playerPhoto)
            
            playerPhotoRef.getData(maxSize: 4 * 1024 * 1024) {
                (playerPhotoData, error) in
                
                cell.playerPhoto = UIImage(data: playerPhotoData!) ?? #imageLiteral(resourceName: "personal_default")
            }
        }
        
        cell.backNumber = playerList[indexPath.row].backNumber
        cell.name = playerList[indexPath.row].name
        cell.moreButton.tag = indexPath.row
        cell.moreButton.addTarget(
            self,
            action: #selector(moreButtonDidTapped(_:)),
            for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.frame.size.height * 80/736).rounded()
    }
}
