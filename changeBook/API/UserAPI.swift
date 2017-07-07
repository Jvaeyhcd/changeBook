//
//  UserAPI.swift
//  changeBook
//
//  Created by Jvaeyhcd on 04/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import Moya

let userRequestClosure = { (endpoint: Endpoint<UserAPI>, done: @escaping MoyaProvider<UserAPI>.RequestResultClosure) in
    
    guard var request = endpoint.urlRequest else { return }
    
    request.timeoutInterval = TimeInterval(TIMEOUTTIME)    //设置请求超时时间
    done(.success(request))
}

let UserAPIProvider = RxMoyaProvider<UserAPI>(requestClosure:userRequestClosure)

public enum UserAPI {

    //注销登录
    case logout()
    //注册
    case register(userName:String,password:String,identifyCode:String, inviteCode:String)
    //注册获取验证码
    case registerGetCode(userName:String)
    //登录
    case login(userName:String,password:String)
    //获取个人信息
    case getUserInfo()
    //修改个人信息
    case changeUserInfo(headPic:String,nickName:String,sex:String,introduce:String)
    //忘记密码获取验证码
    case forgetPasswordGetCode(userName:String)
    //忘记密码修改密码
    case changePassword(userName:String,newPassword:String,identifyCode:String)
    //获取积分记录
    case getUserIntegralLog()
}

extension UserAPI: TargetType {
    public var baseURL: URL {
        return URL(string: kBaseUrl)!
    }
    
    public var path: String {
        switch self {
        case .logout():
            return "/user/logout"
        case .register(userName: _, password: _, identifyCode: _, inviteCode: _):
            return "/user/register/register"
        case .registerGetCode(userName: _):
            return "/user/register/getCode"
        case .login(userName: _, password: _):
            return "/user/login"
        case .getUserInfo():
            return "/user/getUserInfo"
        case .changeUserInfo(headPic: _, nickName: _, sex: _, introduce: _):
            return "/user/editUserInfo"
        case .forgetPasswordGetCode(userName: _):
            return "/user/updatePassword/getCode"
        case .changePassword(userName: _, newPassword: _, identifyCode: _):
            return "/user/updatePassword/updatePassword"
        case .getUserIntegralLog():
            return "/user/getUserIntegral"
        }
    }
    
    public var method: Moya.Method {
        return Moya.Method.post
    }
    
    public var parameters: [String : Any]? {
        var userId = "0"
        var token = ""
        if Token().tokenExists {
            token = Token().token!
            userId = sharedGlobal.getSavedUser().userId
        }
        switch self {
        case .logout():
            return ["token":token,"userId":userId]
        case .register(let userName, let password, let identifyCode, let inviteCode):
            kUserDefaults.setValue(userName, forKey: "userName")
            kUserDefaults.setValue(password, forKey: "password")
            kUserDefaults.synchronize()
            return [
                "userName":userName,
                "password":password,
                "code":identifyCode,
                "inviteCode":inviteCode
            ]
        case .registerGetCode(let userName):
            return [
                "userName":userName
            ]
        case .login(let userName, let password):
            kUserDefaults.setValue(userName, forKey: "userName")
            kUserDefaults.setValue(password, forKey: "password")
            kUserDefaults.synchronize()
            return [
                "userName":userName,
                "password":password,
                "cid": User.getClientId()
            ]
        case .getUserInfo():
            return ["token":token,"userId":userId]
        case .changeUserInfo(let headPic, let nickName, let sex, let introduce):
            return [
                "token":token,
                "userId":userId,
                "headPic":headPic,
                "nickName":nickName,
                "sex":sex,
                "introduce":introduce
            ]
        case .forgetPasswordGetCode(let userName):
            return [
                "userName":userName,
                "action":"getCodeForgetPassword"
            ]
        case .changePassword(let userName, let newPassword, let identifyCode):
            return [
                "userName": userName,
                "password": newPassword,
                "code": identifyCode
            ]
        case .getUserIntegralLog():
            return [
                "token":token,
                "userId":userId
            ]
            
        }
    }
    
    public var task: Task {
        return .request
    }
    public var validate: Bool {
        return false
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var sampleData: Data {
        return "no thing".data(using: .utf8)!
    }
}
