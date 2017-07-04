//
//  Decodable+Rx.swift
//  govlan
//
//  Created by Jvaeyhcd on 11/04/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation

import Moya
import RxSwift
import SwiftyJSON

extension ObservableType where E == Response {
    func checkIfAuthenticated() -> Observable<E> {
        return self.map { response in
            guard response.statusCode != 403 || response.statusCode != 404 else {
                throw BError.NotAuthenticated
            }
            return response
        }
    }
    
    func checkIfRateLimitExceeded() -> Observable<E> {
        return self.map { response -> E in
            
            return response
        }
    }
}

extension ObservableType where E == Response {
    func mapToModels<T: Decodable>(_: T.Type) -> Observable<[T]> {
        return self.mapJSON()
            .map { json -> [T] in
                guard let array = json as? [AnyObject] else {
                    throw BError.WrongJSONParsing
                    
                }
                return T.fromJSONArray(json: array)
        }
    }
    
    func mapToModels<T: Decodable>(_: T.Type, arrayRootKey: String) -> Observable<[T]> {
        return self.mapJSON()
            .map { json -> [T] in
                if let dict = json as? [String : AnyObject],
                    let subJson = dict[arrayRootKey] {
                    return T.fromJSONArray(json: subJson as! [AnyObject])
                } else {
                    throw BError.WrongJSONParsing
                }
        }
    }
    
    func mapToModel<T: Decodable>(_: T.Type) -> Observable<T> {
        return self.mapJSON()
            .map { json -> T in
                return T.fromJSON(json: json)
        }
    }
}

private extension ObservableType where E == Response {
    func mapSwiftyJSON() -> Observable<JSON> {
        return self.mapJSON()
            .map { json in
                return JSON(json)
        }
    }
}
