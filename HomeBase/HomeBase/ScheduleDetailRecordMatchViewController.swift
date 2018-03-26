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
            toItem: self.view, attribute: .height, multiplier: 45/620, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func cancelButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .centerX, relatedBy: .equal,
            toItem: topView, attribute: .centerX, multiplier: 41.5/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .centerY, relatedBy: .equal,
            toItem: topView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
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
            toItem: topView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .width, relatedBy: .equal,
            toItem: topView, attribute: .width, multiplier: 120/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .height, relatedBy: .equal,
            toItem: topView, attribute: .height, multiplier: 27/45, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func doneButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .centerX, relatedBy: .equal,
            toItem: topView, attribute: .centerX, multiplier: 375/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .centerY, relatedBy: .equal,
            toItem: topView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .width, relatedBy: .equal,
            toItem: topView, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: doneButton, attribute: .height, relatedBy: .equal,
            toItem: topView, attribute: .height, multiplier: 30/45, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
