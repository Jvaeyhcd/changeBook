//
//  Global.swift
//  changeBook
//
//  Created by Jvaeyhcd on 04/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import RealmSwift

let sharedGlobal = Global.sharedGlobal

class Global {
    static let sharedGlobal = Global()
    private var user = User()
    private var realm: Realm?
    private var token = Token()
    
    func getRealm() -> Realm {
        //if nil == self.realm {
        self.realm = try! Realm()
        //}
        return self.realm!
    }
    
    func saveUser(user: User) {
        self.user = user
        User.saveLoginUser(user: user)
    }
    
    func getToken() -> Token {
        return self.token
    }
    
    func saveToken(token: String) {
        self.token.token = token
    }
    
    // 获取全局的User
    func getSavedUser() -> User {
        if self.user.userId == "" {
            self.user = User.getSavedUser()
        }
        return self.user
    }
    
    // 清除个人相关信息
    func clearUser() {
        self.user = User()
        User.clearUser()
    }
}
