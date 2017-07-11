//
//  Document.swift
//  changeBook
//
//  Created by Jvaeyhcd on 11/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON

let kDocumentTypePDF = 1
let kDocumentTypePPT = 2
let kDocumentTypeDOC = 3
let kDocumentTypeEXC = 4
let kDocumentTypeTXT = 5

let INT_TRUE = 1
let INT_FALSE = 0

struct Document {
    var id: String
    var documentName: String
    var documentCover: String
    var documentType: Int
    var fileFormat: Int
    var commentNum: String
    var readNum: String
    var uploader: String
    var score: String
    var needIntegral: String
    var fileSize: String
    var isRead: Int
    
    init(json: JSON) {
        self.id = json["id"].stringValue
        self.documentName = json["documentName"].stringValue
        self.documentCover = json["documentCover"].stringValue
        self.documentType = json["documentType"].intValue
        self.fileFormat = json["fileFormat"].intValue
        self.commentNum = json["commentNum"].stringValue
        self.readNum = json["readNum"].stringValue
        self.uploader = json["uploader"].stringValue
        self.score = json["score"].stringValue
        self.needIntegral = json["needIntegral"].stringValue
        self.fileSize = json["fileSize"].stringValue
        self.isRead = json["isRead"].intValue
    }
}

extension Document: Decodable {
    static func fromJSON(json: Any) -> Document {
        var data = JSON.init(json)
        if json is JSON {
            data = json as! JSON
        }
        let document = Document.init(json: data)
        return document
    }
}
