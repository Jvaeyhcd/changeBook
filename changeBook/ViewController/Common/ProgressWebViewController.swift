//
//  ProgressWebViewController.swift
//  govlan
//
//  Created by Jvaeyhcd on 11/04/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import NJKWebViewProgress

enum WebViewShowType {
    case Push
    case Present
}

class ProgressWebViewController: UIViewController, UIWebViewDelegate, NJKWebViewProgressDelegate {

    // 跳转过来显示的方式，push和present两种方式
    var showType: WebViewShowType = .Push
    
    private var webView: UIWebView!
    private var progressView: NJKWebViewProgressView!
    private var progressProxy: NJKWebViewProgress!
    
    //返回按钮
    private var backItem: UIBarButtonItem!
    //关闭按钮
    private var closeItem: UIBarButtonItem!
    
    var urlStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        loadUrl()
    }

    private func initUI() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor(hex: 0xFFFFFF)
        self.showBackButton()
        
        if nil == backItem {
            backItem = UIBarButtonItem(image: UIImage.init(named: "top_btn_back")!, style: UIBarButtonItemStyle.plain, target: self, action: #selector(backNative))
            backItem.tintColor = UIColor.black
        }
        
        if nil == closeItem {
            closeItem = UIBarButtonItem.init(image: UIImage.init(named: "top_btn_close_black"), style: .plain, target: self, action: #selector(closeNative))
            closeItem.tintColor = UIColor.black
        }
        
        self.addLeftButton()
        
        progressProxy = NJKWebViewProgress.init()
        
        webView = UIWebView.init(frame: CGRect(x: 0, y: kNavHeight, width: kScreenWidth, height: kScreenHeight - kNavHeight))
        webView.delegate = progressProxy
        webView.backgroundColor = UIColor(hex: 0xFFFFFF)
        webView.scalesPageToFit = true
        self.view.addSubview(webView)
        
        progressProxy.webViewProxyDelegate = self
        progressProxy.progressDelegate = self
        
        let progressBarHeight = CGFloat(2)
        let navigationBarBounds = self.navigationController!.navigationBar.bounds
        let barFrame = CGRect(x: 0, y: navigationBarBounds.size.height - progressBarHeight, width: navigationBarBounds.size.width, height: progressBarHeight)
        progressView = NJKWebViewProgressView.init(frame: barFrame)
        progressView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
    }
    
    private func addLeftButton() {
        self.navigationItem.leftBarButtonItem = self.backItem
    }
    
    @objc private func backNative() {
        //判断是否有上一层H5页面
        if self.webView.canGoBack {
            //如果有则返回
            self.webView.goBack()
            //同时设置返回按钮和关闭按钮为导航栏左边的按钮
            self.navigationItem.leftBarButtonItems = [self.backItem, self.closeItem]
        } else {
            self.closeNative()
        }
    }
    
    @objc private func closeNative() {
        
        
        switch showType {
        case .Push:
            self.navigationController?.popViewController(animated: true)
            break
        case .Present:
            self.dismiss(animated: true, completion: nil)
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.addSubview(self.progressView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.progressView.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadUrl() {
        
        // 如果不是一个连接则不加载连接
        if !self.urlStr.isURL() {
            return
        }
        
        let req = URLRequest.init(url: URL.init(string: self.urlStr)!)
        self.webView.loadRequest(req)
    }
    
    // MARK: - NJKWebViewProgressDelegate
    
    func webViewProgress(_ webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
        self.progressView.setProgress(progress, animated: true)
        self.title = self.webView.stringByEvaluatingJavaScript(from: "document.title")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
