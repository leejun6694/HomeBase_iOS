//
//  ScheduleDetailRecordMatchViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 3. 26..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleDetailRecordMatchViewController: UIViewController {

    // MARK: Properties
    
    private lazy var topView: UIView = {
        let topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        return topView
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .system)
        cancelButton.setImage(#imageLiteral(resourceName: "iconExit"), for: .normal)
        cancelButton.tintColor = UIColor(red: 44.0/255.0,
                                         green: 44.0/255.0,
                                         blue: 44.0/255.0,
                                         alpha: 1.0)
        cancelButton.addTarget(self,
                               action: #selector(cancelButtonDidTapped(_:)),
                               for: .touchUpInside)
        cancelButton.backgroundColor = UIColor.clear
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        return cancelButton
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "경기 결과"
        titleLabel.textColor = UIColor(red: 44.0/255.0,
                                       green: 44.0/255.0,
                                       blue: 44.0/255.0,
                                       alpha: 1.0)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
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
    
    private lazy var homeTeamLabel: UILabel = {
        let homeTeamLabel = UILabel()
        homeTeamLabel.text = "우리팀"
        homeTeamLabel.textColor = UIColor(red: 44.0/255.0,
                                          green: 44.0/255.0,
                                          blue: 44.0/255.0,
                                          alpha: 1.0)
        homeTeamLabel.textAlignment = .center
        homeTeamLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)
        homeTeamLabel.adjustsFontSizeToFitWidth = true
        homeTeamLabel.minimumScaleFactor = 0.5
        homeTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return homeTeamLabel
    }()
    
    private lazy var homeTeamTextField: UITextField = {
        let homeTeamTextField = UITextField()
        homeTeamTextField.placeholder = "-"
        homeTeamTextField.textColor = UIColor(red: 44.0/255.0,
                                              green: 44.0/255.0,
                                              blue: 44.0/255.0,
                                              alpha: 1.0)
        homeTeamTextField.tintColor = UIColor(red: 44.0/255.0,
                                              green: 44.0/255.0,
                                              blue: 44.0/255.0,
                                              alpha: 1.0)
        homeTeamTextField.textAlignment = .center
        homeTeamTextField.contentVerticalAlignment = .center
        homeTeamTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 50.0)
        homeTeamTextField.adjustsFontSizeToFitWidth = true
        homeTeamTextField.minimumFontSize = 0.5
        homeTeamTextField.keyboardType = .numberPad
        homeTeamTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return homeTeamTextField
    }()
    
    private lazy var homeTeamTextFieldBorder: UIView = {
        let homeTeamTextFieldBorder = UIView()
        homeTeamTextFieldBorder.backgroundColor = UIColor(red: 44.0/255.0,
                                                          green: 44.0/255.0,
                                                          blue: 44.0/255.0,
                                                          alpha: 0.5)
        homeTeamTextFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        return homeTeamTextFieldBorder
    }()
    
    private lazy var versusLabel: UILabel = {
        let versusLabel = UILabel()
        versusLabel.text = "vs"
        versusLabel.textColor = UIColor(red: 44.0/255.0,
                                        green: 44.0/255.0,
                                        blue: 44.0/255.0,
                                        alpha: 1.0)
        versusLabel.textAlignment = .center
        versusLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 27.0)
        versusLabel.adjustsFontSizeToFitWidth = true
        versusLabel.minimumScaleFactor = 0.5
        versusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return versusLabel
    }()
    
    private lazy var opponentTeamLabel: UILabel = {
        let opponentTeamLabel = UILabel()
        opponentTeamLabel.text = "상대팀"
        opponentTeamLabel.textColor = UIColor(red: 44.0/255.0,
                                              green: 44.0/255.0,
                                              blue: 44.0/255.0,
                                              alpha: 1.0)
        opponentTeamLabel.textAlignment = .center
        opponentTeamLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)
        opponentTeamLabel.adjustsFontSizeToFitWidth = true
        opponentTeamLabel.minimumScaleFactor = 0.5
        opponentTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return opponentTeamLabel
    }()
    
    private lazy var opponentTeamTextField: UITextField = {
        let opponentTeamTextField = UITextField()
        opponentTeamTextField.placeholder = "-"
        opponentTeamTextField.textColor = UIColor(red: 44.0/255.0,
                                                  green: 44.0/255.0,
                                                  blue: 44.0/255.0,
                                                  alpha: 1.0)
        opponentTeamTextField.tintColor = UIColor(red: 44.0/255.0,
                                                  green: 44.0/255.0,
                                                  blue: 44.0/255.0,
                                                  alpha: 1.0)
        opponentTeamTextField.textAlignment = .center
        opponentTeamTextField.contentVerticalAlignment = .center
        opponentTeamTextField.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 50.0)
        opponentTeamTextField.adjustsFontSizeToFitWidth = true
        opponentTeamTextField.minimumFontSize = 0.5
        opponentTeamTextField.keyboardType = .numberPad
        opponentTeamTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return opponentTeamTextField
    }()
    
    private lazy var opponentTeamTextFieldBorder: UIView = {
        let opponentTeamTextFieldBorder = UIView()
        opponentTeamTextFieldBorder.backgroundColor = UIColor(red: 44.0/255.0,
                                                              green: 44.0/255.0,
                                                              blue: 44.0/255.0,
                                                              alpha: 0.5)
        opponentTeamTextFieldBorder.translatesAutoresizingMaskIntoConstraints = false
        
        return opponentTeamTextFieldBorder
    }()
    
    // MARK: Methods
    
    @objc private func cancelButtonDidTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToDetailView", sender: self)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(topView)
        self.view.addConstraints(topViewConstraints())
        topView.addSubview(cancelButton)
        topView.addConstraints(cancelButtonConstraints())
        topView.addSubview(titleLabel)
        topView.addConstraints(titleLabelConstraints())
        topView.addSubview(doneButton)
        topView.addConstraints(doneButtonConstraints())
        self.view.addSubview(homeTeamLabel)
        self.view.addConstraints(homeTeamLabelConstraints())
        self.view.addSubview(homeTeamTextField)
        self.view.addConstraints(homeTeamTextFieldConstraints())
        self.view.addSubview(homeTeamTextFieldBorder)
        self.view.addConstraints(homeTeamTextFieldBorderConstraints())
        self.view.addSubview(versusLabel)
        self.view.addConstraints(versusLabelConstraints())
        self.view.addSubview(opponentTeamLabel)
        self.view.addConstraints(opponentTeamLabelConstraints())
        self.view.addSubview(opponentTeamTextField)
        self.view.addConstraints(opponentTeamTextFieldConstraints())
        self.view.addSubview(opponentTeamTextFieldBorder)
        self.view.addConstraints(opponentTeamTextFieldBorderConstraints())
        
        homeTeamTextField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        self.view.isOpaque = false
        self.view.frame.origin.y = self.view.bounds.origin.y + 100.0
        
        self.view.roundCorners([.topLeft, .topRight], radius: 15.0)
        self.view.backgroundColor = .white
    }
}

