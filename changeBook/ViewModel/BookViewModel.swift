//
//  BookViewModel.swift
//  changeBook
//
//  Created by Jvaeyhcd on 22/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation

class BookViewModel: ViewModelProtocol {
    // 筛选图书
    func filterBook(type: Int,
                    page: Int,
                    cache: @escaping DataBlock,
                    success: @escaping DataBlock,
                    fail: @escaping MessageBlock,
                    loginSuccess: @escaping VoidBlock) {
        
        var cacheName = kNoNeedCache
        if 1 == page {
            cacheName = "filterBook:\(type)\(page)"
        }
        BookAPIProvider.request(BookAPI.filterBook(type: type, page: page)) { (result) in
            self.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
        
    }
    
    // 借阅下单
    func generateBookOrder(freight: String,
                           payWay: String,
                           returnTime: String,
                           bookInfoList: String,
                           addressId: Int,
                           success: @escaping DataBlock,
                           fail: @escaping MessageBlock,
                           loginSuccess: @escaping VoidBlock) {
        BookAPIProvider.request(BookAPI.generateBookOrder(freight: freight, payWay: payWay, returnTime: returnTime, bookInfoList: bookInfoList, addressId: addressId)) { (result) in
            self.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 删除书包
    func deleteShopCar(shopCarIdList: String,
                       success: @escaping DataBlock,
                       fail: @escaping MessageBlock,
                       loginSuccess: @escaping VoidBlock) {
        BookAPIProvider.request(BookAPI.deleteShopCar(shopCarIdList: shopCarIdList)) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 添加书包
    func addShopCar(bookId: String, bookCount: Int,
                    success: @escaping DataBlock,
                    fail: @escaping MessageBlock,
                    loginSuccess: @escaping VoidBlock) {
        BookAPIProvider.request(BookAPI.addShopCar(bookId: bookId, bookCount: bookCount)) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    // 获取书籍评论详情
    func getBookCommentDetail(bookCommentId: String,
                              page: Int,
                              cache: @escaping DataBlock,
                              success: @escaping DataBlock,
                              fail: @escaping MessageBlock,
                              loginSuccess: @escaping VoidBlock) {
        
        var cacheName = kNoNeedCache
        if 1 == page {
            cacheName = "getBookCommentDetail:\(bookCommentId):\(page)"
            self.getCacheData(cacheName: cacheName, cacheData: cache)
        }
        BookAPIProvider.request(BookAPI.getBookCommentDetail(bookCommentId: bookCommentId, page: page)) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
        
    }
    
    // 获取图书评论
    func getBookComment(bookId: String,
                        page: Int,
                        cache: @escaping DataBlock,
                        success: @escaping DataBlock,
                        fail: @escaping MessageBlock,
                        loginSuccess: @escaping VoidBlock) {
        
        var cacheName = kNoNeedCache
        if 1 == page {
            cacheName = "getBookComment:\(bookId):\(page)"
            self.getCacheData(cacheName: cacheName, cacheData: cache)
        }
        
        BookAPIProvider.request(BookAPI.getBookComment(bookId: bookId, page: page)) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
        
    }
    
    // 评论图书
    func addBookComment(bookId: String,
                        content: String,
                        commentType: String,
                        score: String,
                        bookCommentId: String,
                        receiverId: String,
                        success: @escaping DataBlock,
                        fail: @escaping MessageBlock,
                        loginSuccess: @escaping VoidBlock) {
        BookAPIProvider.request(BookAPI.addBookComment(bookId: bookId, content: content, commentType:commentType, score: score, bookCommentId: bookCommentId, receiverId: receiverId)) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 获取图书详情
    func getBookDetail(bookId: String,
                       cache: @escaping DataBlock,
                       success: @escaping DataBlock,
                       fail: @escaping MessageBlock,
                       loginSuccess: @escaping VoidBlock) {
        
        let cacheName = "getBookDetail" + bookId
        self.getCacheData(cacheName: cacheName, cacheData: cache)
        
        BookAPIProvider.request(BookAPI.getBookDetail(bookId: bookId)) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
        
    }
    
    // 搜索图书
    func searchBook(keyWords: String,
                    page: Int,
                    success: @escaping DataBlock,
                    fail: @escaping MessageBlock,
                    loginSuccess: @escaping VoidBlock) {
        BookAPIProvider.request(BookAPI.searchBook(keyWords: keyWords, page: page)) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 我的借阅
    func getUserBookOrder(orderStatus: String,
                          cache: @escaping DataBlock,
                          success: @escaping DataBlock,
                          fail: @escaping MessageBlock,
                          loginSuccess: @escaping VoidBlock) {
        
        BookAPIProvider.request(BookAPI.getUserBookOrder(orderStatus: orderStatus)) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
        
        
    }
}
