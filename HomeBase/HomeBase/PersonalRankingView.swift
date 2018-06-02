//
//  PersonalRankingView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 23..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class PersonalRankingView: UIView {

    // MARK: Properties
    
    private lazy var firstRankLabel: UILabel = {
        let firstRankLabel = UILabel()
        firstRankLabel.text = "기록명"
        firstRankLabel.textColor = .white
        firstRankLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13.0)
        firstRankLabel.textAlignment = .center
        firstRankLabel.adjustsFontSizeToFitWidth = true
        firstRankLabel.minimumScaleFactor = 0.5
        firstRankLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return firstRankLabel
    }()
    
    private lazy var secondRankLabel: UILabel = {
        let secondRankLabel = UILabel()
        secondRankLabel.text = "기록명"
        secondRankLabel.textColor = .white
        secondRankLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13.0)
        secondRankLabel.textAlignment = .center
        secondRankLabel.adjustsFontSizeToFitWidth = true
        secondRankLabel.minimumScaleFactor = 0.5
        secondRankLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return secondRankLabel
    }()
    
    private lazy var thirdRankLabel: UILabel = {
        let thirdRankLabel = UILabel()
        thirdRankLabel.text = "기록명"
        thirdRankLabel.textColor = .white
        thirdRankLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13.0)
        thirdRankLabel.textAlignment = .center
        thirdRankLabel.adjustsFontSizeToFitWidth = true
        thirdRankLabel.minimumScaleFactor = 0.5
        thirdRankLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return thirdRankLabel
    }()
    
    // MARK: Draw
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(firstRankLabel)
        self.addConstraints(firstRankLabelConstraints())
        self.addSubview(secondRankLabel)
        self.addConstraints(secondRankLabelConstraints())
        self.addSubview(thirdRankLabel)
        self.addConstraints(thirdRankLabelConstraints())
    }
}

extension PersonalRankingView {
    private func firstRankLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: firstRankLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1/2, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: firstRankLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: firstRankLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1/5, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: firstRankLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 2/3, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func secondRankLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: secondRankLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: secondRankLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: secondRankLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1/5, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: secondRankLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 2/3, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func thirdRankLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: thirdRankLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 3/2, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: thirdRankLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: thirdRankLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1/5, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: thirdRankLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 2/3, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
