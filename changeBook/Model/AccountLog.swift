//
//  AccountLog.swift
//  changeBook
//
//  Created by Jvaeyhcd on 09/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

struct AccountLog {
    var id: String
    var money: String
    var content: String
    var status: String
    var createAt: String
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.money = json["money"].stringValue
        self.content = json["content"].stringValue
        self.status = json["status"].stringValue
        self.createAt = json["createAt"].stringValue
    }
}

extension AccountLog: Decodable {
    static func fromJSON(json: Any) -> AccountLog {
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        let accountLog = AccountLog.init(json: data)
        return accountLog
    }
}
