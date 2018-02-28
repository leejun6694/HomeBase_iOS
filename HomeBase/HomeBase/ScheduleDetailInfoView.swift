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
    }
}

extension ScheduleDetailInfoView {
    private func opponentTeamLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 50.5/119, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 250/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 30/238, constant: 0.0)
        
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
}
