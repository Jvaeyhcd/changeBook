//
//  ArticleAPI.swift
//  changeBook
//
//  Created by Jvaeyhcd on 24/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import Moya

let articleRequestClosure = { (endpoint: Endpoint<ArticleAPI>, done: @escaping MoyaProvider<ArticleAPI>.RequestResultClosure) in
    
    guard var request = endpoint.urlRequest else { return }
    
    request.timeoutInterval = TimeInterval(TIMEOUTTIME)    //设置请求超时时间
    done(.success(request))
}

let ArticleAPIProvider = RxMoyaProvider<ArticleAPI>(requestClosure: articleRequestClosure)


public enum ArticleAPI {
    // 筛选文章
    case filterArticle(category: String, page: Int)
    
    // 获取文章类型
    case getArticleCategory()
    
    // 获取文章详情
    case getArticleDetail(articleId: String)
    
    // 搜索文章
    case searchArticle(keyWords: String, page: Int)
    
    // 获取文章打赏记录
    case getArticleReward(articleId: String, page: Int)
    
    // 打赏文章
    case articleReward(integral: String, articleId: String)
    
    // 评论文章
    case addArticleComment(articleId: String, content: String, commentType: String, score: String, articleCommentId: String, receiverId: String)
    
    // 获取文章评论
    case getArticleComment(articleId: String, page: Int)
    
    // 获取评论详情
    case getArticleCommentDetail(articleCommentId: String, page: Int)
    
    // 获取热门文章
    case getHotArticle(page: Int)
}

extension ArticleAPI: TargetType {
    public var baseURL: URL {
        return URL(string: kBaseUrl)!
    }
    
    public var path: String {
        switch self {
        case .filterArticle(category: _, page: _):
            return "/article/filterArticle"
        case .getArticleCategory():
            return "/article/getArticleCategory"
        case .getArticleDetail(articleId: _):
            return "/article/getArticleDetail"
        case .searchArticle(keyWords: _, page: _):
            return "/article/searchArticle"
        case .getArticleReward(articleId: _, page: _):
            return "/article/getArticleReward"
        case .articleReward(integral: _, articleId: _):
            return "/article/articleReward"
        case .addArticleComment(articleId: _, content: _, commentType: _, score: _, articleCommentId: _, receiverId: _):
            return "/article/addArticleComment"
        case .getArticleComment(articleId: _, page: _):
            return "/article/getArticleComment"
        case .getArticleCommentDetail(articleCommentId: _, page: _):
            return "/article/getCommentDetail"
        case .getHotArticle(page: _):
            return "/article/getHotArticle"
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
        case .filterArticle(let category, let page):
            return [
                "token": token,
                "userId": userId,
                "category": category,
                "page": page
            ]
        case .getArticleCategory():
            return [
                "token": token,
                "userId": userId
            ]
        case .getArticleDetail(let articleId):
            return [
                "token": token,
                "userId": userId,
                "articleId": articleId
            ]
        case .searchArticle(let keyWords, let page):
            return [
                "token": token,
                "userId": userId,
                "keyWords": keyWords,
                "page": page
            ]
        case .getArticleReward(let articleId, let page):
            return [
                "token": token,
                "userId": userId,
                "articleId": articleId,
                "page": page
            ]
        case .articleReward(let integral, let articleId):
            return [
                "token": token,
                "userId": userId,
                "integral": integral,
                "articleId": articleId
            ]
        case .addArticleComment(let articleId, let content, let commentType, let score, let articleCommentId, let receiverId):
            return [
                "token": token,
                "userId": userId,
                "content": content,
                "articleId": articleId,
                "commentType": commentType,
                "score": score,
                "articleCommentId": articleCommentId,
                "receiverId": receiverId
            ]
        case .getArticleComment(let articleId, let page):
            return [
                "token": token,
                "userId": userId,
                "page": page,
                "articleId": articleId
            ]
        case .getArticleCommentDetail(let articleCommentId, let page):
            return [
                "token": token,
                "userId": userId,
                "articleCommentId": articleCommentId,
                "page": page
            ]
        case .getHotArticle(let page):
            return [
                "token": token,
                "userId": userId,
                "page": page
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
