//
//  PersonalPitcherView.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 5. 25..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import UIKit

class PersonalPitcherView: UIView {

    // MARK: Properties
    
    private lazy var winView: RecordView = {
        let winView = RecordView()
        winView.recordName = "승리"
        winView.record = "0"
        winView.translatesAutoresizingMaskIntoConstraints = false
        
        return winView
    }()
    
    private lazy var loseView: RecordView = {
        let loseView = RecordView()
        loseView.recordName = "패배"
        loseView.record = "0"
        loseView.translatesAutoresizingMaskIntoConstraints = false
        
        return loseView
    }()
    
    private lazy var holdView: RecordView = {
        let holdView = RecordView()
        holdView.recordName = "홀드"
        holdView.record = "0"
        holdView.translatesAutoresizingMaskIntoConstraints = false
        
        return holdView
    }()
    
    private lazy var saveView: RecordView = {
        let saveView = RecordView()
        saveView.recordName = "세이브"
        saveView.record = "0"
        saveView.translatesAutoresizingMaskIntoConstraints = false
        
        return saveView
    }()
    
    private lazy var inningView: RecordView = {
        let inningView = RecordView()
        inningView.recordName = "이닝"
        inningView.record = "0"
        inningView.translatesAutoresizingMaskIntoConstraints = false
        
        return inningView
    }()
    
    private lazy var ERView: RecordView = {
        let ERView = RecordView()
        ERView.recordName = "자책점"
        ERView.record = "0"
        ERView.translatesAutoresizingMaskIntoConstraints = false
        
        return ERView
    }()
    
    private lazy var strikeOutsView: RecordView = {
        let strikeOutsView = RecordView()
        strikeOutsView.recordName = "탈삼진"
        strikeOutsView.record = "0"
        strikeOutsView.translatesAutoresizingMaskIntoConstraints = false
        
        return strikeOutsView
    }()
    
    private lazy var hitsView: RecordView = {
        let hitsView = RecordView()
        hitsView.recordName = "피안타"
        hitsView.record = "0"
        hitsView.translatesAutoresizingMaskIntoConstraints = false
        
        return hitsView
    }()
    
    private lazy var homeRunsView: RecordView = {
        let homeRunsView = RecordView()
        homeRunsView.recordName = "피홈런"
        homeRunsView.record = "0"
        homeRunsView.translatesAutoresizingMaskIntoConstraints = false
        
        return homeRunsView
    }()
    
    private lazy var walksView: RecordView = {
        let walksView = RecordView()
        walksView.recordName = "볼넷"
        walksView.record = "0"
        walksView.translatesAutoresizingMaskIntoConstraints = false
        
        return walksView
    }()
    
    private lazy var hitBattersView: RecordView = {
        let hitBattersView = RecordView()
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
        secondStackView.distribution = .fillProportionally
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
        
        inningView.widthAnchor.constraint(
            equalTo: secondStackView.widthAnchor,
            multiplier: 0.5).isActive = true
        ERView.widthAnchor.constraint(
            equalTo: inningView.widthAnchor,
            multiplier: 0.5).isActive = true
        strikeOutsView.widthAnchor.constraint(
            equalTo: inningView.widthAnchor,
            multiplier: 0.5).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .white
    }
}

extension PersonalPitcherView {
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
