//
//  ScheduleDetailLoadBatterView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 14..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleDetailLoadBatterView: UIView {

    // MARK: Properties
    
    var singleHit = 0 { didSet { singleHitView.record = "\(singleHit)" } }
    var doubleHit = 0 { didSet { doubleHitView.record = "\(doubleHit)" } }
    var tripleHit = 0 { didSet { tripleHitView.record = "\(tripleHit)" } }
    var homeRun = 0 { didSet { homeRunView.record = "\(homeRun)" } }
    var baseOnBalls = 0 { didSet { baseOnBallsView.record = "\(baseOnBalls)" } }
    var sacrificeHit = 0 { didSet { sacrificeHitView.record = "\(sacrificeHit)" } }
    var strikeOut = 0 { didSet { strikeOutView.record = "\(strikeOut)" } }
    var groundBall = 0 { didSet { groundBallView.record = "\(groundBall)" } }
    var flyBall = 0 { didSet { flyBallView.record = "\(flyBall)" } }
    var stolenBase = 0 { didSet { stolenBaseView.record = "\(stolenBase)" } }
    var hitByPitch = 0 { didSet { hitByPitchView.record = "\(hitByPitch)" } }
    var run = 0 { didSet { runView.record = "\(run)" } }
    var RBI = 0 { didSet { RBIView.record = "\(RBI)" } }
    
    private lazy var singleHitView: ScheduleDetailRecordView = {
        let singleHitView = ScheduleDetailRecordView()
        singleHitView.recordName = "1루타"
        singleHitView.record = "0"
        singleHitView.translatesAutoresizingMaskIntoConstraints = false
        
        return singleHitView
    }()
    
    private lazy var doubleHitView: ScheduleDetailRecordView = {
        let doubleHitView = ScheduleDetailRecordView()
        doubleHitView.recordName = "2루타"
        doubleHitView.record = "0"
        doubleHitView.translatesAutoresizingMaskIntoConstraints = false
        
        return doubleHitView
    }()
    
    private lazy var tripleHitView: ScheduleDetailRecordView = {
        let tripleHitView = ScheduleDetailRecordView()
        tripleHitView.recordName = "3루타"
        tripleHitView.record = "0"
        tripleHitView.translatesAutoresizingMaskIntoConstraints = false
        
        return tripleHitView
    }()
    
    private lazy var homeRunView: ScheduleDetailRecordView = {
        let homeRunView = ScheduleDetailRecordView()
        homeRunView.recordName = "홈런"
        homeRunView.record = "0"
        homeRunView.translatesAutoresizingMaskIntoConstraints = false
        
        return homeRunView
    }()
    
    private lazy var baseOnBallsView: ScheduleDetailRecordView = {
        let baseOnBallsView = ScheduleDetailRecordView()
        baseOnBallsView.recordName = "볼넷"
        baseOnBallsView.record = "0"
        baseOnBallsView.translatesAutoresizingMaskIntoConstraints = false
        
        return baseOnBallsView
    }()
    
    private lazy var sacrificeHitView: ScheduleDetailRecordView = {
        let sacrificeHitView = ScheduleDetailRecordView()
        sacrificeHitView.recordName = "희생타"
        sacrificeHitView.record = "0"
        sacrificeHitView.translatesAutoresizingMaskIntoConstraints = false
        
        return sacrificeHitView
    }()
    
    private lazy var strikeOutView: ScheduleDetailRecordView = {
        let strikeOutView = ScheduleDetailRecordView()
        strikeOutView.recordName = "삼진"
        strikeOutView.record = "0"
        strikeOutView.translatesAutoresizingMaskIntoConstraints = false
        
        return strikeOutView
    }()
    
    private lazy var groundBallView: ScheduleDetailRecordView = {
        let groundBallView = ScheduleDetailRecordView()
        groundBallView.recordName = "땅볼"
        groundBallView.record = "0"
        groundBallView.translatesAutoresizingMaskIntoConstraints = false
        
        return groundBallView
    }()
    
    private lazy var flyBallView: ScheduleDetailRecordView = {
        let flyBallView = ScheduleDetailRecordView()
        flyBallView.recordName = "뜬공"
        flyBallView.record = "0"
        flyBallView.translatesAutoresizingMaskIntoConstraints = false
        
        return flyBallView
    }()
    
    private lazy var stolenBaseView: ScheduleDetailRecordView = {
        let stolenBaseView = ScheduleDetailRecordView()
        stolenBaseView.recordName = "도루"
        stolenBaseView.record = "0"
        stolenBaseView.translatesAutoresizingMaskIntoConstraints = false
        
        return stolenBaseView
    }()
    
    private lazy var hitByPitchView: ScheduleDetailRecordView = {
        let hitByPitchView = ScheduleDetailRecordView()
        hitByPitchView.recordName = "사구"
        hitByPitchView.record = "0"
        hitByPitchView.translatesAutoresizingMaskIntoConstraints = false
        
        return hitByPitchView
    }()
    
    private lazy var runView: ScheduleDetailRecordView = {
        let runView = ScheduleDetailRecordView()
        runView.recordName = "득점"
        runView.record = "0"
        runView.translatesAutoresizingMaskIntoConstraints = false
        
        return runView
    }()
    
    private lazy var RBIView: ScheduleDetailRecordView = {
        let RBIView = ScheduleDetailRecordView()
        RBIView.recordName = "타점"
        RBIView.record = "0"
        RBIView.translatesAutoresizingMaskIntoConstraints = false
        
        return RBIView
    }()
    
    private lazy var firstStackView: UIStackView = {
        let firstStackView = UIStackView()
        firstStackView.axis = .horizontal
        firstStackView.distribution = .fillEqually
        firstStackView.addArrangedSubview(singleHitView)
        firstStackView.addArrangedSubview(doubleHitView)
        firstStackView.addArrangedSubview(tripleHitView)
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return firstStackView
    }()
    
    private lazy var secondStackView: UIStackView = {
        let secondStackView = UIStackView()
        secondStackView.axis = .horizontal
        secondStackView.distribution = .fillEqually
        secondStackView.addArrangedSubview(homeRunView)
        secondStackView.addArrangedSubview(baseOnBallsView)
        secondStackView.addArrangedSubview(sacrificeHitView)
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return secondStackView
    }()
    
    private lazy var thirdStackView: UIStackView = {
        let thirdStackView = UIStackView()
        thirdStackView.axis = .horizontal
        thirdStackView.distribution = .fillEqually
        thirdStackView.addArrangedSubview(strikeOutView)
        thirdStackView.addArrangedSubview(groundBallView)
        thirdStackView.addArrangedSubview(flyBallView)
        thirdStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return thirdStackView
    }()
    
    private lazy var fourthStackView: UIStackView = {
        let fourthStackView = UIStackView()
        fourthStackView.axis = .horizontal
        fourthStackView.distribution = .fillEqually
        fourthStackView.addArrangedSubview(stolenBaseView)
        fourthStackView.addArrangedSubview(hitByPitchView)
        fourthStackView.addArrangedSubview(runView)
        fourthStackView.addArrangedSubview(RBIView)
        fourthStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return fourthStackView
    }()
    
    private lazy var recordStackView: UIStackView = {
        let recordStackView = UIStackView()
        recordStackView.axis = .vertical
        recordStackView.distribution = .fillEqually
        recordStackView.spacing = self.frame.size.height * 38/736
        recordStackView.addArrangedSubview(firstStackView)
        recordStackView.addArrangedSubview(secondStackView)
        recordStackView.addArrangedSubview(thirdStackView)
        recordStackView.addArrangedSubview(fourthStackView)
        recordStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return recordStackView
    }()
    
    // MARK: Draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.addSubview(recordStackView)
        self.addConstraints(recordStackViewConstraints())
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .white
    }
}

extension ScheduleDetailLoadBatterView {
    private func recordStackViewConstraints() -> [NSLayoutConstraint] {
        let centerXConstraint = NSLayoutConstraint(
            item: recordStackView, attribute: .centerX, relatedBy: .equal,
            toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(
            item: recordStackView, attribute: .centerY, relatedBy: .equal,
            toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widthConstraint = NSLayoutConstraint(
            item: recordStackView, attribute: .width, relatedBy: .equal,
            toItem: self, attribute: .width, multiplier: 334/414, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(
            item: recordStackView, attribute: .height, relatedBy: .equal,
            toItem: self, attribute: .height, multiplier: 434/488, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
