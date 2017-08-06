//
//  Article.swift
//  changeBook
//
//  Created by Jvaeyhcd on 24/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Article {
    var user: User
    var id: String
    var title: String
    var content: String
    var cover: String
    var readNum: String
    var commentNum: String
    var likeNum: String
    var createAt: String
    var integral: String
    var isLike: Int
    
    init(json: JSON) {
        self.user = User.fromJSON(json: json["user"].object)
        self.id = json["id"].stringValue
        self.title = json["title"].stringValue
        self.content = json["content"].stringValue
        self.cover = json["cover"].stringValue
        self.readNum = json["readNum"].stringValue
        self.commentNum = json["commentNum"].stringValue
        self.likeNum = json["likeNum"].stringValue
        self.createAt = json["createAt"].stringValue
        self.integral = json["integral"].stringValue
        self.isLike = json["isLike"].intValue
    }
}

extension Article: Decodable {

    static func fromJSON(json: Any) -> Article {
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        let article = Article.init(json: data)
        return article
        
    }
}

// 文章分类
struct ArticleCategory {
    var id: String
    var category: String
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.category = json["category"].stringValue
    }
}

extension ArticleCategory: Decodable {
    static func fromJSON(json: Any) -> ArticleCategory {
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        let cate = ArticleCategory.init(json: data)
        return cate
    }
}

// 文章打赏记录
struct RewardLog {
    var id: String
    var user: User
    var createAt: String
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.user = User.fromJSON(json: json["user"].object)
        self.createAt = json["createAt"].stringValue
    }
}

extension RewardLog: Decodable {
    static func fromJSON(json: Any) -> RewardLog {
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        let log = RewardLog.init(json: data)
        return log
    }
}
