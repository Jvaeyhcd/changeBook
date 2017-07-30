//
//  OtherAPI.swift
//  changeBook
//
//  Created by Jvaeyhcd on 30/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import Moya

let otherRequestClosure = { (endpoint: Endpoint<OtherAPI>, done: @escaping MoyaProvider<OtherAPI>.RequestResultClosure) in
    
    guard var request = endpoint.urlRequest else { return }
    
    request.timeoutInterval = TimeInterval(TIMEOUTTIME)    //设置请求超时时间
    done(.success(request))
}

let OtherProvider = MoyaProvider<OtherAPI>(requestClosure:otherRequestClosure)

public enum OtherAPI {
    // 获取首页banner
    case getBanner()
    // 添加书籍捐赠
    case addDonation()
    // 获取热门搜索
    case getHotSearch()
    // 首页内容搜索
    case searchContent()
}

extension OtherAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: kBaseUrl)!
    }
    
    public var path: String {
        switch self {
        case .getBanner:
            return "/bookcycling/getBanner"
        case .addDonation:
            return "/bookcycling/addDonation"
        case .getHotSearch():
            return "/bookcycling/getHotSearch"
        case .searchContent():
            return "/bookcycling/searchContent"
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
        case .getBanner:
            return nil
        case .addDonation():
            return [
                "token": token,
                "userId": userId
            ]
        case .getHotSearch():
            return [
                "token": token,
                "userId": userId
            ]
        case .searchContent():
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
