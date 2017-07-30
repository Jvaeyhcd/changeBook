//
//  OtherViewModel.swift
//  changeBook
//
//  Created by Jvaeyhcd on 30/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class OtherViewModel: ViewModelProtocol {

    func getBanner(cache: @escaping DataBlock,
                   success: @escaping DataBlock,
                   fail: @escaping MessageBlock,
                   loginSuccess: @escaping VoidBlock) {
        
        
        let cacheName = "getBanner"
        self.getCacheData(cacheName: cacheName, cacheData: cache)
        
        OtherProvider.request(OtherAPI.getBanner()) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
}
