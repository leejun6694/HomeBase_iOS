//
//  PersonalRankingGraphView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 23..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class PersonalRankingGraphView: UIView {

    // MARK: Properties
    
    var percentage: Double = 0 {
        didSet {
            animateGraph(duration: 1, percentage: CGFloat(percentage))
            percentageLabel.text = "\(Int(percentage * 100))%"
        }
    }
    
    private var baseLayer: CAShapeLayer!
    private var whiteLayer: CAShapeLayer!
    private var percentageLayer: CAShapeLayer!
    
    private lazy var percentageLabel: UILabel = {
        let percentageLabel = UILabel()
        percentageLabel.text = "00%"
        percentageLabel.textColor = .white
        percentageLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 30.0)
        percentageLabel.textAlignment = .center
        percentageLabel.adjustsFontSizeToFitWidth = true
        percentageLabel.minimumScaleFactor = 0.5
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return percentageLabel
    }()
    
    // MARK: Methods
    
    private func animateGraph(duration: TimeInterval, percentage: CGFloat) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")

        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = percentage

        animation.timingFunction = CAMediaTimingFunction(
            name: kCAMediaTimingFunctionLinear)
        percentageLayer.strokeEnd = percentage

        percentageLayer.add(animation, forKey: "animateCircle")
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
            radius: frame.size.width / 2,
            startAngle: CGFloat(-(Double.pi / 2)),
            endAngle: CGFloat((Double.pi * 2) - (Double.pi / 2)),
            clockwise: true)
        
        percentageLayer = CAShapeLayer()
        percentageLayer.path = circlePath.cgPath
        percentageLayer.fillColor = HBColor.lightGray.cgColor
        percentageLayer.strokeColor = HBColor.correct.cgColor
        percentageLayer.lineWidth = 10.0
        percentageLayer.strokeStart = 0.0
        percentageLayer.strokeEnd = 0.0
        
        whiteLayer = CAShapeLayer()
        whiteLayer.path = circlePath.cgPath
        whiteLayer.fillColor = HBColor.lightGray.cgColor
        whiteLayer.strokeColor = UIColor.white.cgColor
        whiteLayer.lineWidth = 10.0
        whiteLayer.strokeStart = 0.0
        whiteLayer.strokeEnd = 1.0
        
        baseLayer = CAShapeLayer()
        baseLayer.path = circlePath.cgPath
        baseLayer.fillColor = HBColor.lightGray.cgColor
        baseLayer.strokeColor = HBColor.lightGray.cgColor
        baseLayer.lineWidth = 1.0
        baseLayer.strokeStart = 0.0
        baseLayer.strokeEnd = 1.0
        
        layer.addSublayer(whiteLayer)
        layer.addSublayer(percentageLayer)
        layer.addSublayer(baseLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(percentageLabel)
        self.addConstraints(percentageLabelConstraints())
    }
}

extension PersonalRankingGraphView {
    private func percentageLabelConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: percentageLabel, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: percentageLabel, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: percentageLabel, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 55/125, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: percentageLabel, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 35/125, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
