//
//  RegisterTeamCompleteViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 31..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class RegisterTeamCompleteViewController: UIViewController {

    // MARK: Properties
    
    var teamName:String!
    var teamCode:String!
    
    @IBOutlet var teamLogoImageView: UIImageView!
    @IBOutlet var teamNameLabel: UILabel!
    @IBOutlet var teamCodeLabel: UILabel!
    @IBOutlet var copyButton: UIButton! {
        didSet {
            copyButton.layer.borderWidth = 2.0
            copyButton.layer.borderColor = UIColor(red: 44.0/255.0,
                                                   green: 44.0/255.0,
                                                   blue: 44.0/255.0,
                                                   alpha: 1.0).cgColor
        }
    }
    
    // MARK: Methods
    
    @IBAction func copyButtonDidTapped(_ sender: UIButton) {
    }
    
    @IBAction func doneButtonDidTapped(_ sender: UIButton) {
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        teamLogoImageView.layer.cornerRadius = teamLogoImageView.frame.size.height / 2
    }
}
