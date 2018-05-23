//
//  PersonalHeaderView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 21..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class PersonalHeaderView: UIView {

    // MARK: Properties
    
    private lazy var settingButton: UIButton = {
        let settingButton = UIButton(type: .system)
        settingButton.setImage(#imageLiteral(resourceName: "settingIcon"), for: .normal)
        settingButton.tintColor = .white
        settingButton.backgroundColor = UIColor.clear
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        
        return settingButton
    }()
    
    private lazy var playerImageView: UIImageView = {
        let playerImageView = UIImageView()
        playerImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.15).cgColor
        playerImageView.layer.borderWidth = 1.0
        playerImageView.clipsToBounds = true
        playerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return playerImageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "00 홈베이스"
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 28.0)
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    
    private lazy var positionLabel: UILabel = {
        let positionLabel = UILabel()
        positionLabel.text = "2루수"
        positionLabel.textColor = .white
        positionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 14.0)
        positionLabel.textAlignment = .center
        positionLabel.adjustsFontSizeToFitWidth = true
        positionLabel.minimumScaleFactor = 0.5
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return positionLabel
    }()
    
    private lazy var rankingView: PersonalRankingView = {
        let rankingView = PersonalRankingView()
        rankingView.backgroundColor = .clear
        rankingView.layer.borderColor = UIColor.white.cgColor
        rankingView.layer.borderWidth = 0.5
        rankingView.clipsToBounds = true
        rankingView.translatesAutoresizingMaskIntoConstraints = false
        
        return rankingView
    }()
    
    // MARK: Draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(settingButton)
        self.addConstraints(settingButtonConstraints())
        self.addSubview(playerImageView)
        self.addConstraints(playerImageViewConstraints())
        self.addSubview(nameLabel)
        self.addConstraints(nameLabelConstraints())
        self.addSubview(positionLabel)
        self.addConstraints(positionLabelConstraints())
        self.addSubview(rankingView)
        self.addConstraints(rankingViewConstraints())
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = HBColor.lightGray
        playerImageView.layer.cornerRadius = playerImageView.frame.size.width / 2
        rankingView.layer.cornerRadius = 10.0
    }
}

extension PersonalHeaderView {
    private func settingButtonConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: settingButton, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 35/293.5, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: settingButton, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 352/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: settingButton, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: settingButton, attribute: .height, relatedBy: .equal,
            toItem: settingButton, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func playerImageViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: playerImageView, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 77/293.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: playerImageView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: playerImageView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 106/587, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: playerImageView, attribute: .width, relatedBy: .equal,
            toItem: playerImageView, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint, heightConstraint, widthConstraint]
    }
    
    private func nameLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 197/293.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 2/3, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 29/587, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func positionLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: positionLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 232/293.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: positionLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: positionLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 2/3, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: positionLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 16/587, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func rankingViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: rankingView, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 284/293.5, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: rankingView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: rankingView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 373/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: rankingView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 50/587, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
}
