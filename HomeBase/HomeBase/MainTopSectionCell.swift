//
//  MainTopSectionCell.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 15..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class MainTopSectionCell: UITableViewCell {
    
    // MARK: Properties
    
    var cellTitle:String = "" {
        didSet {
            titleLabel.text = cellTitle
        }
    }
    
    var sectionImage:UIImage = UIImage() {
        didSet {
            sectionImageView.image = sectionImage
        }
    }
    
    private lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "default"
        titleLabel.textColor = UIColor(red: 44.0/255.0,
                                          green: 44.0/255.0,
                                          blue: 44.0/255.0,
                                          alpha: 1.0)
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15.0)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private lazy var firstPlaceView:MainTopRankingView = {
        let firstPlaceView = MainTopRankingView()
        firstPlaceView.layer.cornerRadius = 10.0
        firstPlaceView.baseViewColor = UIColor(red: 44.0/255.0,
                                           green: 44.0/255.0,
                                           blue: 44.0/255.0,
                                           alpha: 1.0)
        firstPlaceView.ranking = "1"
        firstPlaceView.translatesAutoresizingMaskIntoConstraints = false
        
        return firstPlaceView
    }()
    
    private lazy var secondPlaceView:MainTopRankingView = {
        let secondPlaceView = MainTopRankingView()
        secondPlaceView.layer.cornerRadius = 10.0
        secondPlaceView.baseViewColor = UIColor(red: 5.0/255.0,
                                            green: 62.0/255.0,
                                            blue: 88.0/255.0,
                                            alpha: 1.0)
        secondPlaceView.ranking = "2"
        secondPlaceView.translatesAutoresizingMaskIntoConstraints = false
        
        return secondPlaceView
    }()
    
    private lazy var thirdPlaceView:MainTopRankingView = {
        let thirdPlaceView = MainTopRankingView()
        thirdPlaceView.layer.cornerRadius = 10.0
        thirdPlaceView.baseViewColor = UIColor(red: 0.0/255.0,
                                               green: 180.0/255.0,
                                               blue: 223.0/255.0,
                                               alpha: 1.0)
        thirdPlaceView.ranking = "3"
        thirdPlaceView.translatesAutoresizingMaskIntoConstraints = false
        
        return thirdPlaceView
    }()
    
    private lazy var sectionImageView:UIImageView = {
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
        
        self.backgroundColor = UIColor(red: 239.0/255.0,
                                       green: 239.0/255.0,
                                       blue: 239.0/255.0,
                                       alpha: 1.0)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(titleLabel)
        self.addConstraints(titleLabelConstraints())
        self.addSubview(firstPlaceView)
        self.addConstraints(firstPlaceViewConstraints())
        self.addSubview(secondPlaceView)
        self.addConstraints(secondPlaceViewConstraints())
        self.addSubview(thirdPlaceView)
        self.addConstraints(thirdPlaceViewConstraints())
        self.addSubview(sectionImageView)
        self.addConstraints(sectionImageViewConstraints())
    }
}

extension MainTopSectionCell {
    private func titleLabelConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 7/111.5, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 28/207, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 56/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 15/223, constant: 0.0)
        
        return [topConstraint, leadingConstraint, widthConstraint, heightConstraint]
    }
    
    private func firstPlaceViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: firstPlaceView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 79/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: firstPlaceView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 109.5/111.5, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: firstPlaceView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 120/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: firstPlaceView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 147/223, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func secondPlaceViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: secondPlaceView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 209/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: secondPlaceView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 109.5/111.5, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: secondPlaceView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 120/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: secondPlaceView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 147/223, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func thirdPlaceViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: thirdPlaceView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 338/207, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: thirdPlaceView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 109.5/111.5, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: thirdPlaceView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 120/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: thirdPlaceView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 147/223, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
    
    private func sectionImageViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: sectionImageView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 337.5/207, constant: 0.0)
        let topConstraint = NSLayoutConstraint(
            item: sectionImageView, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: sectionImageView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 87/414, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: sectionImageView, attribute: .bottom, relatedBy: .equal,
            toItem: self, attribute: .bottom, multiplier: 36/223, constant: 0.0)
        
        return [centerXConstraint, topConstraint, widthConstraint, bottomConstraint]
    }
}
