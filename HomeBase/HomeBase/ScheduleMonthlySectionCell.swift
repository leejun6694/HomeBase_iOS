//
//  ScheduleMonthlySectionCell.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 26..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseAuth

class ScheduleMonthlySectionCell: UITableViewCell {

    // MARK: Properties
    
    var teamData: HBTeam!
    
    var opponentTeam = "HomeBase" {
        didSet { opponentTeamLabel.text = opponentTeam}
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
            
            dayLabel.text = day
            dayOfWeekLabel.text = dayOfWeek
            matchDateLabel.text = "\(month)월 \(day)일 \(dayOfWeek) \(time)"
            
            if recordButton.isDescendant(of: baseView) {
                let currentDate = Date()
                if matchDate > currentDate {
                    recordButton.setTitle("경기 전", for: .normal)
                    recordButton.alpha = 0.5
                    recordButton.isEnabled = false
                } else {
                    recordButton.alpha = 1.0
                    recordButton.isEnabled = true
                    
                    if let currentUser = Auth.auth().currentUser {
                        if teamData.admin == currentUser.uid {
                            recordButton.setTitle("기록입력", for: .normal)
                        } else {
                            recordButton.setTitle("기록보기", for: .normal)
                        }
                    }
                }
            }
        }
    }
    var matchPlace = "" {
        didSet { matchPlaceLabel.text = matchPlace }
    }
    var homeScore = -1
    var opponentScore = -1
    var result = "-" {
        didSet {
            if recordButton.isDescendant(of: baseView) {
                recordButton.removeFromSuperview()
            }
            
            baseView.addSubview(recordView)
            baseView.addConstraints(recordViewConstraints())
            recordView.addSubview(scoreLabel)
            recordView.addConstraints(scoreLabelConstraints())
            recordView.addSubview(resultLabel)
            recordView.addConstraints(resultLabelConstraints())
            scoreLabel.text = "\(homeScore) : \(opponentScore)"
            resultLabel.text = "\(result)"
            
            if result == "승" {
                resultLabel.textColor = UIColor(red: 5,
                                                green: 62,
                                                blue: 88,
                                                alpha: 1.0)
            } else if result == "무" {
                resultLabel.textColor = HBColor.lightGray
            } else if result == "패" {
                resultLabel.textColor = UIColor(red: 237,
                                                green: 96,
                                                blue: 96,
                                                alpha: 1.0)
            } else {
                if recordView.isDescendant(of: baseView) {
                    recordView.removeFromSuperview()
                }
                baseView.addSubview(recordButton)
                baseView.addConstraints(recordButtonConstraints())
            }
        }
    }
    
    lazy var baseView: UIView = {
        let baseView = UIView()
        baseView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        
        return baseView
    }()
    
    private lazy var dayLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.text = "22"
        dayLabel.textColor = HBColor.lightGray
        dayLabel.textAlignment = .center
        dayLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 28.0)
        dayLabel.adjustsFontSizeToFitWidth = true
        dayLabel.minimumScaleFactor = 0.5
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
    
    private lazy var divisionView: UIView = {
        let divisionView = UIView()
        divisionView.backgroundColor = UIColor(red: 151, green: 151, blue: 151, alpha: 1.0)
        divisionView.translatesAutoresizingMaskIntoConstraints = false
        
        return divisionView
    }()
    
    lazy var recordButton: UIButton = {
        let recordButton = UIButton(type: .system)
        recordButton.setTitle("기록보기", for: .normal)
        recordButton.setTitleColor(HBColor.lightGray, for: .normal)
        recordButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15.0)
        recordButton.backgroundColor = UIColor.clear
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        
        return recordButton
    }()
    
    lazy var recordView: UIView = {
        let recordView = UIView()
        recordView.backgroundColor = .clear
        recordView.isUserInteractionEnabled = true
        recordView.translatesAutoresizingMaskIntoConstraints = false
        
        return recordView
    }()
    
    private lazy var scoreLabel: UILabel = {
        let scoreLabel = UILabel()
        scoreLabel.text = "0 : 0"
        scoreLabel.textColor = HBColor.lightGray
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 24.0)
        scoreLabel.adjustsFontSizeToFitWidth = true
        scoreLabel.minimumScaleFactor = 0.5
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return scoreLabel
    }()
    
    private lazy var resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.text = "무"
        resultLabel.textColor = HBColor.lightGray
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.0)
        resultLabel.adjustsFontSizeToFitWidth = true
        resultLabel.minimumScaleFactor = 0.5
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return resultLabel
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Draw
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor(red: 192, green: 222, blue: 229, alpha: 1.0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(baseView)
        self.addConstraints(baseViewConstraints())
        baseView.addSubview(dayLabel)
        baseView.addConstraints(dayLabelConstraints())
        baseView.addSubview(dayOfWeekLabel)
        baseView.addConstraints(dayOfWeekLabelConstraints())
        baseView.addSubview(opponentTeamLabel)
        baseView.addConstraints(opponentTeamLabelConstraints())
        baseView.addSubview(matchDateLabel)
        baseView.addConstraints(matchDateLabelConstraints())
        baseView.addSubview(matchPlaceLabel)
        baseView.addConstraints(matchPlaceLabelConstraints())
        baseView.addSubview(divisionView)
        baseView.addConstraints(divisionViewConstraints())
    }
}

