//
//  FileAPI.swift
//  govlan
//
//  Created by Jvaeyhcd on 17/04/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import Moya

let fileRequestClosure = { (endpoint: Endpoint<FileAPI>, done: @escaping MoyaProvider<FileAPI>.RequestResultClosure) in
    
    guard var request = endpoint.urlRequest else { return }
    
    request.timeoutInterval = TimeInterval(TIMEOUTTIME)    //设置请求超时时间
    done(.success(request))
}

let FileProvider = MoyaProvider<FileAPI>(requestClosure:fileRequestClosure)

public enum FileAPI {
    case GetFileToken()
}

extension FileAPI: TargetType {

    public var baseURL: URL {
        return URL(string: kBaseUrl)!
    }
    
    public var path: String {
        switch self {
        case .GetFileToken:
            return "/bookcycling/getQiNiuToken"
        }
    }
    
    public var method: Moya.Method {
        return Moya.Method.post
    }
    
    public var parameters: [String : Any]? {
        switch self {
        case .GetFileToken:
            return nil
        }
    }
    
    public var task: Task {
        switch self {
        case .GetFileToken():
            return .request
        }
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
