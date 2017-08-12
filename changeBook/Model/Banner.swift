//
//  Banner.swift
//  changeBook
//
//  Created by Jvaeyhcd on 30/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

let kBannerTypeHtml = 0
let kBannerTypeUrl = 1

struct Banner {
    var id: String
    var title: String
    var content: String
    var cover: String
    var bannerType: Int
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.title = json["title"].stringValue
        self.content = json["content"].stringValue
        self.cover = json["cover"].stringValue
        self.bannerType = json["bannerType"].intValue
    }
}

extension Banner: Decodable {
    static func fromJSON(json: Any) -> Banner {
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        let banner = Banner.init(json: data)
        return banner
    }
}
