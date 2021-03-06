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
    case generateBookOrder(freight: String, payWay: String, returnTime: String, bookInfoList: String, addressId: String, deliveryMode: Int, sendTime: String)
    // 删除书包接口
    case deleteShopCar(shopCarIdList: String)
    // 添加书包
    case addShopCar(bookId: String, bookCount: Int)
    // 获取图书评论详情
    case getBookCommentDetail(bookCommentId: String, page: Int)
    // 获取图书评论
    case getBookComment(bookId: String, page: Int)
    // 添加评论图书
    case addBookComment(bookId: String, content: String, commentType: String, score: String, bookCommentId: String, receiverId: String, orderDetailId: String)
    // 获取图书详情
    case getBookDetail(bookId: String)
    // 搜索图书
    case searchBook(keyWords: String, page: Int)
    // 筛选我的借阅
    case getUserBookOrder(orderStatus: Int, page: Int)
    // 获取书包
    case getShopCar()
    // 修改书包数量
    case updateShopCar(bookId: String, bookCount: Int)
    // 获取运费和可借书时间
    case getFreight()
    // 获取自取地址
    case getBookAddress()
    // 图书扫一扫
    case scanBook(ISBN: String)
    // 提交ISBN
    case addISBN(ISBN: String)
}

extension BookAPI: TargetType {
    public var baseURL: URL {
        return URL(string: kBaseUrl)!
    }
    
    public var path: String {
        switch self {
        case .filterBook(type: _, page: _):
            return "/book/filterBook"
        case .generateBookOrder(freight: _, payWay: _, returnTime: _, bookInfoList: _, addressId: _, deliveryMode: _, sendTime: _):
            return "/book/generateBookOrder"
        case .deleteShopCar(shopCarIdList: _):
            return "/book/deleteShopCar"
        case .addShopCar(bookId: _, bookCount: _):
            return "/book/addShopCar"
        case .getBookCommentDetail(bookCommentId: _, page: _):
            return "/book/getCommentDetail"
        case .getBookComment(bookId: _, page: _):
            return "/book/getBookComment"
        case .addBookComment(bookId: _, content: _, commentType: _, score: _, bookCommentId: _, receiverId: _, orderDetailId: _):
            return "/book/addBookComment"
        case .getBookDetail(bookId: _):
            return "/book/getBookDetail"
        case .searchBook(keyWords: _, page: _):
            return "/book/searchBook"
        case .getUserBookOrder(orderStatus: _, page: _):
            return "/book/getUserBookOrder"
        case .getShopCar():
            return "/book/getShopCar"
        case .updateShopCar(bookId: _, bookCount: _):
            return "/book/updateShopCar"
        case .getFreight():
            return "/book/getFreight"
        case .getBookAddress():
            return "/book/getBookAddress"
        case .scanBook(ISBN: _):
            return "/book/scanBook"
        case .addISBN(ISBN: _):
            return "/bookcycling/addISBN"
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
        case .generateBookOrder(let freight, let payWay, let returnTime, let bookInfoList, let addressId, let deliveryMode, let sendTime):
            return [
                "token": token,
                "userId": userId,
                "freight": freight,
                "payWay": payWay,
                "returnTime": returnTime,
                "bookInfoList": bookInfoList,
                "addressId": addressId,
                "deliveryMode": deliveryMode,
                "sendTime": sendTime
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
        case .getBookCommentDetail(let bookCommentId, let page):
            return [
                "token": token,
                "userId": userId,
                "bookCommentId": bookCommentId,
                "page": page
            ]
        case .getBookComment(let bookId, let page):
            return [
                "token": token,
                "userId": userId,
                "bookId": bookId,
                "page": page
            ]
        case .addBookComment(let bookId, let content, let commentType, let score, let bookCommentId, let receiverId, let orderDetailId):
            return [
                "token": token,
                "userId": userId,
                "bookId": bookId,
                "content": content,
                "commentType": commentType,
                "score": score,
                "bookCommentId": bookCommentId,
                "receiverId": receiverId,
                "orderDetailId": orderDetailId
            ]
        case .getBookDetail(let bookId):
            return [
                "token": token,
                "userId": userId,
                "bookId": bookId
            ]
        case .searchBook(let keyWords, let page):
            return [
                "token": token,
                "userId": userId,
                "keyWords": keyWords,
                "page": page
            ]
        case .getUserBookOrder(let orderStatus, let page):
            return [
                "token": token,
                "userId": userId,
                "orderStatus": orderStatus,
                "page": page
            ]
        case .getShopCar():
            return [
                "token": token,
                "userId": userId
            ]
        case .updateShopCar(let bookId, let bookCount):
            return [
                "token": token,
                "userId": userId,
                "shopCarId": bookId,
                "bookCount": bookCount
            ]
        case .getFreight():
            return [
                "token": token,
                "userId": userId
            ]
        case .getBookAddress():
            return [
                "token": token,
                "userId": userId
            ]
        case .scanBook(let ISBN):
            return [
                "token": token,
                "userId": userId,
                "ISBN": ISBN
            ]
        case .addISBN(let ISBN):
            return [
                "token": token,
                "userId": userId,
                "ISBN": ISBN
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