extension ScheduleMonthlySectionCell {
    private func baseViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: baseView, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: baseView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: baseView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: baseView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func dayLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: dayLabel, attribute: .top, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 26.8/51.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: dayLabel, attribute: .centerX, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 52/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: dayLabel, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 35/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: dayLabel, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 35/103, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func dayOfWeekLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: dayOfWeekLabel, attribute: .top, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: dayOfWeekLabel, attribute: .centerX, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 52/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: dayOfWeekLabel, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 34/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: dayOfWeekLabel, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 29/103, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func opponentTeamLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .top, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 24.2/51.5, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .leading, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 109/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 160/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 25/103, constant: 0.0)
        
        return [topConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func matchDateLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: matchDateLabel, attribute: .top, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 55.1/51.5, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: matchDateLabel, attribute: .leading, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 109/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: matchDateLabel, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 150/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: matchDateLabel, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 10/103, constant: 0.0)
        
        return [topConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func matchPlaceLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: matchPlaceLabel, attribute: .top, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 72.2/51.5, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: matchPlaceLabel, attribute: .leading, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 109/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: matchPlaceLabel, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 130/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: matchPlaceLabel, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 10/103, constant: 0.0)
        
        return [topConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func divisionViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .centerX, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 316.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .centerY, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 1/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 55.8/103, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func recordButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: recordButton, attribute: .centerX, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 365.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: recordButton, attribute: .centerY, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: recordButton, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 70/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: recordButton, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 20/103, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func recordViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: recordView, attribute: .centerX, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 365.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: recordView, attribute: .centerY, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: recordView, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 76/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: recordView, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 57/103, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func scoreLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: scoreLabel, attribute: .centerX, relatedBy: .equal,
            toItem: recordView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: scoreLabel, attribute: .bottom, relatedBy: .equal,
            toItem: recordView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: scoreLabel, attribute: .width, relatedBy: .equal,
            toItem: recordView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: scoreLabel, attribute: .height, relatedBy: .equal,
            toItem: recordView, attribute: .height, multiplier: 0.5, constant: 0.0)
        
        return [centerXConstraint, bottomConstraint, widthConstraint, heightConstraint]
    }
    
    private func resultLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: resultLabel, attribute: .centerX, relatedBy: .equal,
            toItem: recordView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: resultLabel, attribute: .top, relatedBy: .equal,
            toItem: recordView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: resultLabel, attribute: .width, relatedBy: .equal,
            toItem: recordView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: resultLabel, attribute: .height, relatedBy: .equal,
            toItem: recordView, attribute: .height, multiplier: 0.5, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
}
