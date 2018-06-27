//
//  TeamSettingMoreViewController.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 6. 27..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class TeamSettingMoreViewController: UIViewController {

    // MARK: Properties
    
    var player: HBPlayer!
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .system)
        cancelButton.setImage(#imageLiteral(resourceName: "iconExit"), for: .normal)
        cancelButton.tintColor = HBColor.lightGray
        cancelButton.backgroundColor = UIColor.clear
        cancelButton.addTarget(
            self,
            action: #selector(cancelButtonDidTapped(_:)),
            for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        return cancelButton
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = player.name
        nameLabel.textColor = HBColor.lightGray
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20.0)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return nameLabel
    }()
    
    private lazy var firstDivisionView: UIView = {
        let firstDivisionView = UIView()
        firstDivisionView.backgroundColor = UIColor(red: 44, green: 44, blue: 44, alpha: 0.1)
        firstDivisionView.translatesAutoresizingMaskIntoConstraints = false
        
        return firstDivisionView
    }()
    
    private lazy var secondDivisionView: UIView = {
        let secondDivisionView = UIView()
        secondDivisionView.backgroundColor = UIColor(red: 44, green: 44, blue: 44, alpha: 0.1)
        secondDivisionView.translatesAutoresizingMaskIntoConstraints = false
        
        return secondDivisionView
    }()
    
    private lazy var adminView: UIView = {
        let adminView = UIView()
        adminView.isUserInteractionEnabled = true
        adminView.translatesAutoresizingMaskIntoConstraints = false
        
        return adminView
    }()
    
    private lazy var adminImageView: UIImageView = {
        let adminImageView = UIImageView(image: #imageLiteral(resourceName: "iconManage"))
        adminImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return adminImageView
    }()
    
    private lazy var adminLabel: UILabel = {
        let adminLabel = UILabel()
        adminLabel.text = "관리자 권한 부여"
        adminLabel.textColor = HBColor.lightGray
        adminLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        adminLabel.adjustsFontSizeToFitWidth = true
        adminLabel.minimumScaleFactor = 0.5
        adminLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return adminLabel
    }()
    
    private lazy var removeView: UIView = {
        let removeView = UIView()
        removeView.isUserInteractionEnabled = true
        removeView.translatesAutoresizingMaskIntoConstraints = false
        
        return removeView
    }()
    
    private lazy var removeImageView: UIImageView = {
        let removeImageView = UIImageView(image: #imageLiteral(resourceName: "iconDelete"))
        removeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return removeImageView
    }()
    
    private lazy var removeLabel: UILabel = {
        let removeLabel = UILabel()
        removeLabel.text = "팀에서 삭제"
        removeLabel.textColor = HBColor.lightGray
        removeLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)
        removeLabel.adjustsFontSizeToFitWidth = true
        removeLabel.minimumScaleFactor = 0.5
        removeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return removeLabel
    }()
    
    // MARK: Methods
    
    @objc private func cancelButtonDidTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToMemberView", sender: nil)
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(cancelButton)
        self.view.addConstraints(cancelButtonConstraints())
        self.view.addSubview(nameLabel)
        self.view.addConstraints(nameLabelConstraints())
        self.view.addSubview(firstDivisionView)
        self.view.addConstraints(firstDivisionViewConstraints())
        self.view.addSubview(secondDivisionView)
        self.view.addConstraints(secondDivisionViewConstraints())
        self.view.addSubview(adminView)
        self.view.addConstraints(adminViewConstraints())
        self.view.addSubview(removeView)
        self.view.addConstraints(removeViewConstraints())
        
        adminView.addSubview(adminImageView)
        adminView.addConstraints(adminImageViewConstraints())
        adminView.addSubview(adminLabel)
        adminView.addConstraints(adminLabelConstraints())
        
        removeView.addSubview(removeImageView)
        removeView.addConstraints(removeImageViewConstraints())
        removeView.addSubview(removeLabel)
        removeView.addConstraints(removeLabelConstraints())
    }
    
    override func viewDidLayoutSubviews() {
        self.view.isOpaque = false
        
        self.view.frame.origin.y = self.view.bounds.origin.y + self.view.frame.size.height * 502/736
        self.view.roundCorners([.topLeft, .topRight], radius: 15.0)
        self.view.backgroundColor = .white
    }
}

