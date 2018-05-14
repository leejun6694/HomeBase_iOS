//
//  ScheduleDetailRecordView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 14..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleDetailRecordView: UIView {

    // MARK: Properties
    
    var recordName = "" {
        didSet { recordNameLabel.text = "\(recordName)" }
    }
    var record = "" {
        didSet { recordLabel.text = "\(record)" }
    }
    
    private lazy var recordNameLabel: UILabel = {
        let recordNameLabel = UILabel()
        recordNameLabel.text = "1루타"
        recordNameLabel.textColor = HBColor.lightGray
        recordNameLabel.textAlignment = .center
        recordNameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold",
                                      size: 13.0)
        recordNameLabel.adjustsFontSizeToFitWidth = true
        recordNameLabel.minimumScaleFactor = 0.5
        recordNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return recordNameLabel
    }()
    
    private lazy var recordLabel: UILabel = {
        let recordLabel = UILabel()
        recordLabel.text = "0"
        recordLabel.textColor = HBColor.correct
        recordLabel.textAlignment = .center
        recordLabel.font = UIFont(name: "AppleSDGothicNeo-UltraLight",
                                      size: 37.0)
        recordLabel.adjustsFontSizeToFitWidth = true
        recordLabel.minimumScaleFactor = 0.5
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return recordLabel
    }()
    
    // MARK: Draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(recordNameLabel)
        self.addConstraints(recordNameLabelConstraints())
        self.addSubview(recordLabel)
        self.addConstraints(recordLabelConstraints())
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .white
    }
}

extension ScheduleDetailRecordView {
    private func recordNameLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: recordNameLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: recordNameLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: recordNameLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: recordNameLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 20/80, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, heightConstraint]
    }
    
    private func recordLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .bottom, relatedBy: .equal,
            toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 45/80, constant: 0.0)
        
        return [centerXConstraint, bottomConstraint, widthConstraint, heightConstraint]
    }
}
