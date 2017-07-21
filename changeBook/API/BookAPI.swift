//
//  BookAPI.swift
//  changeBook
//
//  Created by Jvaeyhcd on 21/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import Moya

let bookRequestClosure = { (endpoint: Endpoint<BookAPI>, done: @escaping MoyaProvider<BookAPI>.RequestResultClosure) in
    
    guard var request = endpoint.urlRequest else { return }
    
    request.timeoutInterval = TimeInterval(TIMEOUTTIME)    //设置请求超时时间
    done(.success(request))
}

let BookAPIProvider = RxMoyaProvider<BookAPI>(requestClosure: bookRequestClosure)

public enum BookAPI {
    // 筛选图书
    case filterBook(type: Int, page: Int)
    // 借阅下单
    case generateBookOrder(freight: String, payWay: String, returnTime: String, bookInfoList: String, addressId: Int)
    // 删除书包接口
    case deleteShopCar(shopCarIdList: String)
    // 添加书包
    case addShopCar(bookId: String, bookCount: Int)
}

extension BookAPI: TargetType {
    public var baseURL: URL {
        return URL(string: kBaseUrl)!
    }
    
    public var path: String {
        switch self {
        case .filterBook(type: _, page: _):
            return "/book/filterBook"
        case .generateBookOrder(freight: _, payWay: _, returnTime: _, bookInfoList: _, addressId: _):
            return "/book/generateBookOrder"
        case .deleteShopCar(shopCarIdList: _):
            return "/book/deleteShopCar"
        case .addShopCar(bookId: _, bookCount: _):
            return "/book/addShopCar"
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
        case .filterBook(let type, let page):
            return [
                "token": token,
                "userId": userId,
                "type": type,
                "page": page
            ]
        case .generateBookOrder(let freight, let payWay, let returnTime, let bookInfoList, let addressId):
            return [
                "token": token,
                "userId": userId,
                "freight": freight,
                "payWay": payWay,
                "returnTime": returnTime,
                "bookInfoList": bookInfoList,
                "addressId": addressId
            ]
        case .deleteShopCar(let shopCarIdList):
            return [
                "token": token,
                "userId": userId,
                "shopCarIdList": shopCarIdList
            ]
        case .addShopCar(let bookId, let bookCount):
            return [
                "token": token,
                "userId": userId,
                "bookId": bookId,
                "bookCount": bookCount
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
