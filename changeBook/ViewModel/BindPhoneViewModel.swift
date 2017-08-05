//
//  BindPhoneViewModel.swift
//  changeBook
//
//  Created by Jvaeyhcd on 05/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import SwiftyJSON

class BindPhoneViewModel {

    // Input
    var username = Variable("")
    var vcode = Variable("")
    var registerTaps = PublishSubject<Void>()
    var vcodeTaps = PublishSubject<Void>()
    
    // Output
    let registerEnabled: Driver<Bool>
    let registerFinished: Driver<RequestResult>
    let registerExecuting: Driver<Bool>
    
    let getVcodeEnabled: Driver<Bool>
    let getVcodeFinished: Driver<RequestResult>
    let getVcodeExecuting: Driver<Bool>
    
    // Private
    private let provider: RxMoyaProvider<UserAPI>
    
    init(provider: RxMoyaProvider<UserAPI>) {
        
        self.provider = provider
        
        let activityIndicator = ActivityIndicator()
        registerExecuting = activityIndicator
            .asDriver()
        
        getVcodeExecuting = activityIndicator.asDriver()
        
        let usernameObservable = username.asObservable()
        let vcodeObservable = vcode.asObservable()
        
        registerEnabled = Observable.combineLatest(usernameObservable, vcodeObservable){value1,value3 in
            let result = (value1.characters.count == 11) && (value3.characters.count <= 6) && (value3.characters.count > 0) && (value1.isPhoneNumber())
            return result
            }
            .asDriver(onErrorJustReturn: false)
        
        getVcodeEnabled = usernameObservable
            .map {
                $0.isPhoneNumber()
            }
            .asDriver(onErrorJustReturn: false)
        
        let resgiterParms = Observable.combineLatest(usernameObservable, vcodeObservable)
        { ($0, $1) }
        
        registerFinished = registerTaps
            .asObservable()
            .withLatestFrom(resgiterParms)
            .flatMapLatest { (username, vcode) in
                provider.request(UserAPI.bindPhone(userName: username, code: vcode))
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
                provider.request(UserAPI.getCode(userName: username))
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
