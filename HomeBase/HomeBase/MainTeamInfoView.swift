//
//  MainTeamInfoView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 6..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class MainTeamInfoView: UIView {
    
    // MARK: Properties
    
    private lazy var teamPhotoImageView:UIImageView =  {
        let teamPhotoImageView = UIImageView(image: #imageLiteral(resourceName: "backgroundMain"))
        teamPhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return teamPhotoImageView
    }()
    
    private lazy var contentView:UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private lazy var teamLogoImageView:UIImageView = {
        let teamLogoImageView = UIImageView(image: #imageLiteral(resourceName: "team_logo"))
        teamLogoImageView.layer.cornerRadius = teamLogoImageView.frame.size.width / 2
        teamLogoImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.15).cgColor
        teamLogoImageView.layer.borderWidth = 1.0
        teamLogoImageView.clipsToBounds = true
        teamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return teamLogoImageView
    }()
    
    private lazy var teamNameLabel:UILabel = {
        let teamNameLabel = UILabel()
        teamNameLabel.text = "HomeBase"
        teamNameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 25.0)
        teamNameLabel.textAlignment = .center
        teamNameLabel.adjustsFontSizeToFitWidth = true
        teamNameLabel.minimumScaleFactor = 0.5
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return teamNameLabel
    }()
    
    private lazy var teamIntroLabel:UILabel = {
        let teamIntroLabel = UILabel()
        teamIntroLabel.text = "우주최강 사회인 야구팀, 홈베이스"
        teamIntroLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.0)
        teamIntroLabel.textAlignment = .center
        teamIntroLabel.numberOfLines = 5
        teamIntroLabel.adjustsFontSizeToFitWidth = true
        teamIntroLabel.minimumScaleFactor = 0.5
        teamIntroLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return teamIntroLabel
    }()
    
    private lazy var teamSinceLabel:UILabel = {
        let teamSinceLabel = UILabel()
        teamSinceLabel.text = "Since 2002"
        teamSinceLabel.textColor = .white
        teamSinceLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.0)
        teamSinceLabel.textAlignment = .center
        teamSinceLabel.adjustsFontSizeToFitWidth = true
        teamSinceLabel.minimumScaleFactor = 0.5
        teamSinceLabel.backgroundColor = UIColor(red: 0.0,
                                             green: 180.0/255.0,
                                             blue: 223.0/255.0,
                                             alpha: 1.0)
        teamSinceLabel.layer.cornerRadius = 13.0
        teamSinceLabel.clipsToBounds = true
        teamSinceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return teamSinceLabel
    }()
    
    // MARK: Draw

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(teamPhotoImageView)
        self.addConstraints(teamPhotoImageViewConstraints())
        self.addSubview(contentView)
        self.addConstraints(contentViewConstraints())
        self.addSubview(teamLogoImageView)
        self.addConstraints(teamLogoImageViewConstraints())
        contentView.addSubview(teamNameLabel)
        contentView.addConstraints(teamNameLabelConstraints())
        contentView.addSubview(teamIntroLabel)
        contentView.addConstraints(teamIntroLabelConstraints())
        contentView.addSubview(teamSinceLabel)
        contentView.addConstraints(teamSinceLabelConstraints())
    }
}

extension MainTeamInfoView {
    private func teamPhotoImageViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: teamPhotoImageView, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: teamPhotoImageView, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: teamPhotoImageView, attribute: .trailing, relatedBy: .equal,
            toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamPhotoImageView, attribute: .height, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .width, multiplier: 280/414, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, heightConstraint]
    }
    
    private func contentViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: contentView, attribute: .top, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: contentView, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: contentView, attribute: .trailing, relatedBy: .equal,
            toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: contentView, attribute: .bottom, relatedBy: .equal,
            toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
    
    private func teamLogoImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .centerX, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .centerY, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .width, relatedBy: .equal,
            toItem: teamPhotoImageView, attribute: .width, multiplier: 130/414, constant: 1.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .height, relatedBy: .equal,
            toItem: teamLogoImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamNameLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: teamNameLabel, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 70/178, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: teamNameLabel, attribute: .centerX, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamNameLabel, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 200/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamNameLabel, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 30/356, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamIntroLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: teamIntroLabel, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 104/178, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: teamIntroLabel, attribute: .centerX, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamIntroLabel, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 200/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamIntroLabel, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 17/356, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamSinceLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: teamSinceLabel, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 143/178, constant: 0.0)
        let centerXConstrinat = NSLayoutConstraint(
            item: teamSinceLabel, attribute: .centerX, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 271.5/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamSinceLabel, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 157/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamSinceLabel, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 30/356, constant: 0.0)
        
        return [topConstraint, centerXConstrinat, widthConstraint, heightConstraint]
    }
}
