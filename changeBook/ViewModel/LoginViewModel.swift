//
//  LoginViewModel.swift
//  govlan
//
//  Created by Jvaeyhcd on 10/04/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import SwiftyJSON

class LoginViewModel {
 
    // Input
    var username = Variable("")
    var password = Variable("")
    var loginTaps = PublishSubject<Void>()
    
    // Output
    let loginEnabled: Driver<Bool>
    let loginFinished: Driver<RequestResult>
    let loginExecuting: Driver<Bool>
    
    // Private
    private let provider: RxMoyaProvider<UserAPI>
    
    init(provider: RxMoyaProvider<UserAPI>) {
        
        self.provider = provider
        
        let activityIndicator = ActivityIndicator()
        loginExecuting = activityIndicator.asDriver()
        
        let usernameObservable = username.asObservable()
        let passwordObservable = password.asObservable()
        
        loginEnabled = Observable.combineLatest(usernameObservable, passwordObservable)
        { $0.characters.count == 11 && $1.characters.count >= 6 && $1.characters.count <= 20 }
            .asDriver(onErrorJustReturn: false)
        
        let usernameAndPassword = Observable.combineLatest(usernameObservable, passwordObservable)
        { ($0, $1) }
        
        loginFinished = loginTaps
            .asObservable()
            .withLatestFrom(usernameAndPassword)
            .flatMapLatest { (username, password) in
                provider.request(UserAPI.login(userName: username, password: password))
                    .retry(3)
                    .trackActivity(activityIndicator)
                    .observeOn(MainScheduler.instance)
            }
            .checkIfRateLimitExceeded()
            .mapJSON()
            .map { data in
                
                let json = JSON.init(data)
                
                let status = Status.fromJSON(json: json["status"])
                
                if status.code != kServerSuccessCode {
                    return RequestResult.Failed(message: status.message)
                } else {
                    
                    let data = json["data"]
                    
                    let loginUser = User.fromJSON(json: data["user"])
                    
                    sharedGlobal.saveToken(token: data["token"].stringValue)
                    sharedGlobal.saveUser(user: loginUser)
                    
                    return RequestResult.Scuccess
                }
            }
            .asDriver(onErrorJustReturn: RequestResult.Failed(message: "Oops, something went wrong"))
        
    }
}
