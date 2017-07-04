//
//  Status.swift
//  govlan
//
//  Created by Jvaeyhcd on 07/04/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Status {
    var code: String = ""
    var message: String = ""
    
    init(json: JSON) {
        code = json["code"].stringValue
        message = json["message"].stringValue
    }
}

extension Status: Decodable {
    static func fromJSON(json: Any) -> Status {
        
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        
        let status = Status.init(json: data)
        
        return status
    }
}
