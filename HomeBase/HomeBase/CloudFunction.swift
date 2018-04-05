//
//  CloudFunction.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 25..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Alamofire

enum Method:String {
    case findEmail = "findEmail"
    case findPassword = "checkEmailByName"
    case getUser = "getUser"
    case getPlayer = "getPlayer"
    case getTeam = "getTeam"
    case getSchedule = "getSchedule"
}

struct CloudFunction {
    private static let baseURLString = "https://us-central1-base-45cd7.cloudfunctions.net/"
    
    static func methodURL(method: Method) -> URL {
        let url = URL(string: baseURLString + method.rawValue)!
        
        return url
    }
    
    static func getUserDataWith(
        _ currentUser: User,
        completion: @escaping(_ user: HBUser?, _ error: Error?) ->()) {
        
        let parameterDictionary = ["uid": currentUser.uid]
        
        Alamofire.request(
            CloudFunction.methodURL(method: Method.getUser),
            method: .get,
            parameters: parameterDictionary).responseJSON{
                (response) -> Void in
                
                if response.result.isSuccess {
                    guard let value = response.result.value as? [String: Any]
                        else { return }
                    
                    if let email = value["email"] as? String,
                        let name = value["name"] as? String,
                        let birth = value["birth"] as? String,
                        let teamCode = value["teamCode"] as? String,
                        let provider = value["provider"] as? String {
                        
                        let user = HBUser(
                            email: email,
                            name: name,
                            birth: birth,
                            teamCode: teamCode,
                            provider: provider)
                        
                        completion(user, nil)
                    }
                } else {
                    let error = response.result.error
                    completion(nil, error)
                }
        }
    }
    
    static func getPlayerDataWith(
        _ currentUser: User,
        completion: @escaping(_ player: HBPlayer?, _ error: Error?) ->()) {
        
        let parameterDictionary = ["uid": currentUser.uid]
        
        Alamofire.request(
            CloudFunction.methodURL(method: Method.getPlayer),
            method: .get,
            parameters: parameterDictionary).responseJSON{
                (response) -> Void in
                
                if response.result.isSuccess {
                    guard let value = response.result.value as? [String: Any]
                        else { return }
                    
                    if let name = value["name"] as? String,
                        let position = value["position"] as? String,
                        let backNumber = value["backNumber"] as? Int,
                        let height = value["height"] as? Int,
                        let weight = value["weight"] as? Int,
                        let batPosition = value["batPosition"] as? String,
                        let pitchPosition = value["pitchPosition"] as? String {
                        
                        let player = HBPlayer(
                            name: name,
                            position: position,
                            backNumber: backNumber,
                            height: height,
                            weight: weight,
                            batPoition: batPosition,
                            pitchPosition: pitchPosition)
                        
                        completion(player, nil)
                    }
                } else {
                    let error = response.result.error
                    completion(nil, error)
                }
        }
    }
    
