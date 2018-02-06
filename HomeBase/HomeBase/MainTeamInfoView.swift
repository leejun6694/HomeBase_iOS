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
    
    lazy var teamLogoImageView:UIImageView = {
        let teamLogoImageView = UIImageView(image: #imageLiteral(resourceName: "team_logo"))
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
    
    private lazy var teamSinceView:UIView = {
        let teamSinceView = UIView()
        teamSinceView.backgroundColor = UIColor(red: 0.0,
                                                green: 180.0/255.0,
                                                blue: 223.0/255.0,
                                                alpha: 1.0)
        teamSinceView.layer.cornerRadius = 13.0
        teamSinceView.clipsToBounds = true
        teamSinceView.translatesAutoresizingMaskIntoConstraints = false
        
        return teamSinceView
    }()
    
    private lazy var teamSinceLabel:UILabel = {
        let teamSinceLabel = UILabel()
        teamSinceLabel.text = "Since 2002"
        teamSinceLabel.textColor = .white
        teamSinceLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.0)
        teamSinceLabel.textAlignment = .center
        teamSinceLabel.adjustsFontSizeToFitWidth = true
        teamSinceLabel.minimumScaleFactor = 0.5
        teamSinceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return teamSinceLabel
    }()
    
    private lazy var teamHomeStadiumLabel:UILabel = {
        let teamHomeStadiumLabel = UILabel()
        teamHomeStadiumLabel.text = "홈베이스 야구장"
        teamHomeStadiumLabel.textColor = .white
        teamHomeStadiumLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12.0)
        teamHomeStadiumLabel.textAlignment = .center
        teamHomeStadiumLabel.adjustsFontSizeToFitWidth = true
        teamHomeStadiumLabel.minimumScaleFactor = 0.5
        teamHomeStadiumLabel.backgroundColor = UIColor(red: 44.0/255.0,
                                                 green: 44.0/255.0,
                                                 blue: 44.0/255.0,
                                                 alpha: 1.0)
        teamHomeStadiumLabel.layer.cornerRadius = 13.0
        teamHomeStadiumLabel.clipsToBounds = true
        teamHomeStadiumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return teamHomeStadiumLabel
    }()
    
    private lazy var teamRecordBaseView:UIView = {
        let teamRecordBaseView = UIView()
        teamRecordBaseView.backgroundColor = UIColor(red: 44.0/255.0,
                                                 green: 44.0/255.0,
                                                 blue: 44.0/255.0,
                                                 alpha: 1.0)
        teamRecordBaseView.layer.cornerRadius = 13.0
        teamRecordBaseView.clipsToBounds = true
        teamRecordBaseView.translatesAutoresizingMaskIntoConstraints = false
        
        return teamRecordBaseView
    }()
    
    private lazy var winLabel:UILabel = {
        let winLabel = UILabel()
        winLabel.text = "승"
        winLabel.textColor = .white
        winLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13.0)
        winLabel.adjustsFontSizeToFitWidth = true
        winLabel.minimumScaleFactor = 0.5
        winLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return winLabel
    }()
    
    private lazy var winRecordLabel:UILabel = {
        let winRecordLabel = UILabel()
        winRecordLabel.text = "20"
        winRecordLabel.textColor = .white
        winRecordLabel.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 27.0)
        winRecordLabel.adjustsFontSizeToFitWidth = true
        winRecordLabel.minimumScaleFactor = 0.5
        winRecordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return winRecordLabel
    }()
    
    private lazy var drawLabel:UILabel = {
        let drawLabel = UILabel()
        drawLabel.text = "무"
        drawLabel.textColor = .white
        drawLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13.0)
        drawLabel.adjustsFontSizeToFitWidth = true
        drawLabel.minimumScaleFactor = 0.5
        drawLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return drawLabel
    }()
    
    private lazy var drawRecordLabel:UILabel = {
        let drawRecordLabel = UILabel()
        drawRecordLabel.text = "20"
        drawRecordLabel.textColor = .white
        drawRecordLabel.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 27.0)
        drawRecordLabel.adjustsFontSizeToFitWidth = true
        drawRecordLabel.minimumScaleFactor = 0.5
        drawRecordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return drawRecordLabel
    }()
    
    private lazy var loseLabel:UILabel = {
        let loseLabel = UILabel()
        loseLabel.text = "패"
        loseLabel.textColor = .white
        loseLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13.0)
        loseLabel.adjustsFontSizeToFitWidth = true
        loseLabel.minimumScaleFactor = 0.5
        loseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return loseLabel
    }()
    
    private lazy var loseRecordLabel:UILabel = {
        let loseRecordLabel = UILabel()
        loseRecordLabel.text = "20"
        loseRecordLabel.textColor = .white
        loseRecordLabel.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 27.0)
        loseRecordLabel.adjustsFontSizeToFitWidth = true
        loseRecordLabel.minimumScaleFactor = 0.5
        loseRecordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return loseRecordLabel
    }()
    
    private lazy var teamAverageBaseView:UIView = {
        let teamAverageBaseView = UIView()
        teamAverageBaseView.backgroundColor = UIColor(red: 44.0/255.0,
                                                     green: 44.0/255.0,
                                                     blue: 44.0/255.0,
                                                     alpha: 1.0)
        teamAverageBaseView.layer.cornerRadius = 13.0
        teamAverageBaseView.clipsToBounds = true
        teamAverageBaseView.translatesAutoresizingMaskIntoConstraints = false
        
        return teamAverageBaseView
    }()
    
    private lazy var teamERAverageLabel:UILabel = {
        let teamERAverageLabel = UILabel()
        teamERAverageLabel.text = "방어율"
        teamERAverageLabel.textColor = .white
        teamERAverageLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13.0)
        teamERAverageLabel.adjustsFontSizeToFitWidth = true
        teamERAverageLabel.minimumScaleFactor = 0.5
        teamERAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return teamERAverageLabel
    }()
    
    private lazy var teamERAverageRecordLabel:UILabel = {
        let teamERAverageRecordLabel = UILabel()
        teamERAverageRecordLabel.text = "3.66"
        teamERAverageRecordLabel.textColor = .white
        teamERAverageRecordLabel.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 27.0)
        teamERAverageRecordLabel.adjustsFontSizeToFitWidth = true
        teamERAverageRecordLabel.minimumScaleFactor = 0.5
        teamERAverageRecordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return teamERAverageRecordLabel
    }()
    
    private lazy var teamBattingAverageLabel:UILabel = {
        let teamBattingAverageLabel = UILabel()
        teamBattingAverageLabel.text = "타율"
        teamBattingAverageLabel.textColor = .white
        teamBattingAverageLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13.0)
        teamBattingAverageLabel.adjustsFontSizeToFitWidth = true
        teamBattingAverageLabel.minimumScaleFactor = 0.5
        teamBattingAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return teamBattingAverageLabel
    }()
    
    private lazy var teamBattingAverageRecordLabel:UILabel = {
        let teamBattingAverageRecordLabel = UILabel()
        teamBattingAverageRecordLabel.text = "0.365"
        teamBattingAverageRecordLabel.textColor = .white
        teamBattingAverageRecordLabel.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 27.0)
        teamBattingAverageRecordLabel.adjustsFontSizeToFitWidth = true
        teamBattingAverageRecordLabel.minimumScaleFactor = 0.5
        teamBattingAverageRecordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return teamBattingAverageRecordLabel
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
        contentView.addSubview(teamSinceView)
        contentView.addConstraints(teamSinceViewConstraints())
        teamSinceView.addSubview(teamSinceLabel)
        teamSinceView.addConstraints(teamSinceLabelConstraints())
        contentView.addSubview(teamHomeStadiumLabel)
        contentView.addConstraints(teamHomeStadiumLabelConstraints())
        contentView.addSubview(teamRecordBaseView)
        contentView.addConstraints(teamRecordBaseViewConstraints())
        teamRecordBaseView.addSubview(winLabel)
        teamRecordBaseView.addConstraints(winLabelConstraints())
        teamRecordBaseView.addSubview(winRecordLabel)
        teamRecordBaseView.addConstraints(winRecordLabelConstraints())
        teamRecordBaseView.addSubview(drawLabel)
        teamRecordBaseView.addConstraints(drawLabelConstraints())
        teamRecordBaseView.addSubview(drawRecordLabel)
        teamRecordBaseView.addConstraints(drawRecordLabelConstraints())
        teamRecordBaseView.addSubview(loseLabel)
        teamRecordBaseView.addConstraints(loseLabelConstraints())
        teamRecordBaseView.addSubview(loseRecordLabel)
        teamRecordBaseView.addConstraints(loseRecordLabelConstraints())
        contentView.addSubview(teamAverageBaseView)
        contentView.addConstraints(teamAverageBaseViewConstraints())
        teamAverageBaseView.addSubview(teamERAverageLabel)
        teamAverageBaseView.addConstraints(teamERAverageLabelConstraints())
        teamAverageBaseView.addSubview(teamERAverageRecordLabel)
        teamAverageBaseView.addConstraints(teamERAverageRecordLabelConstraints())
        teamAverageBaseView.addSubview(teamBattingAverageLabel)
        teamAverageBaseView.addConstraints(teamBattingAverageLabelConstraints())
        teamAverageBaseView.addSubview(teamBattingAverageRecordLabel)
        teamAverageBaseView.addConstraints(teamBattingAverageRecordLabelConstraints())
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        teamLogoImageView.layer.cornerRadius = teamLogoImageView.frame.size.height / 2
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
            toItem: teamPhotoImageView, attribute: .width, multiplier: 120/414, constant: 1.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .height, relatedBy: .equal,
            toItem: teamLogoImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamNameLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: teamNameLabel, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 78/181, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: teamNameLabel, attribute: .centerX, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamNameLabel, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 200/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamNameLabel, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 30/362, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamIntroLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: teamIntroLabel, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 112/181, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: teamIntroLabel, attribute: .centerX, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamIntroLabel, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 200/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamIntroLabel, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 17/362, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamSinceViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: teamSinceView, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 172/181, constant: 0.0)
        let centerXConstrinat = NSLayoutConstraint(
            item: teamSinceView, attribute: .centerX, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 271.5/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamSinceView, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 157/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamSinceView, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 30/362, constant: 0.0)
        
        return [topConstraint, centerXConstrinat, widthConstraint, heightConstraint]
    }
    
    private func teamSinceLabelConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: teamSinceLabel, attribute: .centerY, relatedBy: .equal,
            toItem: teamSinceView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstrinat = NSLayoutConstraint(
            item: teamSinceLabel, attribute: .leading, relatedBy: .equal,
            toItem: teamSinceView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamSinceLabel, attribute: .width, relatedBy: .equal,
            toItem: teamSinceView, attribute: .width, multiplier: 60/157, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamSinceLabel, attribute: .height, relatedBy: .equal,
            toItem: teamSinceView, attribute: .height, multiplier: 15/30, constant: 0.0)
        
        return [centerYConstraint, leadingConstrinat, widthConstraint, heightConstraint]
    }
    
    private func teamHomeStadiumLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: teamHomeStadiumLabel, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 172/181, constant: 0.0)
        let centerXConstrinat = NSLayoutConstraint(
            item: teamHomeStadiumLabel, attribute: .centerX, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 160.5/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamHomeStadiumLabel, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 191/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamHomeStadiumLabel, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 30/362, constant: 0.0)
        
        return [topConstraint, centerXConstrinat, widthConstraint, heightConstraint]
    }
    
    private func teamRecordBaseViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: teamRecordBaseView, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 233/181, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: teamRecordBaseView, attribute: .centerX, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamRecordBaseView, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 373/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamRecordBaseView, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 50/362, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func winLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: winLabel, attribute: .leading, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .centerX, multiplier: 56/186.5, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: winLabel, attribute: .centerY, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: winLabel, attribute: .width, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .width, multiplier: 12/373, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: winLabel, attribute: .height, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .height, multiplier: 13/50, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func winRecordLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: winRecordLabel, attribute: .leading, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .centerX, multiplier: 86/186.5, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: winRecordLabel, attribute: .centerY, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: winRecordLabel, attribute: .width, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .width, multiplier: 75/373, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: winRecordLabel, attribute: .height, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .height, multiplier: 27/50, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func drawLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: drawLabel, attribute: .leading, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .centerX, multiplier: 157/186.5, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: drawLabel, attribute: .centerY, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: drawLabel, attribute: .width, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .width, multiplier: 12/373, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: drawLabel, attribute: .height, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .height, multiplier: 13/50, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func drawRecordLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: drawRecordLabel, attribute: .leading, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .centerX, multiplier: 182/186.5, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: drawRecordLabel, attribute: .centerY, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: drawRecordLabel, attribute: .width, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .width, multiplier: 75/373, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: drawRecordLabel, attribute: .height, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .height, multiplier: 27/50, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func loseLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: loseLabel, attribute: .leading, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .centerX, multiplier: 257/186.5, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: loseLabel, attribute: .centerY, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: loseLabel, attribute: .width, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .width, multiplier: 12/373, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: loseLabel, attribute: .height, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .height, multiplier: 13/50, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func loseRecordLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: loseRecordLabel, attribute: .leading, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .centerX, multiplier: 285/186.5, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: loseRecordLabel, attribute: .centerY, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: loseRecordLabel, attribute: .width, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .width, multiplier: 75/373, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: loseRecordLabel, attribute: .height, relatedBy: .equal,
            toItem: teamRecordBaseView, attribute: .height, multiplier: 27/50, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamAverageBaseViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: teamAverageBaseView, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 291/181, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: teamAverageBaseView, attribute: .centerX, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamAverageBaseView, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 373/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamAverageBaseView, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 50/362, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamERAverageLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: teamERAverageLabel, attribute: .leading, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .centerX, multiplier: 56/186.5, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: teamERAverageLabel, attribute: .centerY, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamERAverageLabel, attribute: .width, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .width, multiplier: 34/373, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamERAverageLabel, attribute: .height, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .height, multiplier: 13/50, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamERAverageRecordLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: teamERAverageRecordLabel, attribute: .leading, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .centerX, multiplier: 106/186.5, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: teamERAverageRecordLabel, attribute: .centerY, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamERAverageRecordLabel, attribute: .width, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .width, multiplier: 75/373, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamERAverageRecordLabel, attribute: .height, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .height, multiplier: 27/50, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamBattingAverageLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: teamBattingAverageLabel, attribute: .leading, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .centerX, multiplier: 211/186.5, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: teamBattingAverageLabel, attribute: .centerY, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamBattingAverageLabel, attribute: .width, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .width, multiplier: 34/373, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamBattingAverageLabel, attribute: .height, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .height, multiplier: 13/50, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func teamBattingAverageRecordLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: teamBattingAverageRecordLabel, attribute: .leading, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .centerX, multiplier: 249/186.5, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: teamBattingAverageRecordLabel, attribute: .centerY, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamBattingAverageRecordLabel, attribute: .width, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .width, multiplier: 75/373, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamBattingAverageRecordLabel, attribute: .height, relatedBy: .equal,
            toItem: teamAverageBaseView, attribute: .height, multiplier: 27/50, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
