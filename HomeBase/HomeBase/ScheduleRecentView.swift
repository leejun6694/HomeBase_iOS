//
//  ScheduleRecentView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 23..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit
import FirebaseStorage

class ScheduleRecentView: UIView {

    // MARK: Properties
    
    var teamData: HBTeam!
    var teamLogo: UIImage!
    
    var scheduleCount: Int = 0 {
        didSet {
            if scheduleCount == 0 {
                if recordStackView.isDescendant(of: self) {
                    recordStackView.removeFromSuperview()
                }
                
                self.addSubview(noDataLabel)
                self.addConstraints(noDataLabelConstraints())
            } else {
                if noDataLabel.isDescendant(of: self) {
                    noDataLabel.removeFromSuperview()
                }
                
                self.addSubview(recordStackView)
                self.addConstraints(recordStackViewConstraints())
            }
        }
    }
    
    private lazy var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(image: #imageLiteral(resourceName: "backgroundSchedule"))
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return backgroundImageView
    }()
    
    private lazy var teamLogoImageView: UIImageView = {
        let teamLogoImageView = UIImageView(image: teamLogo)
        teamLogoImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.15).cgColor
        teamLogoImageView.layer.borderWidth = 1.0
        teamLogoImageView.clipsToBounds = true
        teamLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return teamLogoImageView
    }()
    
    private lazy var recordLabel: UILabel = {
        let recordLabel = UILabel()
        recordLabel.text = "최근 5경기 기록"
        recordLabel.textColor = UIColor(red: 44.0/255.0,
                                        green: 44.0/255.0,
                                        blue: 44.0/255.0,
                                        alpha: 1.0)
        recordLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15.0)
        recordLabel.textAlignment = .center
        recordLabel.adjustsFontSizeToFitWidth = true
        recordLabel.minimumScaleFactor = 0.5
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return recordLabel
    }()
    
    private lazy var firstRecordView: ScheduleRecordView = {
        let firstRecordView = ScheduleRecordView()
        firstRecordView.recordText = "승"
        firstRecordView.dateText = "1.20"
        firstRecordView.translatesAutoresizingMaskIntoConstraints = false
        
        return firstRecordView
    }()
    
    private lazy var secondRecordView: ScheduleRecordView = {
        let secondRecordView = ScheduleRecordView()
        secondRecordView.recordText = "패"
        secondRecordView.dateText = "1.13"
        secondRecordView.translatesAutoresizingMaskIntoConstraints = false
        
        return secondRecordView
    }()
    
    private lazy var thirdRecordView: ScheduleRecordView = {
        let thirdRecordView = ScheduleRecordView()
        thirdRecordView.recordText = "무"
        thirdRecordView.dateText = "1.6"
        thirdRecordView.translatesAutoresizingMaskIntoConstraints = false
        
        return thirdRecordView
    }()
    
    private lazy var fourthRecordView: ScheduleRecordView = {
        let fourthRecordView = ScheduleRecordView()
        fourthRecordView.recordText = "패"
        fourthRecordView.dateText = "12.27"
        fourthRecordView.translatesAutoresizingMaskIntoConstraints = false
        
        return fourthRecordView
    }()
    
    private lazy var fifthRecordView: ScheduleRecordView = {
        let fifthRecordView = ScheduleRecordView()
        fifthRecordView.recordText = "승"
        fifthRecordView.dateText = "12.20"
        fifthRecordView.translatesAutoresizingMaskIntoConstraints = false
        
        return fifthRecordView
    }()
    
    private lazy var recordStackView: UIStackView = {
        let recordStackView = UIStackView()
        recordStackView.axis = .horizontal
        recordStackView.distribution = .fillEqually
        recordStackView.spacing = self.frame.size.width * 14/414
        recordStackView.addArrangedSubview(firstRecordView)
        recordStackView.addArrangedSubview(secondRecordView)
        recordStackView.addArrangedSubview(thirdRecordView)
        recordStackView.addArrangedSubview(fourthRecordView)
        recordStackView.addArrangedSubview(fifthRecordView)
        recordStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return recordStackView
    }()
    
    private lazy var noDataLabel: UILabel = {
        let noDataLabel = UILabel()
        noDataLabel.text = "기록이 없습니다"
        noDataLabel.textColor = UIColor(red: 44.0/255.0,
                                        green: 44.0/255.0,
                                        blue: 44.0/255.0,
                                        alpha: 1.0)
        noDataLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        noDataLabel.textAlignment = .center
        noDataLabel.adjustsFontSizeToFitWidth = true
        noDataLabel.minimumScaleFactor = 0.5
        noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        
        noDataLabel.layer.borderColor = UIColor(red: 44.0/255.0,
                                                green: 44.0/255.0,
                                                blue: 44.0/255.0,
                                                alpha: 1.0).cgColor
        noDataLabel.layer.borderWidth = 0.5
        noDataLabel.layer.cornerRadius = 8.0
        
        return noDataLabel
    }()
    
    // MARK: Draw
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        teamLogoImageView.layer.cornerRadius = teamLogoImageView.frame.size.width / 2
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(backgroundImageView)
        self.addConstraints(backgroundImageViewConstraints())
        self.addSubview(teamLogoImageView)
        self.addConstraints(teamLogoImageViewConstraints())
        self.addSubview(recordLabel)
        self.addConstraints(recordLabelConstraints())
    }
}

extension ScheduleRecentView {
    private func backgroundImageViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: backgroundImageView, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: backgroundImageView, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: backgroundImageView, attribute: .trailing, relatedBy: .equal,
            toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: backgroundImageView, attribute: .bottom, relatedBy: .equal,
            toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
    
    private func teamLogoImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 138/173, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 110/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamLogoImageView, attribute: .height, relatedBy: .equal,
            toItem: teamLogoImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func recordLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 220/173, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 94/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 15/346, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func recordStackViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: recordStackView, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 248/173, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: recordStackView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: recordStackView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 332/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: recordStackView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 76/346, constant: 6.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func noDataLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: noDataLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 251/173, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: noDataLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: noDataLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 187/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: noDataLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 37/346, constant: 6.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
}
