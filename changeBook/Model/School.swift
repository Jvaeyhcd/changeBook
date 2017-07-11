//
//  School.swift
//  changeBook
//
//  Created by Jvaeyhcd on 11/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

struct School {
    var id: String = ""
    var schoolName: String = ""
    var lat: String = ""
    var lng: String = ""
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.schoolName = json["schoolName"].stringValue
        self.lat = json["lat"].stringValue
        self.lng = json["lng"].stringValue
    }
}

extension School: Decodable {
    static func fromJSON(json: Any) -> School {
        
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        
        let school = School.init(json: data)
        
        return school
    }
}
