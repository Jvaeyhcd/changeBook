//
//  QiniuManager.swift
//  govlan
//
//  Created by Jvaeyhcd on 17/04/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import Qiniu

class QiniuManager: NSObject, ViewModelProtocol {
    
    var token: String = ""
    var images: [UIImage] = [UIImage]()
    // 区分上传图片的类型，u为上传的用户头像，t为上传的话题图片，p上传帖子图片，r为上传口碑图片
    var type: String = ""
    private var successCount = 0
    // 上传成功的图片文件名
    private var uploadedUrl = [String]()
    
    typealias UploadImagesSuccessBlock = (String) -> ()
    
    override init() {
        
    }
    
    /*
     *
     */
    func getImagePath(image: UIImage) -> String {
        var filePath = ""
        
        var data: Data?
        if nil == UIImagePNGRepresentation(image) {
            data = UIImageJPEGRepresentation(image, 1.0)
        } else {
            data = UIImagePNGRepresentation(image)
        }
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        let documentsPath = NSHomeDirectory().appendingFormat("Documents")
        
        //文件管理器
        let fileManager = FileManager.default
        
        //把刚刚图片转换的data对象拷贝至沙盒中
        do {
            try fileManager.createDirectory(atPath: documentsPath, withIntermediateDirectories: true, attributes: nil)
            let imagePath = "/theFirstImage.png"
            fileManager.createFile(atPath: documentsPath + imagePath, contents: data, attributes: nil)
            
            //得到选择后沙盒中图片的完整路径
            filePath = documentsPath + imagePath
        } catch let error as NSError {
            NSLog("\(error.localizedDescription)")
        }
        
        return filePath
    }
    
    func uploadImages(successBlock: @escaping UploadImagesSuccessBlock, failureBlock: @escaping MessageBlock) {
        
        FileProvider.request(.GetFileToken()) { (result) in
            self.request(cacheName: kNoNeedCache, result: result, success: { (data) in
                let token = data["qiniuToken"].stringValue
                self.token = token
                
                if self.images.count == 0 {
                    return
                }
                
                var index = 0
                
                for image in self.images {
                    
                    let img = image.wxCompress()
                    
                    self.uploadImageToQiniu(index: index, image: img, progressHandler: { (key, percent) in
                        BLog(log: "percent = \(percent)")
                    }, completionHandler: { (info, key, resp) in
                        self.successCount = self.successCount + 1
                        if self.successCount == self.images.count {
                            
                            var picList = self.uploadedUrl[0]
                            if self.images.count > 1 {
                                for i in 1 ..< self.images.count {
                                    picList = picList + "," + self.uploadedUrl[i]
                                }
                            }
                            
                            successBlock(picList)
                        }
                        
                    })
                    index = index + 1
                }
            }, fail: { (message) in
                failureBlock(message)
            }, loginSuccess: { 
                
            })
        }
        
    }
    
    func uploadImageToQNFilePath(index: Int, filePath: String, progressHandler: @escaping QNUpProgressHandler, completionHandler: @escaping QNUpCompletionHandler) {
        
        let upManager = QNUploadManager.init()
        let uploadOption = QNUploadOption.init(mime: nil, progressHandler: progressHandler, params: nil, checkCrc: false, cancellationSignal: nil)
        
        //获取当前时间
        let now = NSDate()
        
        //当前时间的时间戳
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        
        let user = sharedGlobal.getSavedUser()
        
        //时间戳+用户ID+index构成图片的名称
        let key = String(timeStamp) + user.userId + String(index) + ".png"
        
//        upManager?.putFile(filePath, key: key, token: self.token, complete: completionHandler, option: uploadOption)
        upManager?.putFile(filePath, key: key, token: self.token, complete: completionHandler, option: uploadOption)
    }
    
    func uploadImageToQiniu(index: Int, image: UIImage, progressHandler: @escaping QNUpProgressHandler, completionHandler: @escaping QNUpCompletionHandler) {
        let upManager = QNUploadManager.init()
        let uploadOption = QNUploadOption.init(mime: nil, progressHandler: progressHandler, params: nil, checkCrc: false, cancellationSignal: nil)
        
        //获取当前时间
        let now = NSDate()
        
        //当前时间的时间戳
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        
        let user = sharedGlobal.getSavedUser()
        
        //type+时间戳+用户ID+index构成图片的名称
        let key = type + String(timeStamp) + user.userId + String(index) + ".JPG"
        self.uploadedUrl.append(key)
        
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        upManager?.put(imageData, key: key, token: self.token, complete: completionHandler, option: uploadOption)
        
    }
}
