//
//  ResetPasswordViewModel.swift
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

class ResetPasswordViewModel {
    
    // Input
    var username = Variable("")
    var vcode = Variable("")
    var repeatPassword = Variable("")
    var password = Variable("")
    var changedTaps = PublishSubject<Void>()
    var vcodeTaps = PublishSubject<Void>()
    
    // Output
    let changedEnabled: Driver<Bool>
    let changedFinished: Driver<RequestResult>
    let changedExecuting: Driver<Bool>
    
    let getVcodeEnabled: Driver<Bool>
    let getVcodeFinished: Driver<RequestResult>
    let getVcodeExecuting: Driver<Bool>
    
    let samePassword: Driver<Bool>
    let passwordEnabled: Driver<Bool>
    
    // Private
    private let provider: RxMoyaProvider<UserAPI>
    
    init(provider: RxMoyaProvider<UserAPI>) {
        
        self.provider = provider
        
        let activityIndicator = ActivityIndicator()
        changedExecuting = activityIndicator
            .asDriver()
        
        getVcodeExecuting = activityIndicator.asDriver()
        
        let usernameObservable = username.asObservable()
        let passwordObservable = password.asObservable()
        let vcodeObservable = vcode.asObservable()
        let repeatPasswordObservable = repeatPassword.asObservable()
        
        samePassword = Observable.combineLatest(passwordObservable, repeatPasswordObservable) {value1,value2 in
            
            let enable = (value2 == value1)
            
            return enable
            }
            .asDriver(onErrorJustReturn: false)
        
        changedEnabled = Observable
            .combineLatest(usernameObservable, passwordObservable, vcodeObservable, repeatPasswordObservable) {value1,value2,value3,value4 in
                
                let enable = (value1.characters.count == 11) && (value2.characters.count >= 6) && (value3.characters.count <= 6) && (value2 == value4) && value1.isPhoneNumber() && (value3.characters.count > 0)
                
                return enable
            }
            .asDriver(onErrorJustReturn: false)
        
        passwordEnabled = passwordObservable.map {
            $0.characters.count >= 6
            }
            .asDriver(onErrorJustReturn: false)
        
        getVcodeEnabled = usernameObservable
            .map {
                $0.isPhoneNumber()
            }
            .asDriver(onErrorJustReturn: false)
        
        let changeParms = Observable.combineLatest(usernameObservable, passwordObservable, vcodeObservable)
        { ($0, $1, $2) }
        
        changedFinished = changedTaps
            .asObservable()
            .withLatestFrom(changeParms)
            .flatMapLatest { (username, password, vcode) in
                provider.request(UserAPI.ForgetPasswordChangePassword(userName: username, newPassword: password, identifyCode:vcode))
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
                provider.request(UserAPI.ForgetPasswordGetCode(userName: username))
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
