//
//  MainNextScheduleView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 11..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class MainNextScheduleView: UIView {

    // MARK: Properties
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = HBColor.lightBlack
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private lazy var nextScheduleLabel: UILabel = {
        let nextScheduleLabel = UILabel()
        nextScheduleLabel.text = "다음\n일정"
        nextScheduleLabel.textColor = HBColor.lightGray
        nextScheduleLabel.numberOfLines = 2
        nextScheduleLabel.textAlignment = .center
        nextScheduleLabel.font = UIFont(
            name: "AppleSDGothicNeo-Light",
            size: 25.0)
        nextScheduleLabel.adjustsFontSizeToFitWidth = true
        nextScheduleLabel.minimumScaleFactor = 0.5
        nextScheduleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nextScheduleLabel
    }()
    
    private lazy var dayLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.text = "20"
        dayLabel.textColor = HBColor.lightGray
        dayLabel.textAlignment = .center
        dayLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 31.0)
        dayLabel.adjustsFontSizeToFitWidth = true
        dayLabel.minimumScaleFactor = 0.5
        dayLabel.numberOfLines = 1
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dayLabel
    }()
    
    private lazy var dayOfWeekLabel: UILabel = {
        let dayOfWeekLabel = UILabel()
        dayOfWeekLabel.text = "토요일"
        dayOfWeekLabel.textColor = HBColor.lightGray
        dayOfWeekLabel.textAlignment = .center
        dayOfWeekLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13.0)
        dayOfWeekLabel.adjustsFontSizeToFitWidth = true
        dayOfWeekLabel.minimumScaleFactor = 0.5
        dayOfWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dayOfWeekLabel
    }()
    
    private lazy var divisionView: UIView = {
        let divisionView = UIView()
        divisionView.backgroundColor = UIColor(
            red: 151,
            green: 151,
            blue: 151,
            alpha: 1.0)
        divisionView.translatesAutoresizingMaskIntoConstraints = false
        
        return divisionView
    }()
    
    private lazy var opponentTeamLabel: UILabel = {
        let opponentTeamLabel = UILabel()
        opponentTeamLabel.text = "HomeBase"
        opponentTeamLabel.textColor = HBColor.lightGray
        opponentTeamLabel.textAlignment = .left
        opponentTeamLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        opponentTeamLabel.adjustsFontSizeToFitWidth = true
        opponentTeamLabel.minimumScaleFactor = 0.5
        opponentTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return opponentTeamLabel
    }()
    
    private lazy var matchDateLabel: UILabel = {
        let matchDateLabel = UILabel()
        matchDateLabel.text = "2월 20일 토요일 오전 9:00"
        matchDateLabel.textColor = HBColor.lightGray
        matchDateLabel.textAlignment = .left
        matchDateLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12.0)
        matchDateLabel.adjustsFontSizeToFitWidth = true
        matchDateLabel.minimumScaleFactor = 0.5
        matchDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return matchDateLabel
    }()
    
    private lazy var matchPlaceLabel: UILabel = {
        let matchPlaceLabel = UILabel()
        matchPlaceLabel.text = "홈베이스 야구장"
        matchPlaceLabel.textColor = HBColor.lightGray
        matchPlaceLabel.textAlignment = .left
        matchPlaceLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 12.0)
        matchPlaceLabel.adjustsFontSizeToFitWidth = true
        matchPlaceLabel.minimumScaleFactor = 0.5
        matchPlaceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return matchPlaceLabel
    }()
    
    private lazy var nextButton: UIButton = {
        let nextButtom = UIButton()
        nextButtom.setImage(#imageLiteral(resourceName: "nextIcon"), for: .normal)
        nextButtom.translatesAutoresizingMaskIntoConstraints = false
        
        return nextButtom
    }()
    
    // MARK: Draw
    
    override func layoutSubviews() {
        self.addSubview(contentView)
        self.addConstraints(contentViewConstraints())
        contentView.addSubview(nextScheduleLabel)
        contentView.addConstraints(nextScheduleLabelConstraints())
        contentView.addSubview(dayLabel)
        contentView.addConstraints(dayLabelConstraints())
        contentView.addSubview(dayOfWeekLabel)
        contentView.addConstraints(dayOfWeekLabelConstraints())
        contentView.addSubview(divisionView)
        contentView.addConstraints(divisionViewConstraints())
        contentView.addSubview(opponentTeamLabel)
        contentView.addConstraints(opponentTeamLabelConstraints())
        contentView.addSubview(matchDateLabel)
        contentView.addConstraints(matchDateLabelConstraints())
        contentView.addSubview(matchPlaceLabel)
        contentView.addConstraints(matchPlaceLabelConstraints())
        contentView.addSubview(nextButton)
        contentView.addConstraints(nextButtonConstraints())
    }
}

extension MainNextScheduleView {
    private func contentViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: contentView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: contentView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstrinat = NSLayoutConstraint(
            item: contentView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: contentView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstrinat, heightConstraint]
    }
    
    private func nextScheduleLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: nextScheduleLabel, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 12/53.5, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: nextScheduleLabel, attribute: .leading, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 31/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: nextScheduleLabel, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 44/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: nextScheduleLabel, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 61/107, constant: 0.0)
        
        return [topConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func dayLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: dayLabel, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 15/53.5, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: dayLabel, attribute: .leading, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 108/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: dayLabel, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 37/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: dayLabel, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 26/107, constant: 0.0)
        
        return [topConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func dayOfWeekLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: dayOfWeekLabel, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 49/53.5, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: dayOfWeekLabel, attribute: .leading, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 109/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: dayOfWeekLabel, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 34/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: dayOfWeekLabel, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 10/107, constant: 0.0)
        
        return [topConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func divisionViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .centerX, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 161.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .centerY, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 1/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 79/107, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func opponentTeamLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 15/53.5, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .leading, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 179/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 160/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 25/107, constant: 0.0)
        
        return [topConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func matchDateLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: matchDateLabel, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 51/53.5, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: matchDateLabel, attribute: .leading, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 179/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: matchDateLabel, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 150/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: matchDateLabel, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 10/107, constant: 0.0)
        
        return [topConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func matchPlaceLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: matchPlaceLabel, attribute: .top, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 68/53.5, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: matchPlaceLabel, attribute: .leading, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 179/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: matchPlaceLabel, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 130/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: matchPlaceLabel, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 10/107, constant: 0.0)
        
        return [topConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func nextButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: nextButton, attribute: .centerX, relatedBy: .equal,
            toItem: contentView, attribute: .centerX, multiplier: 372.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: nextButton, attribute: .centerY, relatedBy: .equal,
            toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: nextButton, attribute: .width, relatedBy: .equal,
            toItem: contentView, attribute: .width, multiplier: 35/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: nextButton, attribute: .height, relatedBy: .equal,
            toItem: contentView, attribute: .height, multiplier: 40/107, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
