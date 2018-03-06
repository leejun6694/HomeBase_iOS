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
    
    init(email: String, name: String, birth: String, teamCode: String, provider: String) {
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
    
    init(name: String, position: String, backNumber: Int, height: Int, weight: Int, batPoition: String, pitchPosition: String) {
        
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
    var members: [String]
    
    init(name: String, logo: String, description: String, admin: String, members: [String]) {
        self.name = name
        self.logo = logo
        self.description = description
        self.admin = admin
        self.members = members
    }
}

class HBSchedule {
    var opponentTeam: String
    var matchDate: Date
    var matchPlace: String
    
    init(opponentTeam: String, matchDate: Date, matchPlace: String) {
        self.opponentTeam = opponentTeam
        self.matchDate = matchDate
        self.matchPlace = matchPlace
    }
}
