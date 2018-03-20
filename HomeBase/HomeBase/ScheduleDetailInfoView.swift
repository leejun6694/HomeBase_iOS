//
//  ScheduleDetailInfoView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 28..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleDetailInfoView: UIView {

    // MARK: Properties
    
    var homeTeamScore = 0
    var opponentTeamScore = 0
    
    var opponentTeam: String = "" {
        didSet {
            opponentTeamLabel.text = opponentTeam
        }
    }
    
    var matchDate: Date = Date() {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko-KR")
            dateFormatter.dateFormat = "MM"
            let month = dateFormatter.string(from: matchDate)
            dateFormatter.dateFormat = "dd"
            let day = dateFormatter.string(from: matchDate)
            dateFormatter.dateFormat = "EEEE"
            let dayOfWeek = dateFormatter.string(from: matchDate)
            dateFormatter.dateFormat = "a hh:mm"
            let time = dateFormatter.string(from: matchDate)
            
            matchDateLabel.text = "\(month)월 \(day)일 \(dayOfWeek) \(time)"
        }
    }
    
    var matchPlace: String = "" {
        didSet {
            matchPlaceLabel.text = matchPlace
        }
    }
    
    private lazy var opponentTeamLabel: UILabel = {
        let opponentTeamLabel = UILabel()
        opponentTeamLabel.text = "HomeBase"
        opponentTeamLabel.textColor = UIColor(red: 0.0,
                                              green: 180.0/255.0,
                                              blue: 223.0/255.0,
                                              alpha: 1.0)
        opponentTeamLabel.textAlignment = .center
        opponentTeamLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 26.0)
        opponentTeamLabel.adjustsFontSizeToFitWidth = true
        opponentTeamLabel.minimumScaleFactor = 0.5
        opponentTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return opponentTeamLabel
    }()
    
    private lazy var matchDateLabel: UILabel = {
        let matchDateLabel = UILabel()
        matchDateLabel.text = "2월 20일 토요일 오전 9:00"
        matchDateLabel.textColor = .white
        matchDateLabel.textAlignment = .center
        matchDateLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13.0)
        matchDateLabel.adjustsFontSizeToFitWidth = true
        matchDateLabel.minimumScaleFactor = 0.5
        matchDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return matchDateLabel
    }()
    
    private lazy var matchPlaceLabel: UILabel = {
        let matchPlaceLabel = UILabel()
        matchPlaceLabel.text = "홈베이스 야구장"
        matchPlaceLabel.textColor = .white
        matchPlaceLabel.textAlignment = .center
        matchPlaceLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13.0)
        matchPlaceLabel.adjustsFontSizeToFitWidth = true
        matchPlaceLabel.minimumScaleFactor = 0.5
        matchPlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return matchPlaceLabel
    }()
    
    private lazy var homeTeamButton: UIButton = {
        let homeTeamButton = UIButton(type: .system)
        homeTeamButton.setTitle("home", for: .normal)
        homeTeamButton.setTitleColor(UIColor.white, for: .normal)
        homeTeamButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular",
                                                 size: 28.0)
        homeTeamButton.titleLabel?.adjustsFontSizeToFitWidth = true
        homeTeamButton.titleLabel?.minimumScaleFactor = 0.3
        homeTeamButton.backgroundColor = UIColor.clear
        homeTeamButton.translatesAutoresizingMaskIntoConstraints = false
        
        return homeTeamButton
    }()
    
    private lazy var versusLabel: UILabel = {
        let versusLabel = UILabel()
        versusLabel.text = "vs"
        versusLabel.textColor = .white
        versusLabel.textAlignment = .center
        versusLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 28.0)
        versusLabel.adjustsFontSizeToFitWidth = true
        versusLabel.minimumScaleFactor = 0.5
        versusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return versusLabel
    }()
    
    private lazy var opponentTeamButton: UIButton = {
        let opponentTeamButton = UIButton(type: .system)
        opponentTeamButton.setTitle("opponent", for: .normal)
        opponentTeamButton.setTitleColor(UIColor.white, for: .normal)
        opponentTeamButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular",
                                                     size: 28.0)
        opponentTeamButton.titleLabel?.adjustsFontSizeToFitWidth = true
        opponentTeamButton.titleLabel?.minimumScaleFactor = 0.3
        opponentTeamButton.backgroundColor = UIColor.clear
        opponentTeamButton.translatesAutoresizingMaskIntoConstraints = false
        
        return opponentTeamButton
    }()
    
    // MARK: Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(opponentTeamLabel)
        self.addConstraints(opponentTeamLabelConstraints())
        self.addSubview(matchDateLabel)
        self.addConstraints(matchDateLabelConstraints())
        self.addSubview(matchPlaceLabel)
        self.addConstraints(matchPlaceLabelConstraints())
        self.addSubview(homeTeamButton)
        self.addConstraints(homeTeamButtonConstraints())
        self.addSubview(versusLabel)
        self.addConstraints(versusLabelConstraints())
        self.addSubview(opponentTeamButton)
        self.addConstraints(opponentTeamButtonConstraints())
    }
}

extension ScheduleDetailInfoView {
    private func opponentTeamLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 48/119, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 250/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 35/238, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func matchDateLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: matchDateLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: matchDateLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 85/119, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: matchDateLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 250/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: matchDateLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 16/238, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func matchPlaceLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: matchPlaceLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: matchPlaceLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 104/119, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: matchPlaceLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 250/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: matchPlaceLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 16/238, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func homeTeamButtonConstraints() -> [NSLayoutConstraint] {
        let trailingConstraint = NSLayoutConstraint(
            item: homeTeamButton, attribute: .trailing, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 169/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: homeTeamButton, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 143/119, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: homeTeamButton, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 139/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: homeTeamButton, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 50/238, constant: 0.0)
        
        return [trailingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func versusLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: versusLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: versusLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 169.5/119, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: versusLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 25/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: versusLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 28/238, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func opponentTeamButtonConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: opponentTeamButton, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 246/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: opponentTeamButton, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 143/119, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: opponentTeamButton, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 139/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: opponentTeamButton, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 50/238, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
}
