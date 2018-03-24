//
//  ScheduleDetailRecordPlayerTableViewCell.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 3. 5..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleDetailRecordPlayerTableViewCell: UITableViewCell {

    // MARK: Properties
    
    var headText = "" {
        didSet { headLabel.text = headText }
    }
    
    private lazy var headLabel: UILabel = {
        let headLabel = UILabel()
        headLabel.text = "\(headText)"
        headLabel.textColor = UIColor(red: 44.0/255.0,
                                      green: 44.0/255.0,
                                      blue: 44.0/255.0,
                                      alpha: 1.0)
        headLabel.textAlignment = .center
        headLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 16.0)
        headLabel.adjustsFontSizeToFitWidth = true
        headLabel.minimumScaleFactor = 0.5
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return headLabel
    }()
    
    lazy var minusImageView: UIImageView = {
        let minusImageView = UIImageView(image: #imageLiteral(resourceName: "iconMinus"))
        minusImageView.tintColor = UIColor(red: 44.0/255.0,
                                        green: 44.0/255.0,
                                        blue: 44.0/255.0,
                                        alpha: 1.0)
        minusImageView.backgroundColor = UIColor.clear
        minusImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return minusImageView
    }()
    
    lazy var recordLabel: UILabel = {
        let recordLabel = UILabel()
        recordLabel.text = "0"
        recordLabel.textColor = UIColor(red: 0.0,
                                        green: 180.0/255.0,
                                        blue: 223.0/255.0,
                                        alpha: 1.0)
        recordLabel.textAlignment = .center
        recordLabel.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 47.0)
        recordLabel.adjustsFontSizeToFitWidth = true
        recordLabel.minimumScaleFactor = 0.5
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return recordLabel
    }()
    
    lazy var plusImageView: UIImageView = {
        let plusImageView = UIImageView(image: #imageLiteral(resourceName: "iconPlus"))
        plusImageView.tintColor = UIColor(red: 44.0/255.0,
                                           green: 44.0/255.0,
                                           blue: 44.0/255.0,
                                           alpha: 1.0)
        plusImageView.backgroundColor = UIColor.clear
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return plusImageView
    }()
    
    private lazy var divisionView: UIView = {
        let divisionView = UIView()
        divisionView.backgroundColor = UIColor(red: 44.0/255.0,
                                               green: 44.0/255.0,
                                               blue: 44.0/255.0,
                                               alpha: 0.6)
        divisionView.translatesAutoresizingMaskIntoConstraints = false
        
        return divisionView
    }()
    
    // MARK: Methods
    
    func imageViewEnabled() {
        headLabel.alpha = 1.0
        recordLabel.alpha = 1.0
        minusImageView.alpha = 1.0
        minusImageView.isUserInteractionEnabled = true
        plusImageView.alpha = 1.0
        plusImageView.isUserInteractionEnabled = true
    }
    
    func imageViewDisabled() {
        headLabel.alpha = 0.5
        recordLabel.alpha = 0.5
        minusImageView.alpha = 0.5
        minusImageView.isUserInteractionEnabled = false
        plusImageView.alpha = 0.5
        plusImageView.isUserInteractionEnabled = false
    }
    
    // MARK: Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(headLabel)
        self.addConstraints(headLabelConstraints())
        self.addSubview(minusImageView)
        self.addConstraints(minusImageViewConstraints())
        self.addSubview(recordLabel)
        self.addConstraints(recordLabelConstraints())
        self.addSubview(plusImageView)
        self.addConstraints(plusImageViewConstraints())
        self.addSubview(divisionView)
        self.addConstraints(divisionViewConstraints())
    }
}

extension ScheduleDetailRecordPlayerTableViewCell {
    private func headLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: headLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: headLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 25/52.25, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: headLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 45/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: headLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 22/104.5, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func minusImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: minusImageView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 58/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: minusImageView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 62.5/52.25, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: minusImageView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: minusImageView, attribute: .height, relatedBy: .equal,
            toItem: minusImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func recordLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 70.5/52.25, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 120/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 50/104.5, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func plusImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: plusImageView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 354/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: plusImageView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 62.5/52.25, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: plusImageView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 40/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: plusImageView, attribute: .height, relatedBy: .equal,
            toItem: plusImageView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func divisionViewConstraints() -> [NSLayoutConstraint] {
        let bottomConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .bottom, relatedBy: .equal,
            toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: divisionView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 0.3/104.5, constant: 0.0)
        
        return [bottomConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
}
