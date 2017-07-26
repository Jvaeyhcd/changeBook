//
//  Book.swift
//  changeBook
//
//  Created by Jvaeyhcd on 22/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

// 推荐
let kBookFilterRecommend = 0
// 理工
let kBookFilterPolytechnic = 1
// 社科
let kBookFilterSocial = 2
// 教辅
let kBookFilterSupplementary = 3
// 课外
let kBookFilterExtracurricular = 4

struct Book {
    var id: String
    var bookName: String
    var bookPrice: String
    var bookCover: String
    var introduce: String
    var publisher: String
    var commentNum: String
    var borrowCount: String
    var bookCount: String
    var bookType: Int
    var ISBN: String
    var bookFile: String
    var score: String
    var bookAuthor: String
    var hasFile: Int
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.bookName = json["bookName"].stringValue
        self.bookPrice = json["bookPrice"].stringValue
        self.bookCover = json["bookCover"].stringValue
        self.introduce = json["introduce"].stringValue
        self.publisher = json["publisher"].stringValue
        self.commentNum = json["commentNum"].stringValue
        self.borrowCount = json["borrowCount"].stringValue
        self.bookCount = json["bookCount"].stringValue
        self.bookType = json["bookType"].intValue
        self.ISBN = json["ISBN"].stringValue
        self.bookFile = json["bookFile"].stringValue
        self.score = json["score"].stringValue
        self.bookAuthor = json["bookAuthor"].stringValue
        self.hasFile = json["hasFile"].intValue
    }
}

extension Book: Decodable {
    static func fromJSON(json: Any) -> Book {
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        let book = Book.init(json: data)
        
        return book
    }
}
