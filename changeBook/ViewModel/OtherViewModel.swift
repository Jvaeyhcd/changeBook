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
    
    // 获取热门搜索
    func getHotSearch(success: @escaping DataBlock,
                      fail: @escaping MessageBlock,
                      loginSuccess: @escaping VoidBlock) {
        OtherProvider.request(OtherAPI.getHotSearch()) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 首页内容搜索
    func searchContent(keyWords: String,
                       success: @escaping DataBlock,
                       fail: @escaping MessageBlock,
                       loginSuccess: @escaping VoidBlock) {
        OtherProvider.request(OtherAPI.searchContent(keyWords: keyWords)) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
}
