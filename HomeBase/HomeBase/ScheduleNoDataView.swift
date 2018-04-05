//
//  ScheduleNoDataView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 3. 22..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleNoDataView: UIView {
    
    // MARK: Properties
    
    private lazy var baseView: UIView = {
        let baseView = UIView()
        baseView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        
        return baseView
    }()
    
    private lazy var smallLabel: UILabel = {
        let smallLabel = UILabel()
        smallLabel.text = "앗! 아직 등록된 일정이 없네요"
        smallLabel.textColor = HBColor.lightGray
        smallLabel.textAlignment = .center
        smallLabel.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 13.0)
        smallLabel.adjustsFontSizeToFitWidth = true
        smallLabel.minimumScaleFactor = 0.5
        smallLabel.translatesAutoresizingMaskIntoConstraints = false
        smallLabel.alpha = 0.5
        
        return smallLabel
    }()
    
    private lazy var bigLabel: UILabel = {
        let bigLabel = UILabel()
        bigLabel.text = "이번 주말에 경기 어떠세요?"
        bigLabel.textColor = HBColor.lightGray
        bigLabel.textAlignment = .center
        bigLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 18.0)
        bigLabel.adjustsFontSizeToFitWidth = true
        bigLabel.minimumScaleFactor = 0.5
        bigLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return bigLabel
    }()
    
    private lazy var pitcherImageView: UIImageView = {
        let pitcherImageView = UIImageView(image: #imageLiteral(resourceName: "pitcherImage1"))
        pitcherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return pitcherImageView
    }()
    
    private lazy var batterImageView: UIImageView = {
        let batterImageView = UIImageView(image: #imageLiteral(resourceName: "batterImage1"))
        batterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return batterImageView
    }()

    // MARK: Draw
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor(red: 192, green: 222, blue: 229, alpha: 1.0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(baseView)
        self.addConstraints(baseViewConstraints())
        baseView.addSubview(smallLabel)
        baseView.addConstraints(smallLabelConstraints())
        baseView.addSubview(bigLabel)
        baseView.addConstraints(bigLabelConstraints())
        baseView.addSubview(pitcherImageView)
        baseView.addConstraints(pitcherImageViewConstraints())
        baseView.addSubview(batterImageView)
        baseView.addConstraints(batterImageViewConstraints())
    }
}

extension ScheduleNoDataView {
    private func baseViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: baseView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: baseView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: baseView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 389/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: baseView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func smallLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: smallLabel, attribute: .centerX, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: smallLabel, attribute: .top, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 43/63.5, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: smallLabel, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 218/389, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: smallLabel, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 18/127, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func bigLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: bigLabel, attribute: .centerX, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: bigLabel, attribute: .top, relatedBy: .equal,
            toItem: baseView, attribute: .centerY, multiplier: 70/63.5, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: bigLabel, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 270/389, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: bigLabel, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 22/127, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func pitcherImageViewConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: pitcherImageView, attribute: .leading, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 15/194.5, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: pitcherImageView, attribute: .bottom, relatedBy: .equal,
            toItem: baseView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: pitcherImageView, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 65/389, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: pitcherImageView, attribute: .height, relatedBy: .equal,
            toItem: pitcherImageView, attribute: .width, multiplier: 92/65, constant: 0.0)
        
        return [leadingConstraint, bottomConstraint, widthConstraint, heightConstraint]
    }
    
    private func batterImageViewConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: batterImageView, attribute: .leading, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 310/194.5, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: batterImageView, attribute: .bottom, relatedBy: .equal,
            toItem: baseView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: batterImageView, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 67/389, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: batterImageView, attribute: .height, relatedBy: .equal,
            toItem: batterImageView, attribute: .width, multiplier: 92/67, constant: 0.0)
        
        return [leadingConstraint, bottomConstraint, widthConstraint, heightConstraint]
    }
}
