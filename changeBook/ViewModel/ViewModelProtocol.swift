//
//  ViewModelProtocol.swift
//  govlan
//
//  Created by Jvaeyhcd on 07/04/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation
import SwiftyJSON
import Result
import Moya
import RealmSwift

typealias VoidBlock = ()->()
typealias MessageBlock = (String)->()
typealias DataBlock = (JSON)->()

protocol ViewModelProtocol {
    //网络请求的统一处理
    func request(cacheName: String, result: Result<Moya.Response, Moya.MoyaError>, success: @escaping DataBlock, fail: @escaping MessageBlock, loginSuccess: @escaping VoidBlock)
    //读取请求之前的缓存
    func getCacheData(cacheName: String, cacheData: DataBlock)
    
}

extension ViewModelProtocol {
    
    func request(cacheName: String, result: Result<Moya.Response, Moya.MoyaError>, success: @escaping DataBlock, fail: @escaping MessageBlock, loginSuccess: @escaping VoidBlock) {
        
        switch result {
        case .success(let response):
            let json = JSON.init(data: response.data)
            
            let status = Status.fromJSON(json: json["status"].object)
            if kServerSuccessCode == status.code {
                let data = json["data"]
                // 判断网络请求是否返回了data数据，保证返回到页面处理的时候程序不会崩溃
                if JSON.null != data {
                    success(data)
                    if cacheName != kNoNeedCache {
                        // 将网络请求返回的数据存入到缓存中
                        let apiCache = APIResult()
                        apiCache.name = cacheName
                        //apiCache.json = data.stringValue
                        apiCache.json = "\(data)"
                        //FMLog(log: "apiCache: \(apiCache)")
                        try! sharedGlobal.getRealm().write {
                            sharedGlobal.getRealm().add(apiCache, update: true)
                        }
                    }
                } else {
                    success(JSON.null)
                }
            } else if kServerNeedLoginCode == status.code {
                fail("")
                var vc = UIApplication.shared.keyWindow?.rootViewController
                while vc != nil {
                    if vc is UINavigationController {
                        vc = (vc as! UINavigationController).visibleViewController
                    } else if vc is UITabBarController {
                        vc = (vc as! UITabBarController).selectedViewController
                    } else {
                        if let presentedVC = vc!.presentedViewController {
                            vc = presentedVC
                        } else {
                            break
                        }
                    }
                }

                
                // 需要判断防止多次弹出需要登录界面
                if let vc = vc {
                    
                    if showedLogin == false {
                        
                        let loginNav = UINavigationController(rootViewController: LoginViewController())
                        
                        vc.present(loginNav, animated: true, completion: nil)
                    }
                }
                
            } else if kServerFailedCode == status.code {
                
                fail(status.message)
                
            } else {
                fail("未知错误")
                
            }
            
        case .failure(let error):
            
            if TIMEOUTCODE == error.response?.statusCode{
                fail("网络超时")
            }else{
                fail("")
            }
            
            let networkWorked = kUserDefaults.bool(forKey: "networkWorked")
            if !networkWorked{
                
            }
        }
        
    }
    
    func getCacheData(cacheName: String, cacheData: DataBlock) {
        
        let results: Results<APIResult>?
        results = sharedGlobal.getRealm().objects(APIResult.self).filter("name = '" + cacheName + "'")
        if nil != results && (results?.count)! > 0 {
            for result in results! {
                let json = JSON.init(data: result.json.data(using: .utf8)!)
                
                if JSON.null != json {
                    cacheData(json)
                    break
                }
            }
        }
    }
    
}
