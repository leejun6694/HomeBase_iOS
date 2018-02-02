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
    
//    static func hasTeamTo(_ currentUser: User) -> Bool {
//        let parameterDictionary = ["uid": currentUser.uid]
//        var result: Bool = false
//
//        Alamofire.request(
//            CloudFunction.methodURL(method: Method.getUser),
//            method: .get,
//            parameters: parameterDictionary).responseJSON {
//                (response) -> Void in
//
//                if response.result.isSuccess {
//                    if let value = response.result.value as? [String: Any] {
//                        if let hasTeam = value["hasTeam"] as? Bool {
//                            if hasTeam { result = true }
//                            else { result = false }
//                        }
//                    }
//                }
//        }
//
//        return result
//    }
//
//    static func hasPlayerInfoTo(_ currentUser: User) -> Bool {
//        let parameterDictionary = ["uid": currentUser.uid]
//        var result:Bool = false
//
//        Alamofire.request(
//            CloudFunction.methodURL(method: Method.getPlayer),
//            method: .get,
//            parameters: parameterDictionary).responseJSON {
//                (response) -> Void in
//
//                if response.result.isSuccess { result = true }
//                else { result = false }
//        }
//        
//        return result
//    }
}
