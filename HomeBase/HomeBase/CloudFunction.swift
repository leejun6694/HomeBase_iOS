//
//  CloudFunction.swift
//  HomeBase
//
//  Created by JUN LEE on 2018. 1. 25..
//  Copyright © 2018년 JUN LEE. All rights reserved.
//

import Foundation

enum Method:String {
    case findEmail = "findEmail"
    case findPassword = "checkEmailByName"
}

struct CloudFunction {
    private static let baseURLString = "https://us-central1-base-45cd7.cloudfunctions.net/"
    
    static func methodURL(method: Method) -> URL {
        let url = URL(string: baseURLString + method.rawValue)!
        
        return url
    }
}
