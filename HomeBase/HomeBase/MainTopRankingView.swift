//
//  MainTopRankingView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 21..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class MainTopRankingView: UIView {

    // MARK: Properties
    
    var baseViewColor:UIColor = UIColor.white {
        didSet {
            baseView.backgroundColor = baseViewColor
        }
    }
    
    var ranking:String = "" {
        didSet {
            rankingLabel.text = ranking
        }
    }
    
    var name:String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    var record:String = "" {
        didSet {
            recordLabel.text = record
        }
    }
    
    private lazy var baseView:UIView = {
        let baseView = UIView()
        baseView.backgroundColor = UIColor.white
        baseView.layer.cornerRadius = 10.0
        baseView.translatesAutoresizingMaskIntoConstraints = false
        
        return baseView
    }()
    
    private lazy var rankingLabel:UILabel = {
        let rankingLabel = UILabel()
        rankingLabel.text = "default"
        rankingLabel.textColor = .white
        rankingLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 25.0)
        rankingLabel.textAlignment = .center
        rankingLabel.adjustsFontSizeToFitWidth = true
        rankingLabel.minimumScaleFactor = 0.5
        rankingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return rankingLabel
    }()
    
    private lazy var nameLabel:UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "default"
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14.0)
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    
    private lazy var recordLabel:UILabel = {
        let recordLabel = UILabel()
        recordLabel.text = "0"
        recordLabel.textColor = .white
        recordLabel.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 27.0)
        recordLabel.textAlignment = .center
        recordLabel.adjustsFontSizeToFitWidth = true
        recordLabel.minimumScaleFactor = 0.5
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return recordLabel
    }()
    
    // MARK: Draw
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(baseView)
        self.addConstraints(baseViewConstraints())
        baseView.addSubview(rankingLabel)
        baseView.addConstraints(rankingLabelConstraints())
        baseView.addSubview(nameLabel)
        baseView.addConstraints(nameLabelConstraints())
        baseView.addSubview(recordLabel)
        baseView.addConstraints(recordLabelConstraints())
    }
}

extension MainTopRankingView {
    private func baseViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: baseView, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: baseView, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: baseView, attribute: .trailing, relatedBy: .equal,
            toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: baseView, attribute: .bottom, relatedBy: .equal,
            toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
    
    private func rankingLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: rankingLabel, attribute: .centerX, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: rankingLabel, attribute: .centerY, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 34.5/73.5, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: rankingLabel, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 14/120, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: rankingLabel, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 25/147, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func nameLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .centerX, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .centerY, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 59/73.5, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 37/120, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 14/147, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func recordLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .centerX, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .centerY, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 114.5/73.5, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 67/120, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 27/147, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
