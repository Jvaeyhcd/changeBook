//
//  User.swift
//  govlan
//
//  Created by polesapp-hcd on 2017/4/6.
//  Copyright © 2017年 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

let AUTH_NOT = 0
let AUTH_ING = 1
let AUTH_SUCCESS = 2
let AUTH_FAIL = 3

struct User {
    var userId: String = ""
    var userName: String = ""
    var headPic: String = ""
    var sex: String = ""
    var nickName: String = ""
    var lcc : String = ""
    var introduce : String = ""
    var money: String = ""
    var lv : String = ""
    var integral : String = ""
    var schoolName: String = ""
    var address: String = ""
    
    var isCertification: Int
    var viewBorrow: Int
    var viewComment: Int
    var isDeposit: Int
    var depositMoney: String = ""
    var bookCount: Int
    var openId: String = ""
    
    init() {
        userId = ""
        userName = ""
        headPic = ""
        sex = ""
        nickName = ""
        lcc = ""
        introduce = ""
        money = ""
        lv = ""
        integral = "0"
        isCertification = 0
        viewBorrow = 0
        viewComment = 0
        isDeposit = INT_FALSE
        depositMoney = ""
        bookCount = 0
        openId = ""
    }
    
    init(json: JSON) {
        userId = json["userId"].stringValue
        userName = json["userName"].stringValue
        headPic = json["headPic"].stringValue
        sex = json["sex"].stringValue
        nickName = json["nickName"].stringValue
        lcc = json["lcc"].stringValue
        introduce = json["introduce"].stringValue
        money = json["money"].stringValue
        lv = json["lv"].stringValue
        integral = json["integral"].stringValue
        address = json["address"].stringValue
        schoolName = json["schoolName"].stringValue
        isCertification = json["isCertification"].intValue
        viewBorrow = json["viewBorrow"].intValue
        viewComment = json["viewComment"].intValue
        isDeposit = json["isDeposit"].intValue
        depositMoney = json["depositMoney"].stringValue
        bookCount = json["bookCount"].intValue
        openId = json["openId"].stringValue
    }
    
    static func setClientId(clientId: String) {
        kUserDefaults.set(clientId, forKey: "clientId")
        kUserDefaults.synchronize()
    }
    
    static func getClientId() -> String {
        if let cllient = kUserDefaults.string(forKey: "clientId") {
            return cllient
        }
        return ""
    }
}

extension User: Decodable {
    
    static func fromJSON(json: Any) -> User {
        
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        
        let user = User.init(json: data)
        
        return user
    }
    
    static func getSavedUser() -> User {
        
        var user = User()
        
        if let userId = kUserDefaults.string(forKey: "userId") {
            user.userId = userId
        }
        
        if let userName = kUserDefaults.string(forKey: "userName") {
            user.userName = userName
        }
        
        if let lcc = kUserDefaults.string(forKey: "lcc") {
            user.lcc = lcc
        }
        
        if let headPic = kUserDefaults.string(forKey: "headPic") {
            user.headPic = headPic
        }
        
        if let sex = kUserDefaults.string(forKey: "sex") {
            user.sex = sex
        }
        
        if let nickName = kUserDefaults.string(forKey: "nickName") {
            user.nickName = nickName
        }
        
        if let introduce = kUserDefaults.string(forKey: "introduce") {
            user.introduce = introduce
        }
        
        if let money = kUserDefaults.string(forKey: "money") {
            user.money = money
        }
        
        if let lv = kUserDefaults.string(forKey: "lv") {
            user.lv = lv
        }
        
        if let integral = kUserDefaults.string(forKey: "integral") {
            user.integral = integral
        }
        
        user.isCertification = kUserDefaults.integer(forKey: "isCertification")
        user.viewBorrow = kUserDefaults.integer(forKey: "viewBorrow")
        user.viewComment = kUserDefaults.integer(forKey: "viewComment")
        user.isDeposit = kUserDefaults.integer(forKey: "isDeposit")
        user.bookCount = kUserDefaults.integer(forKey: "bookCount")
        
        if let depositMoney = kUserDefaults.string(forKey: "depositMoney") {
            user.depositMoney = depositMoney
        }
        
        if let openId = kUserDefaults.string(forKey: "openId") {
            user.openId = openId
        }
        
        return user
    }
    
