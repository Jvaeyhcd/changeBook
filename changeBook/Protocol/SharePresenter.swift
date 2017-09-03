//
//  SharePresenter.swift
//  changeBook
//
//  Created by Salvador on 03/09/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import Foundation

protocol SharePresenter {
    func shareWebPageToPlatformType(platformType: UMSocialPlatformType,
                           currentViewController: UIViewController,
                                        shareUrl: String,
                                        shareImg: String,
                                      shareTitle: String,
                                       shareDesc: String)
}

extension SharePresenter {
    func shareWebPageToPlatformType(platformType: UMSocialPlatformType,
                           currentViewController: UIViewController,
                                        shareUrl: String,
                                        shareImg: String,
                                      shareTitle: String,
                                       shareDesc: String) {
        //创建分享消息对象
        let messageObject = UMSocialMessageObject.init()
        
        //创建网页内容对象
        let shareObject = UMShareWebpageObject.shareObject(withTitle: shareTitle, descr: shareDesc, thumImage: shareImg)
        //设置网页地址
        shareObject?.webpageUrl = shareUrl
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject
        
        //调用分享接口
        UMSocialManager.default().share(to: platformType, messageObject: messageObject, currentViewController: currentViewController) { (data, error) in
            
        }
    }
}