extension TeamSettingMoreViewController {
    private func cancelButtonConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 19/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 18/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 45/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: cancelButton, attribute: .height, relatedBy: .equal,
            toItem: cancelButton, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [leadingConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func nameLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .centerY, relatedBy: .equal,
            toItem: cancelButton, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 150/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: nameLabel, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 24/736, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func firstDivisionViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: firstDivisionView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: firstDivisionView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 82/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: firstDivisionView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: firstDivisionView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 3/736, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func secondDivisionViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: secondDivisionView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: secondDivisionView, attribute: .top, relatedBy: .equal,
            toItem: self.view, attribute: .centerY, multiplier: 157/368, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: secondDivisionView, attribute: .width, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: secondDivisionView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .width, multiplier: 3/736, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func adminViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: adminView, attribute: .top, relatedBy: .equal,
            toItem: firstDivisionView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: adminView, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: adminView, attribute: .trailing, relatedBy: .equal,
            toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: adminView, attribute: .bottom, relatedBy: .equal,
            toItem: secondDivisionView, attribute: .top, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
    
    private func removeViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: removeView, attribute: .top, relatedBy: .equal,
            toItem: secondDivisionView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: removeView, attribute: .leading, relatedBy: .equal,
            toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: removeView, attribute: .trailing, relatedBy: .equal,
            toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: removeView, attribute: .height, relatedBy: .equal,
            toItem: self.view, attribute: .height, multiplier: 74/736, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, heightConstraint]
    }
    
    private func adminImageViewConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: adminImageView, attribute: .leading, relatedBy: .equal,
            toItem: adminView, attribute: .centerX, multiplier: 109/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: adminImageView, attribute: .centerY, relatedBy: .equal,
            toItem: adminView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: adminImageView, attribute: .width, relatedBy: .equal,
            toItem: adminView, attribute: .width, multiplier: 24/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: adminImageView, attribute: .height, relatedBy: .equal,
            toItem: adminImageView, attribute: .width, multiplier: 21/24, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func adminLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: adminLabel, attribute: .leading, relatedBy: .equal,
            toItem: adminView, attribute: .centerX, multiplier: 170/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: adminLabel, attribute: .centerY, relatedBy: .equal,
            toItem: adminView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: adminLabel, attribute: .width, relatedBy: .equal,
            toItem: adminView, attribute: .width, multiplier: 160/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: adminLabel, attribute: .height, relatedBy: .equal,
            toItem: adminView, attribute: .height, multiplier: 23/69, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func removeImageViewConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: removeImageView, attribute: .leading, relatedBy: .equal,
            toItem: removeView, attribute: .centerX, multiplier: 109/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: removeImageView, attribute: .centerY, relatedBy: .equal,
            toItem: removeView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: removeImageView, attribute: .width, relatedBy: .equal,
            toItem: removeView, attribute: .width, multiplier: 24/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: removeImageView, attribute: .height, relatedBy: .equal,
            toItem: removeImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func removeLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: removeLabel, attribute: .leading, relatedBy: .equal,
            toItem: removeView, attribute: .centerX, multiplier: 170/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: removeLabel, attribute: .centerY, relatedBy: .equal,
            toItem: removeView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: removeLabel, attribute: .width, relatedBy: .equal,
            toItem: removeView, attribute: .width, multiplier: 160/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: removeLabel, attribute: .height, relatedBy: .equal,
            toItem: removeView, attribute: .height, multiplier: 23/69, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
