//
//  TeamSettingTeamDataViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 6. 4..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class TeamSettingTeamDataViewController: UIViewController {

    // MARK: Properties
    
    var teamData: HBTeam!
    var teamLogo: UIImage!
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "팀 설정"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    private lazy var doneButton: UIBarButtonItem = {
        let doneButton = UIBarButtonItem(
            title: "확인",
            style: .plain,
            target: self,
            action: #selector(doneButtonDidTapped(_:)))
        doneButton.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)!,
            NSAttributedStringKey.foregroundColor : UIColor.white], for: .normal)
        
        return doneButton
    }()
    
    private lazy var teamPhotoImageView: UIImageView =  {
        let teamPhotoImageView = UIImageView(image: #imageLiteral(resourceName: "backgroundMain"))
        teamPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return teamPhotoImageView
    }()
    
    private lazy var teamPhotoSettingImageView: UIImageView =  {
        let teamPhotoSettingImageView = UIImageView()
        teamPhotoSettingImageView.backgroundColor = .white
        teamPhotoSettingImageView.layer.borderColor =
            UIColor.black.withAlphaComponent(0.15).cgColor
        teamPhotoSettingImageView.layer.borderWidth = 1.0
        teamPhotoSettingImageView.clipsToBounds = true
        teamPhotoSettingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return teamPhotoSettingImageView
    }()
    
    private lazy var teamLogoImageView: UIImageView = {
        let teamLogoImageView = UIImageView(image: teamLogo)
        teamLogoImageView.layer.borderColor =
            UIColor.black.withAlphaComponent(0.15).cgColor
        teamLogoImageView.layer.borderWidth = 1.0
        teamLogoImageView.clipsToBounds = true
        teamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return teamLogoImageView
    }()
    
    private lazy var teamLogoSettingImageView: UIImageView =  {
        let teamLogoSettingImageView = UIImageView()
        teamLogoSettingImageView.backgroundColor = .white
        teamLogoSettingImageView.layer.borderColor =
            UIColor.black.withAlphaComponent(0.15).cgColor
        teamLogoSettingImageView.layer.borderWidth = 1.0
        teamLogoSettingImageView.clipsToBounds = true
        teamLogoSettingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return teamLogoSettingImageView
    }()
    
    // MARK: Methods
    
    @objc private func doneButtonDidTapped(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = HBColor.lightGray
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.backBarButtonItem =
            UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = doneButton
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.barTintColor = UIColor.clear
            navigationController.navigationBar.shadowImage = UIImage()
            navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
        
        self.view.addSubview(teamPhotoImageView)
        self.view.addConstraints(teamPhotoImageViewConstraints())
        self.view.addSubview(teamLogoImageView)
        self.view.addConstraints(teamLogoImageViewConstraints())
        self.view.addSubview(teamPhotoSettingImageView)
        self.view.addConstraints(teamPhotoSettingImageViewConstraints())
        self.view.addSubview(teamLogoSettingImageView)
        self.view.addConstraints(teamLogoSettingImageViewConstraints())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = self.navigationController {
            navigationController.hidesBarsOnSwipe = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        teamLogoImageView.layer.cornerRadius = teamLogoImageView.frame.size.height / 2
        teamPhotoSettingImageView.layer.cornerRadius =
            teamPhotoSettingImageView.frame.size.height / 2
        teamLogoSettingImageView.layer.cornerRadius =
            teamLogoSettingImageView.frame.size.height / 2
    }
}

extension TeamSettingTeamDataViewController {
    private func teamPhotoImageViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: teamPhotoImageView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: teamPhotoImageView, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: teamPhotoImageView, attribute: .trailing, relatedBy: .equal,
            toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamPhotoImageView, attribute: .height, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .width, multiplier: 280/414, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, heightConstraint]
    }
    
    private func teamPhotoSettingImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: teamPhotoSettingImageView, attribute: .centerX, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .centerX, multiplier: 377/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: teamPhotoSettingImageView, attribute: .centerY, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .centerY, multiplier: 250/140, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamPhotoSettingImageView, attribute: .width, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .width, multiplier: 36/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamPhotoSettingImageView, attribute: .height, relatedBy: .equal,
            toItem: teamPhotoSettingImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamLogoImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .centerX, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .centerY, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .centerY, multiplier: 276/140, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .width, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .width, multiplier: 120/414, constant: 1.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .height, relatedBy: .equal,
            toItem: teamLogoImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamLogoSettingImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: teamLogoSettingImageView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 253/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: teamLogoSettingImageView, attribute: .centerY, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .centerY, multiplier: 316/140, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamLogoSettingImageView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 36/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamLogoSettingImageView, attribute: .height, relatedBy: .equal,
            toItem: teamLogoSettingImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
