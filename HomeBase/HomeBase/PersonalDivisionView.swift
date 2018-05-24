//
//  PersonalDivisionView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 24..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class PersonalDivisionView: UIView {

    // MARK: Properties
    
    lazy var batterButton: UIButton = {
        let batterButton = UIButton(type: .system)
        batterButton.setTitle("타자", for: .normal)
        batterButton.setTitleColor(HBColor.lightGray, for: .normal)
        batterButton.titleLabel?.font = UIFont(
            name: "AppleSDGothicNeo-Bold",
            size: 17.0)
        batterButton.titleLabel?.adjustsFontSizeToFitWidth = true
        batterButton.titleLabel?.minimumScaleFactor = 0.5
        batterButton.backgroundColor = UIColor.clear
        batterButton.translatesAutoresizingMaskIntoConstraints = false
        
        return batterButton
    }()
    
    lazy var pitcherButton: UIButton = {
        let pitcherButton = UIButton(type: .system)
        pitcherButton.setTitle("투수", for: .normal)
        pitcherButton.setTitleColor(UIColor(
            red: 44,
            green: 44,
            blue: 44,
            alpha: 0.6), for: .normal)
        pitcherButton.titleLabel?.font = UIFont(
            name: "AppleSDGothicNeo-Bold",
            size: 17.0)
        pitcherButton.titleLabel?.adjustsFontSizeToFitWidth = true
        pitcherButton.titleLabel?.minimumScaleFactor = 0.5
        pitcherButton.backgroundColor = UIColor.clear
        pitcherButton.translatesAutoresizingMaskIntoConstraints = false
        
        return pitcherButton
    }()
    
    private lazy var buttonUnderView: UIView = {
        let buttonUnderView = UIView()
        buttonUnderView.backgroundColor = HBColor.lightGray
        buttonUnderView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonUnderView
    }()
    
    private lazy var divisionView: UIView = {
        let divisionView = UIView()
        divisionView.backgroundColor = UIColor(
            red: 44,
            green: 44,
            blue: 44,
            alpha: 0.3)
        divisionView.translatesAutoresizingMaskIntoConstraints = false
        
        return divisionView
    }()
    
    // MARK: Draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(batterButton)
        self.addConstraints(batterButtonConstraints())
        self.addSubview(pitcherButton)
        self.addConstraints(pitcherButtonConstraints())
        self.addSubview(buttonUnderView)
        self.addConstraints(batterButtonUnderViewConstraints())
        self.addSubview(divisionView)
        self.addConstraints(divisionViewConstraints())
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .white
    }
}

extension PersonalDivisionView {
    private func batterButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 151/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 35/28, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 20/56, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func pitcherButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 269/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 35/28, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 20/56, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func batterButtonUnderViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 151/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 53.5/28, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 36/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 3/56, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func pitcherButtonUnderViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 269/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 53.5/28, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 36/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 3/56, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
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
            toItem: self, attribute: .height, multiplier: 1/56, constant: 0.0)
        
        return [centerXConstraint, bottomConstraint, widthConstraint, heightConstraint]
    }
}
