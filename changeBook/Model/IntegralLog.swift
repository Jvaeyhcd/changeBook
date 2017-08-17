//
//  IntegralLog.swift
//  changeBook
//
//  Created by Jvaeyhcd on 07/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

struct IntegralLog {
    var userId: String = ""
    var integralType: String = ""
    var integral: String = ""
    var createAt: String = ""
    var integralStr: String = ""
    
    init(json: JSON) {
        userId = json["userId"].stringValue
        integralType = json["integralType"].stringValue
        integral = json["integral"].stringValue
        createAt = json["createAt"].stringValue
        integralStr = json["integralStr"].stringValue
    }
}

extension IntegralLog: Decodable {
    static func fromJSON(json: Any) -> IntegralLog {
        
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        
        let log = IntegralLog.init(json: data)
        
        return log
    }
}

