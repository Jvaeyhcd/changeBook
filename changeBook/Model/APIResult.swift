//
//  APIResult.swift
//  govlan
//
//  Created by Jvaeyhcd on 07/04/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import RealmSwift

// 保存网络请求返回的数据的Model
class APIResult: Object {
    
    dynamic var name = ""
    //
    dynamic var json = ""
    
    //主键
    override static func primaryKey() -> String{
        return "name"
    }
}
