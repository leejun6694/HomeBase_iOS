//
//  ScheduleMonthlySectionHeaderView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 26..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleMonthlySectionHeaderView: UIView {

    // MARK: Properties
    
    private lazy var monthLabel:UILabel = {
        let monthLabel = UILabel()
        monthLabel.text = "01월,"
        monthLabel.textColor = UIColor(red: 44.0/255.0,
                                        green: 44.0/255.0,
                                        blue: 44.0/255.0,
                                        alpha: 1.0)
        monthLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 23.0)
        monthLabel.adjustsFontSizeToFitWidth = true
        monthLabel.minimumScaleFactor = 0.5
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return monthLabel
    }()
    
    private lazy var yearLabel:UILabel = {
        let yearLabel = UILabel()
        yearLabel.text = "2018"
        yearLabel.textColor = UIColor(red: 44.0/255.0,
                                       green: 44.0/255.0,
                                       blue: 44.0/255.0,
                                       alpha: 1.0)
        yearLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15.0)
        yearLabel.adjustsFontSizeToFitWidth = true
        yearLabel.minimumScaleFactor = 0.5
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return yearLabel
    }()
    
    // MARK: Draw
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor(red: 192.0/255.0,
                                       green: 222.0/255.0,
                                       blue: 229.0/255.0,
                                       alpha: 1.0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(monthLabel)
        self.addConstraints(monthLabelConstraints())
        self.addSubview(yearLabel)
        self.addConstraints(yearLabelConstraints())
    }
}

extension ScheduleMonthlySectionHeaderView {
    private func monthLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: monthLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 19/28.5, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: monthLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 30/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: monthLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 49/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: monthLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 29/57, constant: 0.0)
        
        return [topConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func yearLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: yearLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 28/28.5, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: yearLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 82/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: yearLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 31/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: yearLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 15/57, constant: 0.0)
        
        return [topConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
}
