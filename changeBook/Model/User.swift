//
//  User.swift
//  govlan
//
//  Created by polesapp-hcd on 2017/4/6.
//  Copyright © 2017年 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

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
    var isAuthentication : String = ""
    var inviteNum : String = ""
    var inviteCode : String = ""
    var inviteReword : String = ""
    var integral : String = ""
    var needIntegral : String = ""
    var carPic: String = ""
    var couponNum : String = ""
    var schoolName: String = ""
    var address: String = ""
    
    //三方绑定状态
    var bindWeChat = "0"
    var bindQQ = "0"
    var bindWeiBo = "0"
    
    //三方绑定的openId
    var qqOpenId = ""
    var weChatOpenId = ""
    var weiBoOpenId = ""
    
    //企业相关
    var businessName : String = ""
    var balance : String = ""
    
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
        isAuthentication = ""
        inviteNum = ""
        integral = "0"
        needIntegral = "0"
        
        inviteCode = ""
        inviteReword = ""
        carPic = ""
        
        couponNum = "0"
        
        bindWeChat = "0"
        bindQQ = "0"
        bindWeiBo = "0"
        
        qqOpenId = ""
        weChatOpenId = ""
        weiBoOpenId = ""
        
        businessName = ""
        balance = ""
        
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
        isAuthentication = json["isAuthentication"].stringValue
        inviteNum = json["inviteNum"].stringValue
        integral = json["integral"].stringValue
        needIntegral = json["needIntegral"].stringValue
        address = json["address"].stringValue
        schoolName = json["schoolName"].stringValue
        
        inviteCode = json["inviteCode"].stringValue
        inviteReword = json["inviteReword"].stringValue
        carPic = json["carPic"].stringValue
        
        couponNum = json["couponNum"].stringValue
        
        bindWeChat = json["bindStatus"]["bindWeChat"].stringValue
        bindQQ = json["bindStatus"]["bindQQ"].stringValue
        bindWeiBo = json["bindStatus"]["bindWeiBo"].stringValue
        
        qqOpenId = json["bindStatus"]["qqOpenId"].stringValue
        weChatOpenId = json["bindStatus"]["weChatOpenId"].stringValue
        weiBoOpenId = json["bindStatus"]["weiBoOpenId"].stringValue
        
        businessName = json["businessAccount"]["businessName"].stringValue
        balance = json["businessAccount"]["balance"].stringValue
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
        
        if let isAuthentication = kUserDefaults.string(forKey: "isAuthentication") {
            user.isAuthentication = isAuthentication
        }
        
        if let inviteNum = kUserDefaults.string(forKey: "inviteNum") {
            user.inviteNum = inviteNum
        }
        
        if let integral = kUserDefaults.string(forKey: "integral") {
            user.integral = integral
        }
        
        if let needIntegral = kUserDefaults.string(forKey: "needIntegral") {
            user.needIntegral = needIntegral
        }
        
        if let inviteCode = kUserDefaults.string(forKey: "inviteCode") {
            user.inviteCode = inviteCode
        }
        
        if let inviteReword = kUserDefaults.string(forKey: "inviteReword") {
            user.inviteReword = inviteReword
        }
        
        if let couponNum = kUserDefaults.string(forKey: "couponNum"){
            user.couponNum = couponNum
        }
        
        if let bindWeChat = kUserDefaults.string(forKey: "bindWeChat"){
            user.bindWeChat = bindWeChat
        }
        
        if let bindQQ = kUserDefaults.string(forKey: "bindQQ"){
            user.bindQQ = bindQQ
        }
        
        if let bindWeiBo = kUserDefaults.string(forKey: "bindWeiBo"){
            user.bindWeiBo = bindWeiBo
        }
        
        if let qqOpenId = kUserDefaults.string(forKey: "qqOpenId"){
            user.qqOpenId = qqOpenId
        }
        
        if let weChatOpenId = kUserDefaults.string(forKey: "weChatOpenId"){
            user.weChatOpenId = weChatOpenId
        }
        
        if let weiBoOpenId = kUserDefaults.string(forKey: "weiBoOpenId"){
            user.weiBoOpenId = weiBoOpenId
        }
        
        if let businessName = kUserDefaults.string(forKey: "businessName"){
            user.businessName = businessName
        }
        
        if let balance = kUserDefaults.string(forKey: "balance"){
            user.balance = balance
        }
        
        if let carPic = kUserDefaults.string(forKey: "carPic"){
            user.carPic = carPic
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
        kUserDefaults.removeObject(forKey: "isAuthentication")
        kUserDefaults.removeObject(forKey: "inviteNum")
        kUserDefaults.removeObject(forKey: "integral")
        kUserDefaults.removeObject(forKey: "needIntegral")
        
        kUserDefaults.removeObject(forKey: "inviteCode")
        kUserDefaults.removeObject(forKey: "inviteReword")
        
        kUserDefaults.removeObject(forKey: "couponNum")
        
        kUserDefaults.removeObject(forKey: "carPic")
    
        
        kUserDefaults.removeObject(forKey: "bindWeChat")
        kUserDefaults.removeObject(forKey: "bindQQ")
        kUserDefaults.removeObject(forKey: "bindWeiBo")
        
        
        kUserDefaults.removeObject(forKey: "qqOpenId")
        kUserDefaults.removeObject(forKey: "weChatOpenId")
        kUserDefaults.removeObject(forKey: "weiBoOpenId")
        
        
        kUserDefaults.removeObject(forKey: "businessName")
        kUserDefaults.removeObject(forKey: "balance")
        
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
        kUserDefaults.set(user.isAuthentication, forKey: "isAuthentication")
        kUserDefaults.set(user.inviteNum, forKey: "inviteNum")
        kUserDefaults.set(user.integral, forKey: "integral")
        kUserDefaults.set(user.needIntegral, forKey: "needIntegral")
        
        kUserDefaults.set(user.inviteCode, forKey: "inviteCode")
        kUserDefaults.set(user.inviteReword, forKey: "inviteReword")
        
        kUserDefaults.set(user.couponNum, forKey: "couponNum")
        
        kUserDefaults.set(user.carPic, forKey: "carPic")
    
        
        kUserDefaults.set(user.bindWeChat, forKey: "bindWeChat")
        kUserDefaults.set(user.bindQQ, forKey: "bindQQ")
        kUserDefaults.set(user.bindWeiBo, forKey: "bindWeiBo")
    
        
        kUserDefaults.set(user.qqOpenId, forKey: "qqOpenId")
        kUserDefaults.set(user.weChatOpenId, forKey: "weChatOpenId")
        kUserDefaults.set(user.weiBoOpenId, forKey: "weiBoOpenId")
        
        
        kUserDefaults.set(user.businessName, forKey: "businessName")
        kUserDefaults.set(user.balance, forKey: "balance")
        
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
