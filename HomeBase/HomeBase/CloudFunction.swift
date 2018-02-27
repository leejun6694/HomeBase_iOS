//
//  CloudFunction.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 25..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import Foundation
import FirebaseAuth
import Alamofire

enum Method:String {
    case findEmail = "findEmail"
    case findPassword = "checkEmailByName"
    case getUser = "getUser"
    case getPlayer = "getPlayer"
    case getTeam = "getTeam"
}

struct CloudFunction {
    private static let baseURLString = "https://us-central1-base-45cd7.cloudfunctions.net/"
    
    static func methodURL(method: Method) -> URL {
        let url = URL(string: baseURLString + method.rawValue)!
        
        return url
    }
    
    static func getUserDataWith(_ currentUser:User, completion: @escaping(_ user:HBUser?, _ error: Error?) ->()) {
        let parameterDictionary = ["uid": currentUser.uid]
        
        Alamofire.request(
            CloudFunction.methodURL(method: Method.getUser),
            method: .get,
            parameters: parameterDictionary).responseJSON{
                (response) -> Void in
                
                if response.result.isSuccess {
                    if let value = response.result.value as? [String:Any] {
                        if let email = value["email"] as? String,
                            let name = value["name"] as? String,
                            let birth = value["birth"] as? String,
                            let teamCode = value["teamCode"] as? String,
                            let provider = value["provider"] as? String {
                            
                            let user = HBUser(email: email, name: name, birth: birth, teamCode: teamCode, provider: provider)
                            completion(user, nil)
                        }
                    }
                } else {
                    let error = response.result.error
                    completion(nil, error)
                }
        }
    }
    
    static func getPlayerDataWith(_ currentUser:User, completion: @escaping(_ player:HBPlayer?, _ error: Error?) ->()) {
        let parameterDictionary = ["uid": currentUser.uid]
        
        Alamofire.request(
            CloudFunction.methodURL(method: Method.getPlayer),
            method: .get,
            parameters: parameterDictionary).responseJSON{
                (response) -> Void in
                
                if response.result.isSuccess {
                    if let value = response.result.value as? [String:Any] {
                        if let name = value["name"] as? String,
                            let position = value["position"] as? String,
                            let backNumber = value["backNumber"] as? Int,
                            let height = value["height"] as? Int,
                            let weight = value["weight"] as? Int,
                            let batPosition = value["batPosition"] as? String,
                            let pitchPosition = value["pitchPosition"] as? String {
                            
                            let player = HBPlayer(name: name,
                                                position: position,
                                                backNumber: backNumber,
                                                height: height,
                                                weight: weight,
                                                batPoition: batPosition,
                                                pitchPosition: pitchPosition)
                            
                            completion(player, nil)
                        }
                    }
                } else {
                    let error = response.result.error
                    completion(nil, error)
                }
        }
    }
    
    static func getTeamDataWith(_ teamCode:String, completion: @escaping(_ team:HBTeam?, _ error: Error?) ->()) {
        let parameterDictionary = ["teamCode": teamCode]
        
        Alamofire.request(
            CloudFunction.methodURL(method: Method.getTeam),
            method: .get,
            parameters: parameterDictionary).responseJSON{
                (response) -> Void in
                
                if response.result.isSuccess {
                    if let value = response.result.value as? [String:Any] {
                        if let name = value["name"] as? String,
                            let logo = value["logo"] as? String,
                            let description = value["description"] as? String,
                            let admin = value["admin"] as? String,
                            let memberList = value["members"] as? [String: String]  {
                            
                            var members = [String]()
                            for (_, member) in memberList {
                                members.append(member)
                            }
                            
                            let team = HBTeam(name: name,
                                              logo: logo,
                                              description: description,
                                              admin: admin,
                                              members: members)
                            completion(team, nil)
                        }
                    }
                } else {
                    let error = response.result.error
                    completion(nil, error)
                }
        }
    }
}
