//
//  PersonalRecordView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 25..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class PersonalRecordView: UIView {

    // MARK: Properties
    
    private lazy var batterButton: UIButton = {
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
        
        batterButton.addTarget(
            self,
            action: #selector(batterButtonDidTapped(_:)),
            for: .touchUpInside)
        
        return batterButton
    }()
    
    private lazy var pitcherButton: UIButton = {
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
        
        pitcherButton.addTarget(
            self,
            action: #selector(pitcherButtonDidTapped(_:)),
            for: .touchUpInside)
        
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
    
    private lazy var batterView: PersonalBatterView = {
        let batterView = PersonalBatterView()
        batterView.translatesAutoresizingMaskIntoConstraints = false
        
        return batterView
    }()
    
    private lazy var pitcherView: PersonalPitcherView = {
        let pitcherView = PersonalPitcherView()
        pitcherView.translatesAutoresizingMaskIntoConstraints = false
        
        return pitcherView
    }()
    
    // MARK: Methods
    
    @objc private func batterButtonDidTapped(_ sender: UIButton) {
        if buttonUnderView.isDescendant(of: self) {
            buttonUnderView.removeFromSuperview()
        }
        
        self.addSubview(buttonUnderView)
        self.addConstraints(batterButtonUnderViewConstraints())
        batterButton.setTitleColor(HBColor.lightGray, for: .normal)
        pitcherButton.setTitleColor(UIColor(
            red: 44,
            green: 44,
            blue: 44,
            alpha: 0.6), for: .normal)
        
        if pitcherView.isDescendant(of: self) {
            pitcherView.removeFromSuperview()
        }
        self.addSubview(batterView)
        self.addConstraints(batterViewConstraints())
    }
    
    @objc private func pitcherButtonDidTapped(_ sender: UIButton) {
        if buttonUnderView.isDescendant(of: self) {
            buttonUnderView.removeFromSuperview()
        }
        self.addSubview(buttonUnderView)
        self.addConstraints(pitcherButtonUnderViewConstraints())
        batterButton.setTitleColor(UIColor(
            red: 44,
            green: 44,
            blue: 44,
            alpha: 0.6), for: .normal)
        pitcherButton.setTitleColor(HBColor.lightGray, for: .normal)
        
        if batterView.isDescendant(of: self) {
            batterView.removeFromSuperview()
        }
        self.addSubview(pitcherView)
        self.addConstraints(pitcherViewConstraints())
    }
    
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
        
        self.addSubview(batterView)
        self.addConstraints(batterViewConstraints())
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .white
    }
}

extension PersonalRecordView {
    private func batterButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 151/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 35/259, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 20/518, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func pitcherButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 269/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 35/259, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 20/518, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func batterButtonUnderViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 151/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 53.5/259, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 36/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 3/518, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func pitcherButtonUnderViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 269/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 53.5/259, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 36/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 3/518, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func divisionViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 53/259, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 1/518, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func batterViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: batterView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: batterView, attribute: .top, relatedBy: .equal,
            toItem: divisionView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: batterView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: batterView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 462/518, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func pitcherViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: pitcherView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: pitcherView, attribute: .top, relatedBy: .equal,
            toItem: divisionView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: pitcherView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: pitcherView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 462/518, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
}
