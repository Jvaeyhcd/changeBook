//
//  Address.swift
//  changeBook
//
//  Created by Jvaeyhcd on 13/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Address {
    var addressId: String
    var userName: String
    var phone: String
    var addressDetail: String
    var isDefault: Bool
    
    init() {
        self.addressId = ""
        self.addressDetail = ""
        self.userName = ""
        self.phone = ""
        self.isDefault = false
    }
    
    init(json: JSON) {
        self.addressId = json["id"].stringValue
        self.userName = json["userName"].stringValue
        self.phone = json["phone"].stringValue
        self.addressDetail = json["detail"].stringValue
        self.isDefault = json["isDefault"].boolValue
    }
}

extension Address: Decodable {
    static func fromJSON(json: Any) -> Address {
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        let address = Address.init(json: data)
        return address
    }
}
