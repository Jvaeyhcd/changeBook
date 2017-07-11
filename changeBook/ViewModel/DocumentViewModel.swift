//
//  DocumentViewModel.swift
//  changeBook
//
//  Created by Jvaeyhcd on 11/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation

class DocumentViewModel: ViewModelProtocol {
    
    func getHotDocument(cache: @escaping DataBlock,
                        success: @escaping DataBlock,
                        fail: @escaping MessageBlock,
                        loginSuccess: @escaping VoidBlock) {
        
        let cacheName = "getHotDocument"
        self.getCacheData(cacheName: cacheName, cacheData: cache)
        
        DocumentProvider.request(DocumentAPI.getHotDocument()) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
        
    }
    
}