    static func getTeamDataWith(
        _ teamCode: String,
        completion: @escaping(_ team: HBTeam?, _ error: Error?) ->()) {
        
        let parameterDictionary = ["teamCode": teamCode]
        
        Alamofire.request(
            CloudFunction.methodURL(method: Method.getTeam),
            method: .get,
            parameters: parameterDictionary).responseJSON{
                (response) -> Void in
                
                if response.result.isSuccess {
                    guard let value = response.result.value as? [String: Any]
                        else { return }
                    
                    if let name = value["name"] as? String,
                        let logo = value["logo"] as? String,
                        let description = value["description"] as? String,
                        let admin = value["admin"] as? String,
                        let memberList = value["members"] as? [String: [String: Any]]  {
                        
                        var members = [String: HBPlayer]()
                        
                        for (uid, member) in memberList {
                            if let name = member["name"] as? String,
                                let position = member["position"] as? String,
                                let backNumber = member["backNumber"] as? Int,
                                let height = member["height"] as? Int,
                                let weight = member["weight"] as? Int,
                                let batPosition = member["batPosition"] as? String,
                                let pitchPosition = member["pitchPosition"] as? String {
                                
                                let player = HBPlayer(
                                    name: name,
                                    position: position,
                                    backNumber: backNumber,
                                    height: height,
                                    weight: weight,
                                    batPoition: batPosition,
                                    pitchPosition: pitchPosition)
                                
                                members[uid] = player
                            }
                        }
                        
                        // enhancement
                        // [String: HBPlayer] -> sorted -> [(key: String, value: HBPlayer)]
                        // double loop
                        let sortedMembers = members.sorted(by: {
                            $0.value.backNumber < $1.value.backNumber })
                        
                        members.removeAll()
                        for (key, value) in sortedMembers {
                            members[key] = value
                        }
                        
                        let team = HBTeam(
                            name: name,
                            logo: logo,
                            description: description,
                            admin: admin,
                            members: members)
                        
                        completion(team, nil)
                    }
                } else {
                    let error = response.result.error
                    completion(nil, error)
                }
        }
    }
    
    static func getTeamSchedulesDataWith(
        _ teamCode:String,
        completion: @escaping(_ schedules: [HBSchedule]?, _ error: Error?) ->()) {
        
        let parameterDictionary = ["teamCode": teamCode]
        
        Alamofire.request(
            CloudFunction.methodURL(method: Method.getSchedule),
            method: .get,
            parameters: parameterDictionary).responseJSON{
                (response) -> Void in
                
                if response.result.isSuccess {
                    guard let values = response.result.value as? [String: [String: Any]]
                        else { return }

                    var schedules = [HBSchedule]()
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "ko-KR")
                    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                    
                    for (key, value) in values {
                        if let opponentTeam = value["opponentTeam"] as? String,
                            let matchPlace = value["matchPlace"] as? String,
                            let matchDate = value["matchDate"] as? String,
                            let homeScore = value["homeScore"] as? Int,
                            let opponentScore = value["opponentScore"] as? Int {
                            
                            if let date = dateFormatter.date(from: matchDate) {
                                let schedule = HBSchedule(
                                    sid: key,
                                    opponentTeam: opponentTeam,
                                    matchDate: date,
                                    matchPlace: matchPlace,
                                    homeScore: homeScore,
                                    opponentScore: opponentScore)
                                
                                schedules.append(schedule)
                            }
                        }
                    }
                    schedules.sort(
                        by: { $0.matchDate.compare($1.matchDate) == .orderedDescending } )
                    
                    completion(schedules, nil)
                } else {
                    let schedules = [HBSchedule]()
                    completion(schedules, nil)
                }
        }
    }
    
    static func getSchedulesDataWith(
        _ sid: String, teamCode: String,
        completion: @escaping(_ schedules: HBSchedule?, _ error: String?) ->()) {
        
        let ref = Database.database().reference()
        let scheduleRef = ref.child("schedules").child(teamCode).child(sid)
        
        scheduleRef.observeSingleEvent(of: .value) {
            (snapshot, error) in
            
            if let error = error {
                completion(nil, error)
            } else {
                guard let value = snapshot.value as? NSDictionary else { return }
                
                if let opponentTeam = value["opponentTeam"] as? String,
                    let matchDate = value["matchDate"] as? String,
                    let matchPlace = value["matchPlace"] as? String,
                    let homeScore = value["homeScore"] as? Int,
                    let opponentScore = value["opponentScore"] as? Int {
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "ko-KR")
                    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                    
                    if let date = dateFormatter.date(from: matchDate) {
                        let schedule = HBSchedule(
                            sid: sid,
                            opponentTeam: opponentTeam,
                            matchDate: date,
                            matchPlace: matchPlace,
                            homeScore: homeScore,
                            opponentScore: opponentScore)
                        
                        completion(schedule, nil)
                    }
                }
            }
        }
    }
}
