//
//  ScheduleDetailPlayerCell.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 3. 1..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleDetailPlayerCell: UITableViewCell {

    // MARK: Properties
    
    private lazy var baseView: UIView = {
        let baseView = UIView()
        baseView.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        
        return baseView
    }()
    
    private lazy var playerNumberLabel: UILabel = {
        let playerNumberLabel = UILabel()
        playerNumberLabel.text = "14"
        playerNumberLabel.textColor = UIColor(red: 44.0/255.0,
                                              green: 44.0/255.0,
                                              blue: 44.0/255.0,
                                              alpha: 1.0)
        playerNumberLabel.textAlignment = .center
        playerNumberLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 26.0)
        playerNumberLabel.adjustsFontSizeToFitWidth = true
        playerNumberLabel.minimumScaleFactor = 0.5
        playerNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return playerNumberLabel
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "이승엽"
        nameLabel.textColor = UIColor(red: 44.0/255.0,
                                      green: 44.0/255.0,
                                      blue: 44.0/255.0,
                                      alpha: 1.0)
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15.0)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    
    private lazy var divisionView: UIView = {
        let divisionView = UIView()
        divisionView.backgroundColor = UIColor(red: 44.0/255.0,
                                               green: 44.0/255.0,
                                               blue: 44.0/255.0,
                                               alpha: 1.0)
        divisionView.translatesAutoresizingMaskIntoConstraints = false
        
        return divisionView
    }()
    
    lazy var recordPlayerButton: UIButton = {
        let recordPlayerButton = UIButton(type: .system)
        recordPlayerButton.setTitle("결과 입력", for: .normal)
        recordPlayerButton.setTitleColor(UIColor(red: 44.0/255.0,
                                           green: 44.0/255.0,
                                           blue: 44.0/255.0,
                                           alpha: 1.0), for: .normal)
        recordPlayerButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15.0)
        recordPlayerButton.titleLabel?.adjustsFontSizeToFitWidth = true
        recordPlayerButton.titleLabel?.minimumScaleFactor = 0.5
        recordPlayerButton.backgroundColor = UIColor.clear
        recordPlayerButton.translatesAutoresizingMaskIntoConstraints = false
        
        return recordPlayerButton
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
        
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(baseView)
        self.addConstraints(baseViewConstraints())
        baseView.addSubview(playerNumberLabel)
        baseView.addConstraints(playerNumberLabelConstraints())
        baseView.addSubview(nameLabel)
        baseView.addConstraints(nameLabelConstraints())
        baseView.addSubview(divisionView)
        baseView.addConstraints(divisionViewConstraints())
        baseView.addSubview(recordPlayerButton)
        baseView.addConstraints(recordPlayerButtonConstraints())
    }
}

extension ScheduleDetailPlayerCell {
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
            toItem: self, attribute: .height, multiplier: 68/75, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func playerNumberLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: playerNumberLabel, attribute: .centerX, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 52.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: playerNumberLabel, attribute: .centerY, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: playerNumberLabel, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 90/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: playerNumberLabel, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 36/68, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func nameLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .leading, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 99/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .centerY, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 150/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 18/68, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
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
            toItem: baseView, attribute: .height, multiplier: 37/68, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func recordPlayerButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: recordPlayerButton, attribute: .centerX, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 365/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: recordPlayerButton, attribute: .centerY, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: recordPlayerButton, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 58/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: recordPlayerButton, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 16/68, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}