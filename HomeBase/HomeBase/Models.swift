//
//  Models.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 31..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import Foundation
import UIKit

class HBUser {
    var email: String
    var name: String
    var birth: String
    var teamCode: String
    var provider: String
    
    init(email: String,
         name: String,
         birth: String,
         teamCode: String,
         provider: String) {
        
        self.email = email
        self.name = name
        self.birth = birth
        self.teamCode = teamCode
        self.provider = provider
    }
}

class HBPlayer {
    var name: String
    var position: String
    var backNumber: Int
    var height: Int
    var weight: Int
    var batPosition: String
    var pitchPosition: String
    
    init(name: String,
         position: String,
         backNumber: Int,
         height: Int,
         weight: Int,
         batPoition: String,
         pitchPosition: String) {
        
        self.name = name
        self.position = position
        self.backNumber = backNumber
        self.height = height
        self.weight = weight
        self.batPosition = batPoition
        self.pitchPosition = pitchPosition
    }
}

class HBTeam {
    var name: String
    var logo: String
    var description: String
    var admin: String
    var members: [String: HBPlayer]
    
    init(name: String,
         logo: String,
         description: String,
         admin: String,
         members: [String: HBPlayer]) {
        
        self.name = name
        self.logo = logo
        self.description = description
        self.admin = admin
        self.members = members
    }
}

class HBSchedule {
    var sid: String
    var opponentTeam: String
    var matchDate: Date
    var matchPlace: String
    var homeScore: Int
    var opponentScore: Int
    var record: [String: HBRecord]
    
    init(sid: String,
         opponentTeam: String,
         matchDate: Date,
         matchPlace: String,
         homeScore: Int,
         opponentScore: Int,
         record: [String: HBRecord]?) {
        
        self.sid = sid
        self.opponentTeam = opponentTeam
        self.matchDate = matchDate
        self.matchPlace = matchPlace
        self.homeScore = homeScore
        self.opponentScore = opponentScore
        self.record = record ?? ["none": HBRecord()]
    }
}

class HBBatterRecord {
    var singleHit: Int
    var doubleHit: Int
    var tripleHit: Int
    var homeRun: Int
    var baseOnBalls: Int    // 볼넷
    var hitByPitch: Int     // 사구
    var sacrificeHit: Int   // 희생타
    var stolenBase: Int     // 도루
    var strikeOut: Int      // 삼진
    var groundBall: Int     // 땅볼
    var flyBall: Int        // 뜬공
    var run: Int            // 득점
    var RBI: Int            // 타점
    
    init(singleHit: Int = 0,
         doubleHit: Int = 0,
         tripleHit: Int = 0,
         homeRun: Int = 0,
         baseOnBalls: Int = 0,
         hitByPitch: Int = 0,
         sacrificeHit: Int = 0,
         stolenBase: Int = 0,
         strikeOut: Int = 0,
         groundBall: Int = 0,
         flyBall: Int = 0,
         run: Int = 0,
         RBI: Int = 0) {
        
        self.singleHit = singleHit
        self.doubleHit = doubleHit
        self.tripleHit = tripleHit
        self.homeRun = homeRun
        self.baseOnBalls = baseOnBalls
        self.hitByPitch = hitByPitch
        self.sacrificeHit = sacrificeHit
        self.stolenBase = stolenBase
        self.strikeOut = strikeOut
        self.groundBall = groundBall
        self.flyBall = flyBall
        self.run = run
        self.RBI = RBI
    }
}

class HBPitcherRecord {
    var win: Int
    var lose: Int
    var save: Int
    var hold: Int
    var inning: Double      // 이닝
    var strikeOuts: Int     // 탈삼진
    var ER: Int             // 자책점
    var hits: Int           // 피안타
    var homeRuns: Int       // 피홈런
    var walks: Int          // 볼넷
    var hitBatters: Int     // 사구
    
    init(win: Int = 0,
         lose: Int = 0,
         save: Int = 0,
         hold: Int = 0,
         inning: Double = 0.0,
         strikeOuts: Int = 0,
         ER: Int = 0,
         hits: Int = 0,
         homeRuns: Int = 0,
         walks: Int = 0,
         hitBatters: Int = 0) {
        
        self.win = win
        self.lose = lose
        self.hold = hold
        self.save = save
        self.inning = inning
        self.strikeOuts = strikeOuts
        self.ER = ER
        self.hits = hits
        self.homeRuns = homeRuns
        self.walks = walks
        self.hitBatters = hitBatters
    }
}

class HBRecord {
    var batterRecord: HBBatterRecord
    var pitcherRecord: HBPitcherRecord
    
    init() {
        self.batterRecord = HBBatterRecord()
        self.pitcherRecord = HBPitcherRecord()
    }
    
    init(batterRecord: HBBatterRecord, pitcherRecord: HBPitcherRecord) {
        self.batterRecord = batterRecord
        self.pitcherRecord = pitcherRecord
    }
}
