//
//  TeamSettingMemberCell.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 6. 27..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class TeamSettingMemberCell: UITableViewCell {

    // MARK: Properties
    
    var backNumber: Int = 0 {
        didSet {
            backNumberLabel.text = "\(backNumber)"
        }
    }
    
    var playerImage: UIImage = UIImage() {
        didSet {
            playerImageView.image = playerImage
        }
    }
    
    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    private lazy var backNumberLabel: UILabel = {
        let backNumberLabel = UILabel()
        backNumberLabel.text = "0"
        backNumberLabel.textColor = .white
        backNumberLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 28.0)
        backNumberLabel.textAlignment = .center
        backNumberLabel.adjustsFontSizeToFitWidth = true
        backNumberLabel.minimumScaleFactor = 0.5
        backNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return backNumberLabel
    }()
    
    private lazy var playerImageView: UIImageView = {
        let playerImageView = UIImageView(image: #imageLiteral(resourceName: "personal_default"))
        playerImageView.backgroundColor = .white
        playerImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.15).cgColor
        playerImageView.layer.borderWidth = 1.0
        playerImageView.clipsToBounds = true
        playerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return playerImageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "이승엽"
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.0)
        nameLabel.textAlignment = .left
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    
    private lazy var moreImageView: UIImageView = {
        let moreImageView = UIImageView(image: #imageLiteral(resourceName: "iconMore"))
        moreImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return moreImageView
    }()
    
    private lazy var divisionView: UIView = {
        let divisionView = UIView()
        divisionView.backgroundColor = UIColor(red: 44, green: 44, blue: 44, alpha: 0.3)
        divisionView.translatesAutoresizingMaskIntoConstraints = false
        
        return divisionView
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
        
        self.backgroundColor = .clear
        playerImageView.layer.cornerRadius = playerImageView.frame.size.width / 2
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(backNumberLabel)
        self.addConstraints(backNumberLabelConstraints())
        self.addSubview(playerImageView)
        self.addConstraints(playerImageViewConstraints())
        self.addSubview(nameLabel)
        self.addConstraints(nameLabelConstraints())
        self.addSubview(moreImageView)
        self.addConstraints(moreImageViewConstraints())
    }
}

extension TeamSettingMemberCell {
    private func backNumberLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: backNumberLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 46.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: backNumberLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: backNumberLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 90/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: backNumberLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 30/80, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func playerImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: playerImageView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 108/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: playerImageView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: playerImageView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 50/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: playerImageView, attribute: .height, relatedBy: .equal,
            toItem: playerImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func nameLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 157/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 150/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 18/80, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func divisionViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .bottom, relatedBy: .equal,
            toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 3/80, constant: 0.0)
        
        return [centerXConstraint, bottomConstraint, widthConstraint, heightConstraint]
    }
    
    private func moreImageViewConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: moreImageView, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 347/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: moreImageView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: moreImageView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: moreImageView, attribute: .height, relatedBy: .equal,
            toItem: moreImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
