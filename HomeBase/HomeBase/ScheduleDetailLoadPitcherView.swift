//
//  ScheduleDetailLoadPitcherView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 14..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class ScheduleDetailLoadPitcherView: UIView {

    // MARK: Properties
    
    var win = 0 { didSet { winView.record = "\(win)" } }
    var lose = 0 { didSet { loseView.record = "\(lose)" } }
    var hold = 0 { didSet { holdView.record = "\(hold)" } }
    var save = 0 { didSet { saveView.record = "\(save)" } }
    var ER = 0 { didSet { ERView.record = "\(ER)" } }
    var strikeOuts = 0 { didSet { strikeOutsView.record = "\(strikeOuts)" } }
    var hits = 0 { didSet { hitsView.record = "\(hits)" } }
    var homeRuns = 0 { didSet { homeRunsView.record = "\(homeRuns)" } }
    var walks = 0 { didSet { walksView.record = "\(walks)" } }
    var hitBatters = 0 { didSet { hitBattersView.record = "\(hitBatters)" } }
    var inning: Double = 0.0 {
        didSet {
            let inningReminder = Int(inning * 10.0) % 10
            if inningReminder == 0 {
                inningView.record = "\(Int(inning))"
            } else {
                inningView.record = "\(Int(inning)) \(inningReminder)/3"
            }
        }
    }
    
    private lazy var winView: ScheduleDetailRecordView = {
        let winView = ScheduleDetailRecordView()
        winView.recordName = "승리"
        winView.record = "0"
        winView.translatesAutoresizingMaskIntoConstraints = false
        
        return winView
    }()
    
    private lazy var loseView: ScheduleDetailRecordView = {
        let loseView = ScheduleDetailRecordView()
        loseView.recordName = "패배"
        loseView.record = "0"
        loseView.translatesAutoresizingMaskIntoConstraints = false
        
        return loseView
    }()
    
    private lazy var holdView: ScheduleDetailRecordView = {
        let holdView = ScheduleDetailRecordView()
        holdView.recordName = "홀드"
        holdView.record = "0"
        holdView.translatesAutoresizingMaskIntoConstraints = false
        
        return holdView
    }()
    
    private lazy var saveView: ScheduleDetailRecordView = {
        let saveView = ScheduleDetailRecordView()
        saveView.recordName = "세이브"
        saveView.record = "0"
        saveView.translatesAutoresizingMaskIntoConstraints = false
        
        return saveView
    }()
    
    private lazy var inningView: ScheduleDetailRecordView = {
        let inningView = ScheduleDetailRecordView()
        inningView.recordName = "이닝"
        inningView.record = "0"
        inningView.translatesAutoresizingMaskIntoConstraints = false
        
        return inningView
    }()
    
    private lazy var ERView: ScheduleDetailRecordView = {
        let ERView = ScheduleDetailRecordView()
        ERView.recordName = "자책점"
        ERView.record = "0"
        ERView.translatesAutoresizingMaskIntoConstraints = false
        
        return ERView
    }()
    
    private lazy var strikeOutsView: ScheduleDetailRecordView = {
        let strikeOutsView = ScheduleDetailRecordView()
        strikeOutsView.recordName = "탈삼진"
        strikeOutsView.record = "0"
        strikeOutsView.translatesAutoresizingMaskIntoConstraints = false
        
        return strikeOutsView
    }()
    
    private lazy var hitsView: ScheduleDetailRecordView = {
        let hitsView = ScheduleDetailRecordView()
        hitsView.recordName = "피안타"
        hitsView.record = "0"
        hitsView.translatesAutoresizingMaskIntoConstraints = false
        
        return hitsView
    }()
    
    private lazy var homeRunsView: ScheduleDetailRecordView = {
        let homeRunsView = ScheduleDetailRecordView()
        homeRunsView.recordName = "피홈런"
        homeRunsView.record = "0"
        homeRunsView.translatesAutoresizingMaskIntoConstraints = false
        
        return homeRunsView
    }()
    
    private lazy var walksView: ScheduleDetailRecordView = {
        let walksView = ScheduleDetailRecordView()
        walksView.recordName = "볼넷"
        walksView.record = "0"
        walksView.translatesAutoresizingMaskIntoConstraints = false
        
        return walksView
    }()
    
    private lazy var hitBattersView: ScheduleDetailRecordView = {
        let hitBattersView = ScheduleDetailRecordView()
        hitBattersView.recordName = "사구"
        hitBattersView.record = "0"
        hitBattersView.translatesAutoresizingMaskIntoConstraints = false
        
        return hitBattersView
    }()
    
    private lazy var firstStackView: UIStackView = {
        let firstStackView = UIStackView()
        firstStackView.axis = .horizontal
        firstStackView.distribution = .fillEqually
        firstStackView.addArrangedSubview(winView)
        firstStackView.addArrangedSubview(loseView)
        firstStackView.addArrangedSubview(holdView)
        firstStackView.addArrangedSubview(saveView)
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return firstStackView
    }()
    
    private lazy var secondStackView: UIStackView = {
        let secondStackView = UIStackView()
        secondStackView.axis = .horizontal
        secondStackView.distribution = .fillEqually
        secondStackView.addArrangedSubview(inningView)
        secondStackView.addArrangedSubview(ERView)
        secondStackView.addArrangedSubview(strikeOutsView)
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return secondStackView
    }()
    
    private lazy var thirdStackView: UIStackView = {
        let thirdStackView = UIStackView()
        thirdStackView.axis = .horizontal
        thirdStackView.distribution = .fillEqually
        thirdStackView.addArrangedSubview(hitsView)
        thirdStackView.addArrangedSubview(homeRunsView)
        thirdStackView.addArrangedSubview(walksView)
        thirdStackView.addArrangedSubview(hitBattersView)
        thirdStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return thirdStackView
    }()
    
    private lazy var recordStackView: UIStackView = {
        let recordStackView = UIStackView()
        recordStackView.axis = .vertical
        recordStackView.distribution = .fillEqually
        recordStackView.spacing = self.frame.size.height * 38/736
        recordStackView.addArrangedSubview(firstStackView)
        recordStackView.addArrangedSubview(secondStackView)
        recordStackView.addArrangedSubview(thirdStackView)
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

extension ScheduleDetailLoadPitcherView {
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
            toItem: self, attribute: .height, multiplier: 316/488, constant: 0.0)
        
        return [centerXConstraint, centerYConstraint, widthConstraint, heightConstraint]
    }
}
