//
//  DocumentViewModel.swift
//  changeBook
//
//  Created by Jvaeyhcd on 11/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation

class DocumentViewModel: ViewModelProtocol {
    
    // 获取热门资料
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
    
    // 搜索资料
    func searchDocument(keyWords: String,
                        page: Int,
                        success: @escaping DataBlock,
                        fail: @escaping MessageBlock,
                        loginSuccess: @escaping VoidBlock) {
        DocumentProvider.request(DocumentAPI.searchDocument(keyWords: keyWords, page: page)) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 推荐资料
    func recommendDocument(documentId: String,
                           cache: @escaping DataBlock,
                           success: @escaping DataBlock,
                           fail: @escaping MessageBlock,
                           loginSuccess: @escaping VoidBlock) {
        
        let cacheName = "recommendDocument" + documentId
        self.getCacheData(cacheName: cacheName, cacheData: cache)
        
        DocumentProvider.request(DocumentAPI.recommendDocument(documentId: documentId)) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 积分购买资料
    func buyDocument(documentId: String,
                     success: @escaping DataBlock,
                     fail: @escaping MessageBlock,
                     loginSuccess: @escaping VoidBlock) {
        DocumentProvider.request(DocumentAPI.buyDocument(documentId: documentId)) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 资料评论点赞
    func likeDocumentComment(documentCommentId: String,
                             success: @escaping DataBlock,
                             fail: @escaping MessageBlock,
                             loginSuccess: @escaping VoidBlock) {
        DocumentProvider.request(DocumentAPI.likeDocumentComment(documentCommentId: documentCommentId)) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 获取评论详情
    func getCommentDetail(documentCommentId: String,
                          page: Int,
                          cache: @escaping DataBlock,
                          success: @escaping DataBlock,
                          fail: @escaping MessageBlock,
                          loginSuccess: @escaping VoidBlock) {
        
        var cacheName = kNoNeedCache
        if 1 == page {
            cacheName = "getCommentDetail" + documentCommentId
            self.getCacheData(cacheName: cacheName, cacheData: cache)
        }
        
        DocumentProvider.request(DocumentAPI.getCommentDetail(documentCommentId: documentCommentId, page: page)) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 评论资料
    func addDocumentComment(documentId: String,
                            content: String,
                            commentType: String,
                            score: String,
                            documentCommentId: String,
                            receiverId: String,
                            success: @escaping DataBlock,
                            fail: @escaping MessageBlock,
                            loginSuccess: @escaping VoidBlock) {
        DocumentProvider.request(DocumentAPI.addDocumentComment(documentId: documentCommentId, content: content, commentType: commentType, score: score, documentCommentId: documentCommentId, receiverId: receiverId)) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 获取资料详情
    func getDocumentDetail(documentId: String,
                           cache: @escaping DataBlock,
                           success: @escaping DataBlock,
                           fail: @escaping MessageBlock,
                           loginSuccess: @escaping VoidBlock) {
        let cacheName = "getDocumentDetail" + documentId
        self.getCacheData(cacheName: cacheName, cacheData: cache)
        DocumentProvider.request(DocumentAPI.getDocumentDetail(documentId: documentId)) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 筛选资料
    func filterDocument(type: Int,
                        rule: Int,
                        page: Int,
                        cache: @escaping DataBlock,
                        success: @escaping DataBlock,
                        fail: @escaping MessageBlock,
                        loginSuccess: @escaping VoidBlock) {
        var cacheName = kNoNeedCache
        if 1 == page {
            cacheName = "filterDocument:\(type):\(rule)"
            self.getCacheData(cacheName: cacheName, cacheData: cache)
        }
        DocumentProvider.request(DocumentAPI.filterDocument(type: type, rule: rule, page: page)) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
}