extension ScheduleDetailRecordMatchViewController {
    private func topViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: topView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: topView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: topView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: topView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 60/736, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func cancelButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .centerX, relatedBy: .equal,
            toItem: topView, attribute: .centerX, multiplier: 41.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .centerY, relatedBy: .equal,
            toItem: topView, attribute: .centerY, multiplier: 37.5/30, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .width, relatedBy: .equal,
            toItem: topView, attribute: .width, multiplier: 45/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .height, relatedBy: .equal,
            toItem: cancelButton, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func titleLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .centerX, relatedBy: .equal,
            toItem: topView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .centerY, relatedBy: .equal,
            toItem: topView, attribute: .centerY, multiplier: 39.5/30, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .width, relatedBy: .equal,
            toItem: topView, attribute: .width, multiplier: 120/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .height, relatedBy: .equal,
            toItem: topView, attribute: .height, multiplier: 27/60, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func doneButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .centerX, relatedBy: .equal,
            toItem: topView, attribute: .centerX, multiplier: 375/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .centerY, relatedBy: .equal,
            toItem: topView, attribute: .centerY, multiplier: 39.5/30, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .width, relatedBy: .equal,
            toItem: topView, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .height, relatedBy: .equal,
            toItem: topView, attribute: .height, multiplier: 30/60, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func homeTeamLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: homeTeamLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 119.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: homeTeamLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 171/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: homeTeamLabel, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 50/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: homeTeamLabel, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 22/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func homeTeamTextFieldConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: homeTeamTextField, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 119.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: homeTeamTextField, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 218/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: homeTeamTextField, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 80/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: homeTeamTextField, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 52/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func homeTeamTextFieldBorderConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: homeTeamTextFieldBorder, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 119.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: homeTeamTextFieldBorder, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 259.5/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: homeTeamTextFieldBorder, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 94/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: homeTeamTextFieldBorder, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 1/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func versusLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: versusLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: versusLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 196/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: versusLabel, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 30/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: versusLabel, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 30/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func opponentTeamLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 297.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 171/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 50/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: opponentTeamLabel, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 22/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func opponentTeamTextFieldConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: opponentTeamTextField, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 297.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: opponentTeamTextField, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 218/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: opponentTeamTextField, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 80/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: opponentTeamTextField, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 52/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func opponentTeamTextFieldBorderConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: opponentTeamTextFieldBorder, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 297.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: opponentTeamTextFieldBorder, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 259.5/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: opponentTeamTextFieldBorder, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 94/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: opponentTeamTextFieldBorder, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 1/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
