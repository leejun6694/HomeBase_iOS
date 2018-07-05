//
//  PersonalSettingPlayerView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 7. 4..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class PersonalSettingPlayerView: UIView {
    
    // MARK: Properties
    
    private lazy var positionLabel: UILabel = {
        let positionLabel = UILabel()
        positionLabel.text = "포지션"
        positionLabel.textColor = .white
        positionLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        positionLabel.textAlignment = .left
        positionLabel.adjustsFontSizeToFitWidth = true
        positionLabel.minimumScaleFactor = 0.5
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return positionLabel
    }()
    lazy var positionTextField: UITextField = {
        let positionTextField = UITextField()
        positionTextField.textColor = .white
        positionTextField.tintColor = .white
        positionTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        positionTextField.adjustsFontSizeToFitWidth = true
        positionTextField.minimumFontSize = 9.0
        positionTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return positionTextField
    }()
    private lazy var positionTextFieldBorder: UIView = {
        let positionTextFieldBorder = UIView()
        positionTextFieldBorder.backgroundColor = .white
        positionTextFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        return positionTextFieldBorder
    }()
    private lazy var positionConditionImageView: UIImageView = {
        let positionConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        positionConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return positionConditionImageView
    }()
    
    private lazy var backNumberLabel: UILabel = {
        let backNumberLabel = UILabel()
        backNumberLabel.text = "선수번호"
        backNumberLabel.textColor = .white
        backNumberLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        backNumberLabel.textAlignment = .left
        backNumberLabel.adjustsFontSizeToFitWidth = true
        backNumberLabel.minimumScaleFactor = 0.5
        backNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return backNumberLabel
    }()
    lazy var backNumberTextField: UITextField = {
        let backNumberTextField = UITextField()
        backNumberTextField.textColor = .white
        backNumberTextField.tintColor = .white
        backNumberTextField.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        backNumberTextField.adjustsFontSizeToFitWidth = true
        backNumberTextField.minimumFontSize = 9.0
        backNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return backNumberTextField
    }()
    private lazy var backNumberTextFieldBorder: UIView = {
        let backNumberTextFieldBorder = UIView()
        backNumberTextFieldBorder.backgroundColor = .white
        backNumberTextFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        return backNumberTextFieldBorder
    }()
    private lazy var backNumberConditionImageView: UIImageView = {
        let backNumberConditionImageView = UIImageView(image: #imageLiteral(resourceName: "path2"))
        backNumberConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return backNumberConditionImageView
    }()
    
    private lazy var pitcherLabel: UILabel = {
        let pitcherLabel = UILabel()
        pitcherLabel.text = "투수"
        pitcherLabel.textColor = HBColor.correct
        pitcherLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        pitcherLabel.textAlignment = .left
        pitcherLabel.adjustsFontSizeToFitWidth = true
        pitcherLabel.minimumScaleFactor = 0.5
        pitcherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return pitcherLabel
    }()
    private lazy var pitcherControl: UISegmentedControl = {
        let pitcherControl = UISegmentedControl(items: ["좌", "우"])
        pitcherControl.tintColor = HBColor.correct
        pitcherControl.translatesAutoresizingMaskIntoConstraints = false
        
        return pitcherControl
    }()
    
    private lazy var hitterLabel: UILabel = {
        let hitterLabel = UILabel()
        hitterLabel.text = "타자"
        hitterLabel.textColor = HBColor.correct
        hitterLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 15.0)
        hitterLabel.textAlignment = .left
        hitterLabel.adjustsFontSizeToFitWidth = true
        hitterLabel.minimumScaleFactor = 0.5
        hitterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return hitterLabel
    }()
    private lazy var hitterControl: UISegmentedControl = {
        let hitterControl = UISegmentedControl(items: ["좌", "우"])
        hitterControl.tintColor = HBColor.correct
        hitterControl.translatesAutoresizingMaskIntoConstraints = false
        
        return hitterControl
    }()
    
    // MARK: Draw
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(positionLabel)
        self.addConstraints(positionLabelConstraints())
        self.addSubview(positionTextField)
        self.addConstraints(positionTextFieldConstraints())
        self.addSubview(positionTextFieldBorder)
        self.addConstraints(positionTextFieldBorderConstraints())
        
        self.addSubview(backNumberLabel)
        self.addConstraints(backNumberLabelConstraints())
        self.addSubview(backNumberTextField)
        self.addConstraints(backNumberTextFieldConstraints())
        self.addSubview(backNumberTextFieldBorder)
        self.addConstraints(backNumberTextFieldBorderConstraints())
        self.addSubview(pitcherLabel)
        self.addConstraints(pitcherLabelConstraints())
        self.addSubview(pitcherControl)
        self.addConstraints(pitcherControlConstraints())
        self.addSubview(hitterLabel)
        self.addConstraints(hitterLabelConstraints())
        self.addSubview(hitterControl)
        self.addConstraints(hitterControlConstraints())
    }
}

extension PersonalSettingPlayerView {
    private func positionLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: positionLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: positionLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 42/213, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: positionLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 60/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: positionLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 19/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func positionTextFieldConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: positionTextField, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: positionTextField, attribute: .top, relatedBy: .equal,
            toItem: positionLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: positionTextField, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 297/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: positionTextField, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 37/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func positionTextFieldBorderConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: positionTextFieldBorder, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: positionTextFieldBorder, attribute: .top, relatedBy: .equal,
            toItem: positionTextField, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: positionTextFieldBorder, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 345/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: positionTextFieldBorder, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 2/426, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func positionConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: positionConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: positionTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: positionConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: positionTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: positionConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: positionTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: positionConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: positionConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func backNumberLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: backNumberLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: backNumberLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 141/213, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: backNumberLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 60/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: backNumberLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 19/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func backNumberTextFieldConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: backNumberTextField, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: backNumberTextField, attribute: .top, relatedBy: .equal,
            toItem: backNumberLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: backNumberTextField, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 297/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: backNumberTextField, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 37/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func backNumberTextFieldBorderConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: backNumberTextFieldBorder, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: backNumberTextFieldBorder, attribute: .top, relatedBy: .equal,
            toItem: backNumberTextField, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: backNumberTextFieldBorder, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 345/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: backNumberTextFieldBorder, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 2/426, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func backNumberConditionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerYConstraint = NSLayoutConstraint(
            item: backNumberConditionImageView, attribute: .centerY, relatedBy: .equal,
            toItem: backNumberTextField, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: backNumberConditionImageView, attribute: .leading, relatedBy: .equal,
            toItem: backNumberTextField, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        let widthConstraint = NSLayoutConstraint(
            item: backNumberConditionImageView, attribute: .width, relatedBy: .equal,
            toItem: backNumberTextField, attribute: .width, multiplier: 20.0/297.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: backNumberConditionImageView, attribute: .height, relatedBy: .equal,
            toItem: backNumberConditionImageView, attribute: .width, multiplier: 18.0/20.0, constant: 0.0)
        
        return [centerYConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func pitcherLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: pitcherLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: pitcherLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 251/213, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: pitcherLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 50/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: pitcherLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 20/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func pitcherControlConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: pitcherControl, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 219/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: pitcherControl, attribute: .centerY, relatedBy: .equal,
            toItem: pitcherLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: pitcherControl, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 153/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: pitcherControl, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 30/426, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func hitterLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: hitterLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 44/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: hitterLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 325/213, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: hitterLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 50/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: hitterLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 20/426, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    private func hitterControlConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: hitterControl, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 219/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: hitterControl, attribute: .centerY, relatedBy: .equal,
            toItem: hitterLabel, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: hitterControl, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 153/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: hitterControl, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 30/426, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
