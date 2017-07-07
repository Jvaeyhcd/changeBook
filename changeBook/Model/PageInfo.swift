//
//  PageInfo.swift
//  govlan
//
//  Created by Jvaeyhcd on 07/04/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PageInfo {
    var prePage: Int = 0
    var maxPage: Int = 0
    var currentPage: Int = 0
    var nextPage:Int = 0
    var allNum:Int = 0
    
    init(json: JSON) {
        prePage = json["prePage"].intValue
        maxPage = json["maxPage"].intValue
        currentPage = json["currentPage"].intValue
        nextPage = json["nextPage"].intValue
        allNum = json["allNum"].intValue
    }
    
    init() {
        prePage = 0
        maxPage = 0
        currentPage = 0
        nextPage = 0
        allNum = 0
    }
}

extension PageInfo: Decodable {
    static func fromJSON(json: Any) -> PageInfo {
        
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        
        let pageInfo = PageInfo.init(json: data)
        
        return pageInfo
    }
}
