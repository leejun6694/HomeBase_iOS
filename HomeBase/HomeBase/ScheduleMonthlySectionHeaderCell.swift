//
//  ScheduleMonthlySectionHeaderCell.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 4. 3..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleMonthlySectionHeaderCell: UITableViewCell {

    // MARK: Properties
    
    var matchDate = Date() {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko-KR")
            dateFormatter.dateFormat = "yyyy"
            let year = dateFormatter.string(from: matchDate)
            dateFormatter.dateFormat = "MM"
            let month = dateFormatter.string(from: matchDate)
            
            monthLabel.text = "\(month)월,"
            yearLabel.text = "\(year)"
        }
    }
    
    private lazy var monthLabel: UILabel = {
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
    
    private lazy var yearLabel: UILabel = {
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
    
    private lazy var monthlyRecordLabel: UILabel = {
        let monthlyRecordLabel = UILabel()
        monthlyRecordLabel.textAlignment = .right
        
        let numberAttr = [NSAttributedStringKey.font: UIFont(name: "AppleSDGothicNeo-Bold", size: 15.0),
                          NSAttributedStringKey.foregroundColor: UIColor(red: 44.0/255.0,
                                                                         green: 44.0/255.0,
                                                                         blue: 44.0/255.0,
                                                                         alpha: 1.0)]
        let charAttr = [NSAttributedStringKey.font: UIFont(name: "AppleSDGothicNeo-Light", size: 15.0),
                        NSAttributedStringKey.foregroundColor: UIColor(red: 44.0/255.0,
                                                                       green: 44.0/255.0,
                                                                       blue: 44.0/255.0,
                                                                       alpha: 1.0)]
        
        var monthlyRecordText = NSMutableAttributedString(string: "")
        let winNumber = NSMutableAttributedString(string: "10", attributes: numberAttr)
        let winChar = NSMutableAttributedString(string: "승 ", attributes: charAttr)
        let drawNumber = NSMutableAttributedString(string: "10", attributes: numberAttr)
        let drawChar = NSMutableAttributedString(string: "무 ", attributes: charAttr)
        let loseNumber = NSMutableAttributedString(string: "10", attributes: numberAttr)
        let loseChar = NSMutableAttributedString(string: "패 ", attributes: charAttr)
        
        monthlyRecordText.append(winNumber)
        monthlyRecordText.append(winChar)
        monthlyRecordText.append(drawNumber)
        monthlyRecordText.append(drawChar)
        monthlyRecordText.append(loseNumber)
        monthlyRecordText.append(loseChar)
        
        monthlyRecordLabel.attributedText = monthlyRecordText
        monthlyRecordLabel.adjustsFontSizeToFitWidth = true
        monthlyRecordLabel.minimumScaleFactor = 0.5
        monthlyRecordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return monthlyRecordLabel
    }()
    
    // MARK: Init
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        self.addSubview(monthlyRecordLabel)
        self.addConstraints(monthlyRecordLabelConstraints())
    }
}

extension ScheduleMonthlySectionHeaderCell {
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
    
    private func monthlyRecordLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: monthlyRecordLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 21/28.5, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: monthlyRecordLabel, attribute: .trailing, relatedBy: .equal,
            toItem: self, attribute: .trailing, multiplier: 391/414, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: monthlyRecordLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 100/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: monthlyRecordLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 29/57, constant: 0.0)
        
        return [topConstraint, trailingConstraint, widthConstraint, heightConstraint]
    }
}
