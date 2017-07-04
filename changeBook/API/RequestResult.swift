//
//  RequestResult.swift
//  govlan
//
//  Created by Jvaeyhcd on 10/04/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation

enum RequestResult {
    case Scuccess
    case Failed(message: String)
}

extension RequestResult: Equatable{}

func ==(lhs: RequestResult, rhs: RequestResult) -> Bool {
    switch (lhs, rhs) {
    case (.Scuccess, .Scuccess):
        return true
    case (.Failed(let x), .Failed(let y))
        where x == y:
        return true
    default:
        return false
    }
}
