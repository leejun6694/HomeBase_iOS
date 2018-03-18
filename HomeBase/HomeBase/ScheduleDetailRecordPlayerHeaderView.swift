//
//  ScheduleDetailRecordPlayerHeaderView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 3. 4..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleDetailRecordPlayerHeaderView: UIView {

    // MARK: Properties
    
    var batterButtonState = true {
        didSet {
            if batterButtonState {
                if buttonUnderView.isDescendant(of: self) {
                    buttonUnderView.removeFromSuperview()
                }
                self.addSubview(buttonUnderView)
                self.addConstraints(batterButtonUnderViewConstraints())
                batterButton.setTitleColor(UIColor(red: 44.0/255.0,
                                                   green: 44.0/255.0,
                                                   blue: 44.0/255.0,
                                                   alpha: 1.0), for: .normal)
                pitcherButton.setTitleColor(UIColor(red: 44.0/255.0,
                                                    green: 44.0/255.0,
                                                    blue: 44.0/255.0,
                                                    alpha: 0.6), for: .normal)
            } else {
                if buttonUnderView.isDescendant(of: self) {
                    buttonUnderView.removeFromSuperview()
                }
                self.addSubview(buttonUnderView)
                self.addConstraints(pitcherButtonUnderViewConstraints())
                batterButton.setTitleColor(UIColor(red: 44.0/255.0,
                                                   green: 44.0/255.0,
                                                   blue: 44.0/255.0,
                                                   alpha: 0.6), for: .normal)
                pitcherButton.setTitleColor(UIColor(red: 44.0/255.0,
                                                    green: 44.0/255.0,
                                                    blue: 44.0/255.0,
                                                    alpha: 1.0), for: .normal)
            }
        }
    }
    
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .system)
        cancelButton.setImage(#imageLiteral(resourceName: "iconExit"), for: .normal)
        cancelButton.tintColor = UIColor(red: 44.0/255.0,
                                         green: 44.0/255.0,
                                         blue: 44.0/255.0,
                                         alpha: 1.0)
        cancelButton.backgroundColor = UIColor.clear
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        return cancelButton
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "이승엽"
        nameLabel.textColor = UIColor(red: 44.0/255.0,
                                      green: 44.0/255.0,
                                      blue: 44.0/255.0,
                                      alpha: 1.0)
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    
    private lazy var doneButton: UIButton = {
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("완료", for: .normal)
        doneButton.setTitleColor(UIColor(red: 44.0/255.0,
                                         green: 44.0/255.0,
                                         blue: 44.0/255.0,
                                         alpha: 1.0), for: .normal)
        doneButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)
        doneButton.titleLabel?.adjustsFontSizeToFitWidth = true
        doneButton.titleLabel?.minimumScaleFactor = 0.5
        doneButton.backgroundColor = UIColor.clear
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        
        return doneButton
    }()
    
    lazy var batterButton: UIButton = {
        let batterButton = UIButton(type: .system)
        batterButton.setTitle("타자", for: .normal)
        batterButton.setTitleColor(UIColor(red: 44.0/255.0,
                                           green: 44.0/255.0,
                                           blue: 44.0/255.0,
                                           alpha: 1.0), for: .normal)
        batterButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)
        batterButton.titleLabel?.adjustsFontSizeToFitWidth = true
        batterButton.titleLabel?.minimumScaleFactor = 0.5
        batterButton.backgroundColor = UIColor.clear
        batterButton.translatesAutoresizingMaskIntoConstraints = false
        
        return batterButton
    }()
    
    lazy var pitcherButton: UIButton = {
        let pitcherButton = UIButton(type: .system)
        pitcherButton.setTitle("투수", for: .normal)
        pitcherButton.setTitleColor(UIColor(red: 44.0/255.0,
                                            green: 44.0/255.0,
                                            blue: 44.0/255.0,
                                            alpha: 0.6), for: .normal)
        pitcherButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)
        pitcherButton.titleLabel?.adjustsFontSizeToFitWidth = true
        pitcherButton.titleLabel?.minimumScaleFactor = 0.5
        pitcherButton.backgroundColor = UIColor.clear
        pitcherButton.translatesAutoresizingMaskIntoConstraints = false
        
        return pitcherButton
    }()
    
    private lazy var buttonUnderView: UIView = {
        let buttonUnderView = UIView()
        buttonUnderView.backgroundColor = UIColor(red: 44.0/255.0,
                                                  green: 44.0/255.0,
                                                  blue: 44.0/255.0,
                                                  alpha: 1.0)
        buttonUnderView.translatesAutoresizingMaskIntoConstraints = false
        
        return buttonUnderView
    }()
    
    // MARK: Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorners([.topLeft, .topRight], radius: 15.0)
        self.backgroundColor = .white
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(cancelButton)
        self.addConstraints(cancelButtonConstraints())
        self.addSubview(nameLabel)
        self.addConstraints(nameLabelConstraints())
        self.addSubview(doneButton)
        self.addConstraints(doneButtonConstraints())
        self.addSubview(batterButton)
        self.addConstraints(batterButtonConstraints())
        self.addSubview(pitcherButton)
        self.addConstraints(pitcherButtonConstraints())
        self.addSubview(buttonUnderView)
        self.addConstraints(batterButtonUnderViewConstraints())
    }
}

extension ScheduleDetailRecordPlayerHeaderView {
    private func cancelButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 42/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 40/59.25, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .height, relatedBy: .equal,
            toItem: cancelButton, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func nameLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 39.5/59.25, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 120/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 27/118.5, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func doneButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 375/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 39/59.25, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 20/118.5, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func batterButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 151/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 93/59.25, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 20/118.5, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func pitcherButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 269/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 93/59.25, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 20/118.5, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func batterButtonUnderViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 151/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 105.5/59.25, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 36/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 3/118.5, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func pitcherButtonUnderViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 269/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 105.5/59.25, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 36/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 3/118.5, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