    static func clearUser(){
        
        Token.init().removeToken()
        
        kUserDefaults.removeObject(forKey: "userId")
        kUserDefaults.removeObject(forKey: "userName")
        kUserDefaults.removeObject(forKey: "headPic")
        kUserDefaults.removeObject(forKey: "sex")
        kUserDefaults.removeObject(forKey: "nickName")
        kUserDefaults.removeObject(forKey: "lcc")
        kUserDefaults.removeObject(forKey: "introduce")
        kUserDefaults.removeObject(forKey: "money")
        kUserDefaults.removeObject(forKey: "lat")
        kUserDefaults.removeObject(forKey: "lng")
        
        kUserDefaults.removeObject(forKey: "lv")
        kUserDefaults.removeObject(forKey: "isCertification")
        kUserDefaults.removeObject(forKey: "inviteNum")
        kUserDefaults.removeObject(forKey: "integral")
        kUserDefaults.removeObject(forKey: "viewComment")
        kUserDefaults.removeObject(forKey: "viewBorrow")
        
        kUserDefaults.removeObject(forKey: "isDeposit")
        kUserDefaults.removeObject(forKey: "depositMoney")
        kUserDefaults.removeObject(forKey: "bookCount")
        kUserDefaults.removeObject(forKey: "openId")
        
        kUserDefaults.synchronize()
    }
    
    static func saveLoginUser(user: User) {
        
        kUserDefaults.set(user.userId, forKey: "userId")
        kUserDefaults.set(user.userName, forKey: "userName")
        kUserDefaults.set(user.headPic, forKey: "headPic")
        kUserDefaults.set(user.sex, forKey: "sex")
        kUserDefaults.set(user.nickName, forKey: "nickName")
        kUserDefaults.set(user.lcc, forKey: "lcc")
        kUserDefaults.set(user.introduce, forKey: "introduce")
        kUserDefaults.set(user.money, forKey: "money")
        kUserDefaults.set(user.lv, forKey: "lv")
        kUserDefaults.set(user.integral, forKey: "integral")
        kUserDefaults.set(user.isCertification, forKey: "isCertification")
        kUserDefaults.set(user.viewComment, forKey: "viewComment")
        kUserDefaults.set(user.viewBorrow, forKey: "viewBorrow")
        
        kUserDefaults.set(user.isDeposit, forKey: "isDeposit")
        kUserDefaults.set(user.depositMoney, forKey: "depositMoney")
        kUserDefaults.set(user.bookCount, forKey: "bookCount")
        kUserDefaults.set(user.openId, forKey: "openId")
        
        kUserDefaults.synchronize()
    }
    
    mutating func setSex(sex: String) -> Void {
        self.sex = sex
    }
    
    mutating func setNickName(nickName: String) -> Void {
        self.nickName = nickName
    }
    
    mutating func setUserName(userName: String) -> Void {
        self.userName = userName
    }
    
    mutating func setLcc(lcc: String) -> Void {
        self.lcc = lcc
    }
    
    mutating func setHeadPic(headPic: String) -> Void {
        self.headPic = headPic
    }
    
    mutating func setIntroduce(introduce: String) -> Void {
        self.introduce = introduce
    }
    
    mutating func setMoney(money: String) -> Void {
        self.money = money
    }
    
}

struct Token {
    var token: String? {
        get {
            return kUserDefaults.string(forKey: UserDefaultsKeys.Token.rawValue)
        }
        set {
            kUserDefaults.set(newValue, forKey: UserDefaultsKeys.Token.rawValue)
            kUserDefaults.synchronize()
        }
    }
    
    var tokenExists: Bool {
        if let _ = token {
            return true
        } else {
            return false
        }
    }
    
    private enum UserDefaultsKeys: String {
        case Token = "TokenKey"
    }
    
    func removeToken(){
        kUserDefaults.removeObject(forKey: UserDefaultsKeys.Token.rawValue)
    }
    
}
