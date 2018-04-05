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
    
    var teamLogo:UIImage = UIImage()
    var teamName:String = "홈베이스"
    var teamCode:String = ""
    
    @IBOutlet private var teamLogoImageView: UIImageView!
    @IBOutlet private var teamNameLabel: UILabel!
    @IBOutlet private var teamCodeLabel: UILabel!
    @IBOutlet private var copyButton: UIButton!
    
    // MARK: Methods
    
    @IBAction private func copyButtonDidTapped(_ sender: UIButton) {
        UIPasteboard.general.string = teamCode
        
        guard let registerTeamCompleteCopyViewController =
            self.storyboard?.instantiateViewController(
                withIdentifier: "RegisterTeamCompleteCopyViewController")
                as? RegisterTeamCompleteCopyViewController else { return }
            
        registerTeamCompleteCopyViewController.modalPresentationStyle = .overCurrentContext
        self.present(
            registerTeamCompleteCopyViewController,
            animated: false,
            completion: nil)
    }
    
    @IBAction private func doneButtonDidTapped(_ sender: UIButton) {
        guard let registerUserNavigation =
            self.storyboard?.instantiateViewController(
                withIdentifier: "RegisterUserNavigation")
                as? RegisterUserNavigation else { return }
            
        registerUserNavigation.teamCode = teamCode
        self.present(registerUserNavigation, animated: true, completion: nil)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamLogoImageView.image = teamLogo
        teamNameLabel.text = "\(teamName)의 팀 코드는"
        teamCodeLabel.text = teamCode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        teamLogoImageView.layer.cornerRadius = teamLogoImageView.frame.size.height / 2
        teamLogoImageView.layer.borderColor = HBColor.lightGray.cgColor
        teamLogoImageView.layer.borderWidth = 1.0
        
        copyButton.layer.borderWidth = 2.0
        copyButton.layer.borderColor = HBColor.lightGray.cgColor
    }
}
