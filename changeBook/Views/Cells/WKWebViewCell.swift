//
//  WKWebViewCell.swift
//  govlan
//
//  Created by Jvaeyhcd on 24/03/2017.
//  Copyright © 2017 Polesapp. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

let kCellIdWKWebViewCell = "WKWebViewCell"

class WKWebViewCell: UITableViewCell {

    // 文章内容详情webView
    lazy var htmlWebView: WKWebView = {
        let htmlWebView = WKWebView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 1))
        htmlWebView.allowsBackForwardNavigationGestures = true
        htmlWebView.navigationDelegate = self
        htmlWebView.scrollView.isScrollEnabled = false
        htmlWebView.scrollView.bounces = false
        htmlWebView.scrollView.bounces = false
        htmlWebView.isOpaque = false
        htmlWebView.backgroundColor = UIColor.white
        return htmlWebView
    }()
    var scrollView: FDScrollView!
    
    var cellHeightChanged: ((CGFloat) -> ())!
    var webViewTitle: ((String) -> ())!
    var clickedUrlBlock: ((String) -> ())!
    
    // 文章内容高度
    fileprivate var webviewHeight = CGFloat(0)
    fileprivate var imagesUrlArray: [String]!
    
    var content: String! {
        willSet{}
        didSet {
            htmlWebView.loadHTMLString(WebContentManager.articlePatterned(withContent: self.content), baseURL: nil)
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func initUI() {
        
        if nil == scrollView {
            scrollView = FDScrollView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 1))
            scrollView.backgroundColor = UIColor.white
            self.addSubview(scrollView)
        }
        
        scrollView.addSubview(htmlWebView)
        
    }

}

extension WKWebViewCell: WKNavigationDelegate {
    
    
    // 是否允许加载网页 在发送请求之前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let request = navigationAction.request
        let navigationType = navigationAction.navigationType
        
        if request.url?.scheme == "image-preview" {
            //启动图片浏览器， 跳转到图片浏览页面
            
            print("点击了图片")
            
//            let url = ((request.url as NSString).substringFromIndex(14)) as String
            let url = ((request.url?.absoluteString)! as NSString).substring(from: 14) as String
            
            
            print(url)
            
            let count = self.imagesUrlArray.count
            
            var selectedIndex = 0
            
            if count > 0 {
                let photos = NSMutableArray.init(capacity: count)
                for i in 0..<count {
                    let photo = MJPhoto.init()
                    
                    let itemUrl = self.imagesUrlArray[i] 
                    
                    if itemUrl == url {
                        selectedIndex = i
                    }
                    
                    photo.url = URL(string: itemUrl)
                    photos.add(photo)
                }
                
                let browser = MJPhotoBrowser.init()
                browser.currentPhotoIndex = UInt(selectedIndex)
                browser.photos = photos as [AnyObject]
                browser.show()
                
//                let browser = XLPhotoBrowser.show(withImages: self.imagesUrlArray, currentImageIndex: 0)
//                browser?.browserStyle = XLPhotoBrowserStyle.simple
            }
            decisionHandler(.cancel)
        }
        
        if navigationType == .linkActivated {
            //用户点击文章详情中的链接
            print("点击了链接" + (request.url?.absoluteString)!)
            if nil != self.clickedUrlBlock {
                self.clickedUrlBlock((request.url?.absoluteString)!)
                decisionHandler(.cancel)
            }
        }
        decisionHandler(.allow)
    }
    
    // 网页加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        refreshwebContentView()
        
        webView.evaluateJavaScript("document.body.offsetHeight") { [weak self] (result, error) in
            // 获取页面高度，并重置webview的frame
            
            if nil == result {
                return
            }
            
            let scrollHeight = CGFloat((result! as AnyObject).floatValue)
            
            if self!.webviewHeight != scrollHeight {
                self!.webviewHeight = scrollHeight
                if (self!.cellHeightChanged != nil) {
                    self!.cellHeightChanged(self!.webviewHeight)
                }
            }
            self!.scrollView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: scrollHeight)
            self!.htmlWebView.frame = CGRect(x: self!.htmlWebView.frame.origin.x, y: self!.htmlWebView.frame.origin.y, width: kScreenWidth, height: scrollHeight)
            
        }
        
        //插入js代码，对图片进行点击操作
        
        webView.evaluateJavaScript("function assignImageClickAction(){var imgs=document.getElementsByTagName('img');var length=imgs.length;for(var i=0; i < length;i++){img=imgs[i];if(\"ad\" ==img.getAttribute(\"flag\")){var parent = this.parentNode;if(parent.nodeName.toLowerCase() != \"a\")return;}img.onclick=function(){window.location.href='image-preview:'+this.src}}}") { (result, error) in
            
        }
        
        webView.evaluateJavaScript("assignImageClickAction();") { (result, error) in
            
        }
        
        // 获取webView的title
        if self.webViewTitle != nil {
            let title = webView.title
            self.webViewTitle(title!)
        }
        
        getImgs()
    }
    
    //MARK: - Private
    
    private func refreshwebContentView() {
        let meta = String.init(format: "document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"", self.htmlWebView.frame.width)
        self.htmlWebView.evaluateJavaScript(meta, completionHandler: { (result, error) in
            
        })
    }
    
    // 获取文章中的图片
    private func getImgs() {
        
        imagesUrlArray = [String]()
        
        let jsString = "document.getElementsByTagName('img').length"
        
        self.htmlWebView.evaluateJavaScript(jsString) { [weak self] (result, error) in
            
            if result == nil {
                return
            }
            
            let count = Int((result! as AnyObject).integerValue)
            
            for i in 0..<count {
                let jsString = String(format: "document.getElementsByTagName('img')[%d].src", i)
                self!.htmlWebView.evaluateJavaScript(jsString, completionHandler: { [weak self] (result, error) in
                    
                    if result != nil {
                        BLog(log: "result = \(result!)")
                        
                        self?.imagesUrlArray.append(String(describing: result!))
                    }
                    
                })
                
            }
            
        }
        
    }
    
}
