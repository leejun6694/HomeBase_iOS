//
//  ScheduleRecordView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 23..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleRecordView:UIView {

    // MARK: Properties
    
    var recordText = "" {
        didSet {
            recordLabel.text = recordText
            
            switch recordText {
            case "승":
                recordLabel.textColor = UIColor(red: 106.0/255.0,
                                                green: 219.0/255.0,
                                                blue: 246.0/255.0,
                                                alpha: 1.0)
            case "무":
                recordLabel.textColor = UIColor.white
            case "패":
                recordLabel.textColor = UIColor(red: 250.0/255.0,
                                                green: 119.0/255.0,
                                                blue: 119.0/255.0,
                                                alpha: 1.0)
            default: break
            }
        }
    }
    
    var dateText = "" {
        didSet {
            dateLabel.text = dateText
        }
    }
    
    private lazy var recordView: UIView = {
        let recordView = UIView()
        recordView.backgroundColor = UIColor(red: 44.0/255.0,
                                             green: 44.0/255.0,
                                             blue: 44.0/255.0,
                                             alpha: 1.0)
        recordView.translatesAutoresizingMaskIntoConstraints = false
        
        return recordView
    }()
    
    private lazy var recordLabel: UILabel = {
        let recordLabel = UILabel()
        recordLabel.text = "승"
        recordLabel.textColor = UIColor(red: 106.0/255.0,
                                        green: 219.0/255.0,
                                        blue: 246.0/255.0,
                                        alpha: 1.0)
        recordLabel.font = UIFont(name: "AppleSDGothicNeo-ExtraBold", size: 16.0)
        recordLabel.textAlignment = .center
        recordLabel.adjustsFontSizeToFitWidth = true
        recordLabel.minimumScaleFactor = 0.5
        recordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return recordLabel
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "00.00"
        dateLabel.textColor = UIColor(red: 44.0/255.0,
                                        green: 44.0/255.0,
                                        blue: 44.0/255.0,
                                        alpha: 1.0)
        dateLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 13.0)
        dateLabel.textAlignment = .center
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.minimumScaleFactor = 0.5
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dateLabel
    }()
    
    // MARK: Draw
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor.clear
        recordView.layer.cornerRadius = recordView.frame.size.width / 2
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(recordView)
        self.addConstraints(recordViewConstraints())
        recordView.addSubview(recordLabel)
        recordView.addConstraints(recordLabelConstraints())
        self.addSubview(dateLabel)
        self.addConstraints(dateLabelConstraints())
    }
}

extension ScheduleRecordView {
    private func recordViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: recordView, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(
            item: recordView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: recordView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: recordView, attribute: .height, relatedBy: .equal,
            toItem: recordView, attribute: .width, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
    
    private func recordLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .centerX, relatedBy: .equal,
            toItem: recordView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .centerY, relatedBy: .equal,
            toItem: recordView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .width, relatedBy: .equal,
            toItem: recordView, attribute: .width, multiplier: 18/55, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: recordLabel, attribute: .height, relatedBy: .equal,
            toItem: recordView, attribute: .height, multiplier: 18/55, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func dateLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: dateLabel, attribute: .top, relatedBy: .equal,
            toItem: recordView, attribute: .bottom, multiplier: 1.0, constant: 6.0)
        let centerXConstraint = NSLayoutConstraint(
            item: dateLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: dateLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 30/55, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: dateLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 15/76, constant: 0.0)
        
        return [topConstraint, centerXConstraint, widthConstraint, heightConstraint]
    }
}
