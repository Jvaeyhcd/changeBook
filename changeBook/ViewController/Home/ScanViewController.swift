//
//  ScanViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 05/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class ScanViewController: LBXScanViewController {
    
    /**
     @brief  扫码区域上方提示文字
     */
    var topTitle:UILabel?
    
    /**
     @brief  闪关灯开启状态
     */
    var isOpenedFlash:Bool = false
    
    // MARK: - 底部几个功能：开启闪光灯、相册、我的二维码
    
    //底部显示的功能项
    var bottomItemsView:UIView?
    
    //闪光灯
    var btnFlash:UIButton = UIButton()
    
    //手动输入
    var handInputBtn:UIButton = UIButton()
    
    fileprivate lazy var viewModel = BookViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showBackButton()
        self.title = "扫一扫"
        
        //需要识别后的图像
        setNeedCodeImage(needCodeImg: false)
        //需要播放声音
        setNeedPlaySound(needSound: true)
        
        //框向上移动10个像素
        scanStyle?.centerUpOffset += 10
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        drawBottomItems()
        setTipsLbl()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func checkScannedResultURLStr(urlStr: String) -> String {
        
        return urlStr
        
    }
    
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        for result:LBXScanResult in arrayResult {
            
            let ISBN = checkScannedResultURLStr(urlStr: result.strScanned!)
            
            if ISBN != "" {
                
                // 请求网络看看是否有返回数据，有数据才跳转
                self.getBookDetailByISBN(ISBN: ISBN)
                return
            } else {
                self.showMsg(title: "识别失败", message: "二维码格式不正式")
                return
            }
            
        }
    }
    
    private func getBookDetailByISBN(ISBN: String) {
        
        self.showHudLoadingTipStr("")
        
        self.viewModel.scanBook(ISBN: ISBN, success: { [weak self] (data) in
            
            self?.hideHud()
            let book = Book.fromJSON(json: data.object)
            let vc = BookDetailViewController()
            vc.book = book
            self?.pushViewController(viewContoller: vc, animated: true)
            
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
            let vc = CommitISBNViewController()
            vc.ISBN = ISBN
            self?.pushViewController(viewContoller: vc, animated: true)
        }) { 
            
        }
    }
    
    func drawBottomItems() {
        if (bottomItemsView != nil) {
            btnFlash.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_flash_nor"), for:UIControlState.normal)
            return;
        }
        
        let yMax = kScreenHeight - kNavHeight
        
        bottomItemsView = UIView(frame:CGRect( x: 0.0, y: yMax-130, width: self.view.frame.size.width, height: 130 ) )
        
        
        bottomItemsView!.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        
        self.view .addSubview(bottomItemsView!)
        
        
        let size = CGSize(width: 65, height: 110);
        
        self.btnFlash = UIButton()
        btnFlash.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        btnFlash.center = CGPoint(x: bottomItemsView!.frame.width/3, y: bottomItemsView!.frame.height/2)
        btnFlash.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_flash_nor"), for:UIControlState.normal)
        btnFlash.setTitle("开灯", for: UIControlState.normal)
        btnFlash.titleLabel?.textAlignment = .center
        btnFlash.titleLabel?.font = kSmallTextFont
        btnFlash.setTitleColor(UIColor(hex: 0xf0f0f0), for: UIControlState.normal)
        btnFlash.addTarget(self, action: #selector(openOrCloseFlash), for: UIControlEvents.touchUpInside)
        btnFlash.imageView?.contentMode = .scaleAspectFit
        btnFlash.imageView?.snp.makeConstraints({ (make) in
            make.top.equalTo(1)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(40)
        })
        btnFlash.titleLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(1)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(20)
        })
        
        self.handInputBtn = UIButton()
        handInputBtn.bounds = btnFlash.bounds;
        handInputBtn.center = CGPoint(x: bottomItemsView!.frame.width * 2/3,
                                      y: bottomItemsView!.frame.height/2);
        handInputBtn.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_myqrcode_nor"), for: UIControlState.normal)
        handInputBtn.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_myqrcode_down"), for: UIControlState.highlighted)
        handInputBtn.setTitle("手动输入", for: UIControlState.normal)
        handInputBtn.titleLabel?.textAlignment = .center
        handInputBtn.titleLabel?.font = kSmallTextFont
        handInputBtn.setTitleColor(UIColor(hex: 0xf0f0f0), for: UIControlState.normal)
        handInputBtn.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        handInputBtn.addTarget(self, action: #selector(handInputBtnClicked), for: UIControlEvents.touchUpInside)
        handInputBtn.imageView?.contentMode = .scaleAspectFit
        handInputBtn.imageView?.snp.makeConstraints({ (make) in
            make.top.equalTo(1)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(40)
        })
        handInputBtn.titleLabel?.snp.makeConstraints({ (make) in
            make.bottom.equalTo(1)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(20)
        })
        
        bottomItemsView?.addSubview(btnFlash)
        bottomItemsView?.addSubview(handInputBtn)
        
        self.view.addSubview(bottomItemsView!)
        
    }
    
    func setTipsLbl() {
        
        if topTitle != nil {
            return;
        }
        topTitle = UILabel.init()
        topTitle?.frame = CGRect(x: 25,
                                 y: kScreenWidth / 2 - 124 + (kScreenHeight/2),
                                 width: kScreenWidth - 50,
                                 height: 20)
        topTitle?.numberOfLines = 0
        topTitle?.font = kBaseFont
        topTitle?.textColor = .white
        topTitle?.text = "将二维码/条码放入框中，即可自动扫描"
        topTitle?.textAlignment = .center
        self.view.addSubview(topTitle!)
    }
    
    //开关闪光灯
    func openOrCloseFlash() {
        scanObj?.changeTorch();
        
        isOpenedFlash = !isOpenedFlash
        
        if isOpenedFlash {
            btnFlash.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_flash_down"), for:UIControlState.normal)
            btnFlash.setTitleColor(UIColor.white, for: .normal)
        } else {
            btnFlash.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_flash_nor"), for:UIControlState.normal)
            btnFlash.setTitleColor(UIColor(hex: 0xf0f0f0), for: .normal)
        }
    }
    
    func handInputBtnClicked() {
        let vc = InputISBNViewController()
        self.pushViewController(viewContoller: vc, animated: true)
    }
    
    override func leftNavBarButtonClicked() {
        
        self.popViewController(animated: true)
        
    }
    
    override func rightNavBarButtonClicked() {
        
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
