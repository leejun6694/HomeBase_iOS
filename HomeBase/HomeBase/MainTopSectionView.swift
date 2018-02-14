//
//  MainTopSectionView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 2. 14..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class MainTopSectionView: UIView {

    // MARK: Properties
    
    var sectionTitle:String = "" {
        didSet {
            titleLabel.text = sectionTitle
        }
    }
    
    private lazy var baseView:UIView = {
        let baseView = UIView()
        baseView.backgroundColor = UIColor(red: 239.0/255.0,
                                           green: 239.0/255.0,
                                           blue: 239.0/255.0,
                                           alpha: 239.0/255.0)
        baseView.translatesAutoresizingMaskIntoConstraints = false
        
        return baseView
    }()
    
    private lazy var titleView:UIView = {
        let titleView = UIView()
        titleView.backgroundColor = UIColor(red: 44.0/255.0,
                                            green: 44.0/255.0,
                                            blue: 44.0/255.0,
                                            alpha: 1.0)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        return titleView
    }()
    
    private lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "default"
        titleLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 25.0)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    // MARK: Draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(baseView)
        self.addConstraints(baseViewConstraints())
        baseView.addSubview(titleView)
        baseView.addConstraints(titleViewConstraints())
        baseView.addSubview(titleLabel)
        baseView.addConstraints(titleLabelConstraints())
    }
}

extension MainTopSectionView {
    private func baseViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = NSLayoutConstraint(
            item: baseView, attribute: .top, relatedBy: .equal,
            toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let leadingConstraint = NSLayoutConstraint(
            item: baseView, attribute: .leading, relatedBy: .equal,
            toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(
            item: baseView, attribute: .trailing, relatedBy: .equal,
            toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: baseView, attribute: .bottom, relatedBy: .equal,
            toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        return [topConstraint, leadingConstraint, trailingConstraint, bottomConstraint]
    }
    
    private func titleViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: titleView, attribute: .centerX, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 29/207, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: titleView, attribute: .bottom, relatedBy: .equal,
            toItem: baseView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: titleView, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 2/414, constant: 0.0)
        let heightConstriant = NSLayoutConstraint(
            item: titleView, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 27/62, constant: 0.0)
        
        return[centerXConstraint, bottomConstraint, widthConstraint, heightConstriant]
    }
    
    private func titleLabelConstraints() -> [NSLayoutConstraint] {
        let leadingConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .leading, relatedBy: .equal,
            toItem: baseView, attribute: .centerX, multiplier: 39/207, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .bottom, relatedBy: .equal,
            toItem: baseView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .width, relatedBy: .equal,
            toItem: baseView, attribute: .width, multiplier: 114/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: titleLabel, attribute: .height, relatedBy: .equal,
            toItem: baseView, attribute: .height, multiplier: 25/62, constant: 0.0)
        
        return [leadingConstraint, bottomConstraint, widthConstraint, heightConstraint]
    }
}
