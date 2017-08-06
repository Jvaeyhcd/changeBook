//
//  ArticleViewModel.swift
//  changeBook
//
//  Created by Jvaeyhcd on 24/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class ArticleViewModel: ViewModelProtocol {

    // 筛选文章
    func filterArticle(category: String,
                       page: Int,
                       cache: @escaping DataBlock,
                       success: @escaping DataBlock,
                       fail: @escaping MessageBlock,
                       loginSuccess: @escaping VoidBlock) {
        
        var cacheName = kNoNeedCache
        if 1 == page {
            cacheName = "filterArticle:\(category):\(page)"
            self.getCacheData(cacheName: cacheName, cacheData: cache)
        }
        ArticleAPIProvider.request(ArticleAPI.filterArticle(category: category, page: page)) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 获取文章类型
    func getArticleCategory(cache: @escaping DataBlock,
                            success: @escaping DataBlock,
                            fail: @escaping MessageBlock,
                            loginSuccess: @escaping VoidBlock) {
        self.getCacheData(cacheName: "getArticleCategory", cacheData: cache)
        ArticleAPIProvider.request(ArticleAPI.getArticleCategory()) { [weak self] (result) in
            self?.request(cacheName: "getArticleCategory", result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 获取文章详情
    func getArticleDetail(articleId: String,
                          cache: @escaping DataBlock,
                          success: @escaping DataBlock,
                          fail: @escaping MessageBlock,
                          loginSuccess: @escaping VoidBlock) {
        let cacheName = "getArticleDetail:" + articleId
        self.getCacheData(cacheName: cacheName, cacheData: cache)
        ArticleAPIProvider.request(ArticleAPI.getArticleDetail(articleId: articleId)) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 搜索文章
    func searchArticle(keyWords: String,
                       page: Int,
                       success: @escaping DataBlock,
                       fail: @escaping MessageBlock,
                       loginSuccess: @escaping VoidBlock) {
        ArticleAPIProvider.request(ArticleAPI.searchArticle(keyWords: keyWords, page: page)) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 获取文章打赏记录
    func getArticleReward(articleId: String,
                          page: Int,
                          cache: @escaping DataBlock,
                          success: @escaping DataBlock,
                          fail: @escaping MessageBlock,
                          loginSuccess: @escaping VoidBlock) {
        let cacheName = "getArticleReward:" + articleId
        self.getCacheData(cacheName: cacheName, cacheData: cache)
        ArticleAPIProvider.request(ArticleAPI.getArticleReward(articleId: articleId, page: page)) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 打赏文章
    func articleReward(integral: String,
                       articleId: String,
                       success: @escaping DataBlock,
                       fail: @escaping MessageBlock,
                       loginSuccess: @escaping VoidBlock) {
        ArticleAPIProvider.request(ArticleAPI.articleReward(integral: integral, articleId: articleId)) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 评论文章
    func addArticleComment(articleId: String,
                           content: String,
                           commentType: String,
                           score: String,
                           articleCommentId: String,
                           receiverId: String,
                           success: @escaping DataBlock,
                           fail: @escaping MessageBlock,
                           loginSuccess: @escaping VoidBlock) {
        ArticleAPIProvider.request(ArticleAPI.addArticleComment(articleId: articleId, content: content, commentType: commentType, score: score, articleCommentId: articleCommentId, receiverId: receiverId)) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 获取文章评论
    func getArticleComment(articleId: String,
                           page: Int,
                           cache: @escaping DataBlock,
                           success: @escaping DataBlock,
                           fail: @escaping MessageBlock,
                           loginSuccess: @escaping VoidBlock) {
        
        var cacheName = kNoNeedCache
        if 1 == page {
            cacheName = "getArticleComment:\(articleId):\(page)"
            self.getCacheData(cacheName: cacheName, cacheData: cache)
        }
        ArticleAPIProvider.request(ArticleAPI.getArticleComment(articleId: articleId, page: page)) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 获取评论详情
    func getArticleCommentDetail(articleCommentId: String,
                                 page: Int,
                                 cache: @escaping DataBlock,
                                 success: @escaping DataBlock,
                                 fail: @escaping MessageBlock,
                                 loginSuccess: @escaping VoidBlock) {
        var cacheName = kNoNeedCache
        if 1 == page {
            cacheName = "getArticleCommentDetail:\(articleCommentId):\(page)"
            self.getCacheData(cacheName: cacheName, cacheData: cache)
        }
        
        ArticleAPIProvider.request(ArticleAPI.getArticleCommentDetail(articleCommentId: articleCommentId, page: page)) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 获取热门文章
    func getHotArticle(page: Int,
                       cache: @escaping DataBlock,
                       success: @escaping DataBlock,
                       fail: @escaping MessageBlock,
                       loginSuccess: @escaping VoidBlock) {
        var cacheName = kNoNeedCache
        if 1 == page {
            cacheName = "getHotArticle:\(page)"
            self.getCacheData(cacheName: cacheName, cacheData: cache)
        }
        ArticleAPIProvider.request(ArticleAPI.getHotArticle(page: page)) { [weak self] (result) in
            self?.request(cacheName: cacheName, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
    
    // 文章点赞
    func likeArticle(articleId: String,
                     success: @escaping DataBlock,
                     fail: @escaping MessageBlock,
                     loginSuccess: @escaping VoidBlock) {
        ArticleAPIProvider.request(ArticleAPI.likeArticle(articleId: articleId)) { [weak self] (result) in
            self?.request(cacheName: kNoNeedCache, result: result, success: success, fail: fail, loginSuccess: loginSuccess)
        }
    }
}
