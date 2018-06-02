//
//  TeamDataView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 6. 2..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class TeamDataView: UIView {

    // MARK: Properties
    
    private lazy var teamDataButton: UIButton = {
        let teamDataButton = UIButton(type: .system)
        teamDataButton.setTitle("팀 종합 데이터", for: .normal)
        teamDataButton.setTitleColor(UIColor.white, for: .normal)
        teamDataButton.titleLabel?.font = UIFont(
            name: "AppleSDGothicNeo-Medium",
            size: 14.0)
        teamDataButton.titleLabel?.adjustsFontSizeToFitWidth = true
        teamDataButton.titleLabel?.minimumScaleFactor = 0.5
        teamDataButton.backgroundColor = HBColor.lightGray
        teamDataButton.translatesAutoresizingMaskIntoConstraints = false
        
        return teamDataButton
    }()
    
    private lazy var firstLineView: UIView = {
        let firstLineView = UIView()
        firstLineView.backgroundColor = HBColor.lightGray
        firstLineView.translatesAutoresizingMaskIntoConstraints = false
        
        return firstLineView
    }()
    
    private lazy var secondLineView: UIView = {
        let secondLineView = UIView()
        secondLineView.backgroundColor = HBColor.lightGray
        secondLineView.translatesAutoresizingMaskIntoConstraints = false
        
        return secondLineView
    }()
    
    // MARK: Draw
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        teamDataButton.layer.cornerRadius = 8.0
        
        self.backgroundColor = UIColor.white
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(teamDataButton)
        self.addConstraints(teamDataButtonConstraints())
        self.addSubview(firstLineView)
        self.addConstraints(firstLineViewConstraints())
        self.addSubview(secondLineView)
        self.addConstraints(secondLineViewConstraints())
    }
}

extension TeamDataView {
    private func teamDataButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: teamDataButton, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: teamDataButton, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: teamDataButton, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 150/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: teamDataButton, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func firstLineViewConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: firstLineView, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 36/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: firstLineView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: firstLineView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 81/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: firstLineView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 1/35, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func secondLineViewConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: secondLineView, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 299/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: secondLineView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: secondLineView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 81/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: secondLineView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 1/35, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
