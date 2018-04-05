//
//  MainTopSectionHeaderCell.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 22..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class MainTopSectionHeaderCell: UITableViewCell {

    // MARK: Properties
    
    var sectionTitle:String = "" {
        didSet {
            titleLabel.text = sectionTitle
        }
    }
    
    var sectionImage:UIImage = UIImage() {
        didSet {
            sectionImageView.image = sectionImage
        }
    }
    
    private lazy var titleView: UIView = {
        let titleView = UIView()
        titleView.backgroundColor = HBColor.lightGray
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        return titleView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "default"
        titleLabel.textColor = HBColor.lightGray
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 25.0)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private lazy var sectionImageView: UIImageView = {
        let sectionImageView = UIImageView()
        sectionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return sectionImageView
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
        
        self.backgroundColor = HBColor.lightBlack
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(titleView)
        self.addConstraints(titleViewConstraints())
        self.addSubview(titleLabel)
        self.addConstraints(titleLabelConstraints())
        self.addSubview(sectionImageView)
        self.addConstraints(sectionImageViewConstraints())
    }
}

extension MainTopSectionHeaderCell {
    private func titleViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: titleView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 29/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: titleView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: titleView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 2/414, constant: 0.0)
        let heightConstriant = NSLayoutConstraint(
            item: titleView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 27/97, constant: 0.0)
        
        return[centerXConstraint, centerYConstraint, widthConstraint, heightConstriant]
    }
    
    private func titleLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 39/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 114/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 25/97, constant: 0.0)
        
        return [leadingConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func sectionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: sectionImageView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 337.5/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: sectionImageView, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 11/48.5, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: sectionImageView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 87/414, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: sectionImageView, attribute: .bottom, relatedBy: .equal,
            toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, bottomConstraint]
    }
}
