//
//  Comment.swift
//  changeBook
//
//  Created by Jvaeyhcd on 19/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

let kCommentLv1 = "1"
let kCommentLv2 = "2"

let kLikeDataCommentType = 1
let kLikeBookCommentType = 2
let kLikeArticleCommentType = 3

let kCommentTypeDocument = "1"
let kCommentTypeBook = "2"
let kCommentTypeArticle = "3"

struct Comment {
    var id: String
    var commentContent: String
    var sender: User
    var receiver: User
    var score: String
    var likeNum: String
    var commentNum: String
    var createAt: String
    var isLike: Int
    
    var senderId: String
    var title: String
    var commentType: String
    var user: User
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.commentContent = json["commentContent"].stringValue
        self.sender = User.fromJSON(json: json["sender"])
        self.receiver = User.fromJSON(json: json["receiver"])
        self.score = json["score"].stringValue
        self.likeNum = json["likeNum"].stringValue
        self.commentNum = json["commentNum"].stringValue
        self.createAt = json["createAt"].stringValue
        self.isLike = json["isLike"].intValue
        
        self.senderId = json["senderId"].stringValue
        self.title = json["title"].stringValue
        self.commentType = json["commentType"].stringValue
        self.user = User.fromJSON(json: json["user"].object)
    }
}

extension Comment: Decodable {
    static func fromJSON(json: Any) -> Comment {
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        let comment = Comment.init(json: data)
        return comment
    }
}
