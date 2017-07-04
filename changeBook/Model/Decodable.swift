//
//  Decodable.swift
//  govlan
//
//  Created by polesapp-hcd on 2017/4/6.
//  Copyright © 2017年 Jvaeyhcd. All rights reserved.
//

import Foundation

protocol Decodable {
    static func fromJSON(json: Any) -> Self
}

extension Decodable {
    static func fromJSONArray(json: [Any]) -> [Self] {
        return json.map { Self.fromJSON(json: $0) }
    }
}

enum BError: Error {
    case NotAuthenticated
    case RateLimitExceeded
    case WrongJSONParsing
    case Generic
}
