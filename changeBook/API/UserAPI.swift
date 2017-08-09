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
    case getUserInfo(userId: String)
    //修改个人信息
    case changeUserInfo(headPic:String,nickName:String,sex:String,introduce:String)
    //忘记密码获取验证码
    case forgetPasswordGetCode(userName:String)
    //忘记密码修改密码
    case changePassword(userName:String,newPassword:String,identifyCode:String)
    //获取积分记录
    case getUserIntegralLog()
    //获取学校列表
    case getSchoolList()
    //绑定学校
    case bindSchool(schoolId: String)
    //设置默认收货地址
    case setDefaultAddress(addressId: String)
    //获取用户收货地址
    case getUserAddressList()
    //添加收货地址
    case addAddress(userName: String, phone: String, addressDetail: String, isDefault: Int)
    //编辑收货地址
    case editAddress(addressId: String, userName: String, phone: String, addressDetail: String)
    //删除收货地址
    case deleteAddress(addressId: String)
    //用户的借阅
    case userBorrowBook(userId: String, page: Int)
    //用户的评论
    case getUserComment(userId: String, page: Int)
    //隐私设置
    case privacySettings(viewComment: Int, viewBorrow: Int)
    //拉黑用户
    case userBlackHouse(beUserId: String)
    //举报用户
    case userReport(beUserId: String)
    //申请学生认证
    case addUserCertification(userName: String, studentNo: String, pic: String)
    //qq登录
    case qqLogin(openId: String, nickName: String, headPic: String)
    //绑定手机号获取验证码
    case getCode(userName: String)
    //绑定手机号
    case bindPhone(userName: String, code: String)
    //押金明细
    case userAccountLog()
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
        case .getUserInfo(userId: _):
            return "/user/getUserInfo"
        case .changeUserInfo(headPic: _, nickName: _, sex: _, introduce: _):
            return "/user/editUserInfo"
        case .forgetPasswordGetCode(userName: _):
            return "/user/updatePassword/getCode"
        case .changePassword(userName: _, newPassword: _, identifyCode: _):
            return "/user/updatePassword/updatePassword"
        case .getUserIntegralLog():
            return "/user/getUserIntegral"
        case .getSchoolList():
            return "/user/getSchoolList"
        case .bindSchool(schoolId: _):
            return "/user/bindSchool"
        case .setDefaultAddress(addressId: _):
            return "/user/setDefaultAddress"
        case .getUserAddressList():
            return "/user/userAddress"
        case .addAddress(userName: _, phone: _, addressDetail: _, isDefault: _):
            return "/user/addAddress"
        case .editAddress(addressId: _, userName: _, phone: _, addressDetail: _):
            return "/user/editAddress"
        case .deleteAddress(addressId: _):
            return "/user/deleteAddress"
        case .userBorrowBook(userId: _, page: _):
            return "/user/userBorrowBook"
        case .getUserComment(userId: _, page: _):
            return "/user/getUserComment"
        case .privacySettings(viewComment: _, viewBorrow: _):
            return "/user/privacySettings"
        case .userBlackHouse(beUserId: _):
            return "/user/userBlackHouse"
        case .userReport(beUserId: _):
            return "/user/userReport"
        case .addUserCertification(userName: _, studentNo: _, pic: _):
            return "/user/addUserCertification"
        case .qqLogin(openId: _, nickName: _, headPic: _):
            return "/user/qqLogin"
        case .getCode(userName: _):
            return "/user/bindPhone/getCode"
        case .bindPhone(userName: _, code: _):
            return "/user/bindPhone/bindPhone"
        case .userAccountLog():
            return "/user/userAccountLog"
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
        case .getUserInfo(let usersId):
            
            if usersId == "" {
                return [
                    "token": token,
                    "userId": userId
                ]
            } else {
                return [
                    "token": token,
                    "userId": usersId
                ]
            }
            
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
        case .getSchoolList():
            return [
                "token":token,
                "userId":userId
            ]
        case .bindSchool(let schoolId):
            return [
                "token": token,
                "userId": userId,
                "schoolId": schoolId
            ]
        case .getUserAddressList():
            return [
                "token":token,
                "userId":userId
            ]
        case .setDefaultAddress(let addressId):
            return [
                "token": token,
                "userId": userId,
                "addressId": addressId
            ]
        case .addAddress(let userName, let phone, let addressDetail, let isDefault):
            return [
                "token": token,
                "userId": userId,
                "userName": userName,
                "phone": phone,
                "addressDetail": addressDetail,
                "isDefault": isDefault
            ]
        case .editAddress(let addressId, let userName, let phone, let addressDetail):
            return [
                "token": token,
                "userId": userId,
                "addressId": addressId,
                "userName": userName,
                "phone": phone,
                "addressDetail": addressDetail
            ]
        case .deleteAddress(let addressId):
            return [
                "token": token,
                "userId": userId,
                "addressId": addressId
            ]
        case .userBorrowBook(let usersId, let page):
            if usersId == userId {
                return [
                    "token": token,
                    "userId": userId,
                    "page": page
                ]
            } else {
                return [
                    "userId": usersId,
                    "page": page
                ]
            }
        case .getUserComment(let usersId, let page):
            if usersId == userId {
                return [
                    "token": token,
                    "userId": userId,
                    "page": page
                ]
            } else {
                return [
                    "userId": usersId,
                    "page": page
                ]
            }
        case .privacySettings(let viewComment, let viewBorrow):
            return [
                "token": token,
                "userId": userId,
                "viewComment": viewComment,
                "viewBorrow": viewBorrow
            ]
        case .userBlackHouse(let beUserId):
            return [
                "token": token,
                "userId": userId,
                "beUserId": beUserId
            ]
        case .userReport(let beUserId):
            return [
                "token": token,
                "userId": userId,
                "beUserId": beUserId
            ]
        case .addUserCertification(let userName, let studentNo, let pic):
            return [
                "token": token,
                "userId": userId,
                "userName": userName,
                "studentNo": studentNo,
                "pic": pic
            ]
        case .qqLogin(let openId, let nickName, let headPic):
            return [
                "openId": openId,
                "nickName": nickName,
                "headPic": headPic
            ]
        case .getCode(let userName):
            return [
                "token": token,
                "userId": userId,
                "userName": userName
            ]
        case .bindPhone(let userName, let code):
            return [
                "token": token,
                "userId": userId,
                "userName": userName,
                "code": code
            ]
        case .userAccountLog():
            return [
                "token": token,
                "userId": userId
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
