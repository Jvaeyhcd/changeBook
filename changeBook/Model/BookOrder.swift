//
//  BookOrder.swift
//  changeBook
//
//  Created by Jvaeyhcd on 22/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

let kPayWayWechat = "1"
let kPayWayAli = "2"

let kDeliveryModePeiSong = 0
let kDeliveryModeZhiQu = 1

let kOrderStatusDaiFaHuo = 1
let kOrderStatusDaiShouHuo = 2
let kOrderStatusJieYueZhong = 3
let kOrderStatusDone = 4

struct BookOrder {
    var id: String
    var orderSn: String
    var freight: String
    var payWay: String
    var userName: String
    var phone: String
    var address: String
    var createAt: String
    var deliveryDate: String
    var orderStatus: Int
    var isComment: Bool
    var isOverdue: Bool
    var overdueFee: String
    var bookCount: String
    var orderDetail: [Book]
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.orderSn = json["orderSn"].stringValue
        self.freight = json["freight"].stringValue
        self.payWay = json["payWay"].stringValue
        self.userName = json["userName"].stringValue
        self.phone = json["phone"].stringValue
        self.address = json["address"].stringValue
        self.createAt = json["createAt"].stringValue
        self.deliveryDate = json["deliveryDate"].stringValue
        self.orderStatus = json["orderStatus"].intValue
        self.isComment = json["isComment"].boolValue
        self.isOverdue = json["isOverdue"].boolValue
        self.overdueFee = json["overdueFee"].stringValue
        self.bookCount = json["bookCount"].stringValue
        self.orderDetail = Book.fromJSONArray(json: json["orderDetail"].arrayObject!)
    }
}

extension BookOrder: Decodable {
    static func fromJSON(json: Any) -> BookOrder {
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        let bookOrder = BookOrder.init(json: data)
        return bookOrder
    }
}
