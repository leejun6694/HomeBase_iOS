//
//  ScheduleDetailLoadPlayerViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 14..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleDetailLoadPlayerViewController: UIViewController {

    // MARK: Properties
    
    let loadBatterView = ScheduleDetailLoadBatterView()
    let loadPitcherView = ScheduleDetailLoadPitcherView()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .system)
        cancelButton.setImage(#imageLiteral(resourceName: "iconExit"), for: .normal)
        cancelButton.tintColor = HBColor.lightGray
        cancelButton.backgroundColor = UIColor.clear
        cancelButton.addTarget(self,
                               action: #selector(cancelButtonDidTapped(_:)),
                               for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        return cancelButton
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "이승엽"
        nameLabel.textColor = HBColor.lightGray
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 21.0)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    
    private lazy var batterButton: UIButton = {
        let batterButton = UIButton(type: .system)
        batterButton.setTitle("타자", for: .normal)
        batterButton.setTitleColor(HBColor.lightGray, for: .normal)
        batterButton.addTarget(
            self,
            action: #selector(batterButtonDidTapped(_:)),
            for: .touchUpInside)
        batterButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold",
                                               size: 17.0)
        batterButton.titleLabel?.adjustsFontSizeToFitWidth = true
        batterButton.titleLabel?.minimumScaleFactor = 0.5
        batterButton.backgroundColor = UIColor.clear
        batterButton.translatesAutoresizingMaskIntoConstraints = false
        
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
        pitcherButton.addTarget(
            self,
            action: #selector(pitcherButtonDidTapped(_:)),
            for: .touchUpInside)
        pitcherButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold",
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
    
    private lazy var playerImageView: UIImageView = {
        let playerImageView = UIImageView()
        playerImageView.layer.borderColor = UIColor.black.withAlphaComponent(0.15).cgColor
        playerImageView.layer.borderWidth = 1.0
        playerImageView.clipsToBounds = true
        playerImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return playerImageView
    }()
    
    private lazy var divisionView: UIView = {
        let divisionView = UIView()
        divisionView.backgroundColor = UIColor(red: 44,
                                               green: 44,
                                               blue: 44,
                                               alpha: 0.3)
        divisionView.translatesAutoresizingMaskIntoConstraints = false
        
        return divisionView
    }()
    
    // MARK: Methods
    
    @objc private func cancelButtonDidTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "cancelToDetailView", sender: self)
    }
    
    @objc private func batterButtonDidTapped(_ sender: UIButton) {
        if buttonUnderView.isDescendant(of: self.view) {
            buttonUnderView.removeFromSuperview()
        }
        
        self.view.addSubview(buttonUnderView)
        self.view.addConstraints(batterButtonUnderViewConstraints())
        batterButton.setTitleColor(HBColor.lightGray, for: .normal)
        pitcherButton.setTitleColor(UIColor(
            red: 44,
            green: 44,
            blue: 44,
            alpha: 0.6), for: .normal)
        
        if loadPitcherView.isDescendant(of: self.view) {
            loadPitcherView.removeFromSuperview()
        }
        self.view.addSubview(loadBatterView)
        self.view.addConstraints(loadBatterViewConstraints())
    }
    
    @objc private func pitcherButtonDidTapped(_ sender: UIButton) {
        if buttonUnderView.isDescendant(of: self.view) {
            buttonUnderView.removeFromSuperview()
        }
        self.view.addSubview(buttonUnderView)
        self.view.addConstraints(pitcherButtonUnderViewConstraints())
        batterButton.setTitleColor(UIColor(
            red: 44,
            green: 44,
            blue: 44,
            alpha: 0.6), for: .normal)
        pitcherButton.setTitleColor(HBColor.lightGray, for: .normal)
        
        if loadBatterView.isDescendant(of: self.view) {
            loadBatterView.removeFromSuperview()
        }
        self.view.addSubview(loadPitcherView)
        self.view.addConstraints(loadPitcherViewConstraints())
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(cancelButton)
        self.view.addConstraints(cancelButtonConstraints())
        self.view.addSubview(nameLabel)
        self.view.addConstraints(nameLabelConstraints())
        self.view.addSubview(batterButton)
        self.view.addConstraints(batterButtonConstraints())
        self.view.addSubview(pitcherButton)
        self.view.addConstraints(pitcherButtonConstraints())
        self.view.addSubview(buttonUnderView)
        self.view.addConstraints(batterButtonUnderViewConstraints())
        self.view.addSubview(playerImageView)
        self.view.addConstraints(playerImageViewConstraints())
        self.view.addSubview(divisionView)
        self.view.addConstraints(divisionViewConstraints())
        
        loadBatterView.translatesAutoresizingMaskIntoConstraints = false
        loadPitcherView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(loadBatterView)
        self.view.addConstraints(loadBatterViewConstraints())
    }

    override func viewDidLayoutSubviews() {
        self.view.isOpaque = false
        
        self.view.frame.origin.y = self.view.bounds.origin.y + 50.0
        self.view.roundCorners([.topLeft, .topRight], radius: 15.0)
        self.view.backgroundColor = .white
        
        playerImageView.layer.cornerRadius = playerImageView.frame.size.width / 2
    }
}

extension ScheduleDetailLoadPlayerViewController {
    private func cancelButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 42/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 37.5/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 45/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .height, relatedBy: .equal,
            toItem: cancelButton, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func nameLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 37.5/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 120/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 27/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func batterButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 151/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 93/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: batterButton, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 20/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func pitcherButtonConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 269/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 93/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: pitcherButton, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 20/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func batterButtonUnderViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 151/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 105.5/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 36/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 3/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func pitcherButtonUnderViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 269/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 105.5/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 36/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: buttonUnderView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 3/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func playerImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: playerImageView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: playerImageView, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 180/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: playerImageView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 106/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: playerImageView, attribute: .height, relatedBy: .equal,
            toItem: playerImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func divisionViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .centerY, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 247.5/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 1/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func loadBatterViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: loadBatterView, attribute: .top, relatedBy: .equal,
            toItem: divisionView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: loadBatterView, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: loadBatterView, attribute: .trailing, relatedBy: .equal,
            toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: loadBatterView, attribute: .bottom, relatedBy: .equal,
            toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -50.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
    
    private func loadPitcherViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: loadPitcherView, attribute: .top, relatedBy: .equal,
            toItem: divisionView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: loadPitcherView, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: loadPitcherView, attribute: .trailing, relatedBy: .equal,
            toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: loadPitcherView, attribute: .bottom, relatedBy: .equal,
            toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -50.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
}
