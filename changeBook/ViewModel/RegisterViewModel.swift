//
//  RegisterViewModel.swift
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

class RegisterViewModel {
    // Input
    var username = Variable("")
    var vcode = Variable("")
    var inviteCode = Variable("")
    var password = Variable("")
    var registerTaps = PublishSubject<Void>()
    var vcodeTaps = PublishSubject<Void>()
    
    // Output
    let registerEnabled: Driver<Bool>
    let registerFinished: Driver<RequestResult>
    let registerExecuting: Driver<Bool>
    
    let getVcodeEnabled: Driver<Bool>
    let getVcodeFinished: Driver<RequestResult>
    let getVcodeExecuting: Driver<Bool>
    
    let passwordEnabled: Driver<Bool>
    
    // Private
    private let provider: RxMoyaProvider<UserAPI>
    
    init(provider: RxMoyaProvider<UserAPI>) {
        
        self.provider = provider
     
        let activityIndicator = ActivityIndicator()
        registerExecuting = activityIndicator
            .asDriver()
        
        getVcodeExecuting = activityIndicator.asDriver()
        
        let usernameObservable = username.asObservable()
        let passwordObservable = password.asObservable()
        let vcodeObservable = vcode.asObservable()
        let inviteCodeObservable = inviteCode.asObservable()
        
        registerEnabled = Observable.combineLatest(usernameObservable, passwordObservable, vcodeObservable){value1,value2,value3 in
            let result = (value1.characters.count == 11) && (value2.characters.count >= 6) && (value3.characters.count <= 6) && (value3.characters.count > 0) && (value1.isPhoneNumber())
            return result
            }
            .asDriver(onErrorJustReturn: false)
        
        getVcodeEnabled = usernameObservable
            .map {
                $0.isPhoneNumber()
            }
            .asDriver(onErrorJustReturn: false)
        
        passwordEnabled = passwordObservable.map {
            $0.characters.count >= 6
            }
            .asDriver(onErrorJustReturn: false)
        
        let resgiterParms = Observable.combineLatest(usernameObservable, passwordObservable, vcodeObservable, inviteCodeObservable)
        { ($0, $1, $2, $3) }
        
        registerFinished = registerTaps
            .asObservable()
            .withLatestFrom(resgiterParms)
            .flatMapLatest { (username, password, vcode, inviteCode) in
                provider.request(UserAPI.register(userName: username, password: password, identifyCode:vcode, inviteCode: inviteCode))
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
                    return RequestResult.Scuccess
                }
            }
            .asDriver(onErrorJustReturn: RequestResult.Failed(message: "Oops, something went wrong"))
        
        getVcodeFinished = vcodeTaps
            .asObservable()
            .withLatestFrom(usernameObservable)
            .flatMapLatest { (username) in
                provider.request(UserAPI.registerGetCode(userName: username))
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
                    return RequestResult.Scuccess
                }
                
            }
            .asDriver(onErrorJustReturn: RequestResult.Failed(message: "Oops, something went wrong"))
    }
}
