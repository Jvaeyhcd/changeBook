//
//  LoginViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 26/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON
import Moya
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    lazy var userNameTextField: UITextField = {
        let textField = UITextField.init()
        textField.font = kBarButtonItemTitleFont
        textField.textColor = UIColor(hex: 0x555555)
        textField.keyboardType = .numberPad
        textField.textAlignment = .left
        textField.placeholder = "请输入手机号"
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField.init()
        textField.font = kBarButtonItemTitleFont
        textField.textColor = UIColor(hex: 0x555555)
        textField.isSecureTextEntry = true
        textField.textAlignment = .left
        textField.placeholder = "请输入密码"
        return textField
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(UIColor.white, for: .normal)
        
        let btnSize = CGSize(width: kScreenWidth - scaleFromiPhone6Desgin(x: 60), height: scaleFromiPhone6Desgin(x: 52))
        btn.setBackgroundImage(UIImage.init(color: kBtnNormalBgColor, size: btnSize), for: .normal)
        btn.setBackgroundImage(UIImage.init(color: kBtnTouchInBgColor, size: btnSize), for: .selected)
        btn.setBackgroundImage(UIImage.init(color: kBtnDisableBgColor, size: btnSize), for: .disabled)
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        
        return btn
    }()
    
    lazy var registerBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("用户注册", for: UIControlState.normal)
        btn.setTitleColor(kBlueColor, for: UIControlState.normal)
        btn.titleLabel?.font = kBaseFont
        btn.backgroundColor = UIColor.clear
        btn.contentHorizontalAlignment = .left
        btn.tag = 100
        
        return btn
    }()
    
    lazy var forgetpwdBtn: UIButton = {
        
        let btn = UIButton()
    
        btn.setTitle("忘记密码", for: UIControlState.normal)
        btn.setTitleColor(kBlueColor, for: UIControlState.normal)
        btn.titleLabel?.font = kBaseFont
        btn.backgroundColor = UIColor.clear
        btn.contentHorizontalAlignment = .right
        btn.tag = 101

        return btn
    }()
    
    lazy var thirdWXLoginBtn: UIButton = {
        
        let btn = UIButton()
        btn.setBackgroundImage(UIImage.init(named: "login_icon_wx"), for: UIControlState.normal)
        btn.layer.cornerRadius = scaleFromiPhone6Desgin(x: 24)
        btn.clipsToBounds = true
        btn.contentMode = .scaleAspectFill
        btn.tag = 200
        
        return btn
    }()
    lazy var thirdQQLoginBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage.init(named: "login_icon_qq"), for: UIControlState.normal)
        btn.layer.cornerRadius = scaleFromiPhone6Desgin(x: 24)
        btn.clipsToBounds = true
        btn.contentMode = .scaleAspectFill
        btn.tag = 201
        
        return btn
    }()
    
    private lazy var viewModel = LoginViewModel(provider: UserAPIProvider)
    private lazy var userViewModel = UserViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        bindToRx()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initSubviews() {
        
        self.title = "账号登录"
        
        self.view.backgroundColor = kMainBgColor
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(backgroundViewClicked))
        self.view.addGestureRecognizer(tapGesture)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18),NSForegroundColorAttributeName: UIColor.black]
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: 0xFFFFFF)
        let item = UIBarButtonItem(image: UIImage(named: "top_btn_close_black")!, style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftNavBarButtonClicked))
        item.tintColor = UIColor(hex: 0x232323)
        self.navigationItem.leftBarButtonItem = item
        
        self.userNameTextField.addTarget(self, action: #selector(textfieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        self.view.addSubview(self.userNameTextField)
        self.userNameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 54))
            make.top.equalTo(kNavHeight + scaleFromiPhone6Desgin(x: 24))
        }
        self.userNameTextField.rx.text.orEmpty.bindTo(viewModel.username).addDisposableTo(disposeBag)
        
        let userNameTextFieldLine = UIView()
        userNameTextFieldLine.backgroundColor = UIColor(hex: 0xDDDDDD)
        self.view.addSubview(userNameTextFieldLine)
        userNameTextFieldLine.snp.makeConstraints { (make) in
            make.left.equalTo(userNameTextField.snp.left)
            make.right.equalTo(userNameTextField.snp.right)
            make.height.equalTo(0.5)
            make.bottom.equalTo(userNameTextField.snp.bottom)
        }
        
        self.passwordTextField.addTarget(self, action: #selector(textfieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        self.view.addSubview(self.passwordTextField)
        self.passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 54))
            make.top.equalTo(userNameTextField.snp.bottom).offset(scaleFromiPhone6Desgin(x: 6))
        }
        self.passwordTextField.rx.text.orEmpty.bindTo(viewModel.password).addDisposableTo(disposeBag)
        
        let passwordTextFieldLine = UIView()
        passwordTextFieldLine.backgroundColor = UIColor(hex: 0xDDDDDD)
        self.view.addSubview(passwordTextFieldLine)
        passwordTextFieldLine.snp.makeConstraints { (make) in
            make.left.equalTo(passwordTextField.snp.left)
            make.right.equalTo(passwordTextField.snp.right)
            make.height.equalTo(0.5)
            make.bottom.equalTo(passwordTextField.snp.bottom)
        }
        
        self.view.addSubview(self.loginBtn)
        self.loginBtn.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 52))
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(scaleFromiPhone6Desgin(x: 26))
        }
        
        loginBtn.rx.tap.bindTo(viewModel.loginTaps).addDisposableTo(disposeBag)
        viewModel.loginEnabled.drive(loginBtn.rx.isEnabled).addDisposableTo(disposeBag)
        
        self.registerBtn.addTarget(self, action: #selector(btnClicked(btn:)), for: .touchUpInside)
        self.view.addSubview(self.registerBtn)
        self.registerBtn.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(loginBtn.snp.bottom).offset(scaleFromiPhone6Desgin(x: 25))
        }
        
        self.forgetpwdBtn.addTarget(self, action: #selector(btnClicked(btn:)), for: .touchUpInside)
        self.view.addSubview(self.forgetpwdBtn)
        self.forgetpwdBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(loginBtn.snp.bottom).offset(scaleFromiPhone6Desgin(x: 25))
        }
        
        let thirdLoginLine = UIView()
        thirdLoginLine.backgroundColor = UIColor(hex: 0xDDDDDD)
        self.view.addSubview(thirdLoginLine)
        thirdLoginLine.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 40))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 40))
            make.height.equalTo(0.5)
            make.bottom.equalTo(-scaleFromiPhone6Desgin(x: 147))
        }
        
        let thirdLoginlb = UILabel()
        thirdLoginlb.backgroundColor = kMainBgColor
        thirdLoginlb.textColor = kGaryColor
        thirdLoginlb.font = kBaseFont
        thirdLoginlb.textAlignment = .center
        thirdLoginlb.text = " 第三方账号登录 "
        thirdLoginlb.sizeToFit()
        self.view.addSubview(thirdLoginlb)
        thirdLoginlb.snp.makeConstraints{
            make -> Void in
            make.center.equalTo(thirdLoginLine.snp.center)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 28))
        }
        
//        self.thirdWXLoginBtn.addTarget(self, action: #selector(btnClicked(btn:)), for: .touchUpInside)
//        self.view.addSubview(self.thirdWXLoginBtn)
//        self.thirdWXLoginBtn.snp.makeConstraints{
//            make -> Void in
//            make.centerX.equalTo(kScreenWidth / 2 + scaleFromiPhone6Desgin(x: 24) + kBasePadding)
//            make.height.width.equalTo(scaleFromiPhone6Desgin(x: 48))
//            make.top.equalTo(thirdLoginlb.snp.bottom).offset(scaleFromiPhone6Desgin(x: 36))
//        }
        
        self.thirdQQLoginBtn.addTarget(self, action: #selector(btnClicked(btn:)), for: .touchUpInside)
        self.view.addSubview(self.thirdQQLoginBtn)
        self.thirdQQLoginBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(kScreenWidth / 2)
            make.height.width.equalTo(scaleFromiPhone6Desgin(x: 48))
            make.top.equalTo(thirdLoginlb.snp.bottom).offset(scaleFromiPhone6Desgin(x: 36))
        }
    }
    
    private func bindToRx() {
        
        
        viewModel.loginExecuting.drive(onNext: { [weak self] executing  in
            UIApplication.shared.isNetworkActivityIndicatorVisible = executing
            if executing {
                self?.view.endEditing(true)
                self?.showHudLoadingTipStr("")
            } else {
                self?.hideHud()
            }
        }).addDisposableTo(disposeBag)
        
        viewModel.loginFinished.drive(onNext: { [weak self] loginResult  in
            
            self?.hideHud()
            
            switch loginResult {
            case .Failed(let message):
                self?.showHudTipStr(message, in: self?.view)
            case .Scuccess:
                showedLogin = false
                
                //标记不是三方登录
                kUserDefaults.set(false, forKey: "thirdLoginSuccess")
                kUserDefaults.set(0, forKey: "ThirdLoginType")
                
                kUserDefaults.set(true, forKey: "canAutoLogin")
                kUserDefaults.synchronize()
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshUserInfo"), object: nil)
                
                self?.loginInEMChat(userName: (self?.userNameTextField.text!)!)
                
                
            }
            
        }).addDisposableTo(disposeBag)
        
    }
    
    // 登录环信
    func loginInEMChat(userName: String) {
        EMClient.shared().login(withUsername: userName, password: "123") { [weak self] (aUsername, aError) in
            if (nil != aError) {
                BLog(log: "登录失败")
                EMClient.shared().register(withUsername: userName, password: "123", completion: { [weak self] (userName, error) in
                    if (nil == error) {
                        BLog(log: "注册成功")
                        self?.loginInEMChat(userName: userName!)
                    }
                })
            } else {
                EMClient.shared().options.isAutoLogin = true
                
                self?.hideHud()
                self?.dismiss(animated: true, completion: nil)
                BLog(log: "登录成功")
            }
        }
    }
    
    func textfieldDidChange(textField: UITextField) {
        var maxLength = 0
        switch textField {
        case userNameTextField:
            maxLength = 11
        case passwordTextField:
            maxLength = 20
        default:
            maxLength = 0
        }
        let text = textField.text
        if text!.characters.count > maxLength {
            textField.text = text?.subStrToIndex(index: maxLength)
        }
    }
    
    //view点击事件
    @objc private func backgroundViewClicked() {
        self.userNameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    @objc private func btnClicked(btn: UIButton) {
        switch btn.tag {
        case 100:
            let vc = RegisterViewController()
            self.pushViewController(viewContoller: vc, animated: true)
            break
        case 101:
            let vc = FindPasswordViewController()
            vc.type = .forget
            self.pushViewController(viewContoller: vc, animated: true)
            break
        case 200:
            break
        case 201:
            self.getAuthWithUserInfoFromQQ()
            break
        default:
            break
        }
    }
    
    // 调起QQ登录
    private func getAuthWithUserInfoFromQQ() {
        UMSocialManager.default().getUserInfo(with: UMSocialPlatformType.QQ, currentViewController: self) { [weak self] (result, error) in
            if (nil != error) {
                
            } else {
                let resp: UMSocialUserInfoResponse = result as! UMSocialUserInfoResponse
                
                // 授权信息
                BLog(log: "QQ uid: " + resp.uid)
                BLog(log: "QQ openid: " + resp.openid)
                BLog(log: "QQ unionid: \(resp.unionId)")
                BLog(log: "QQ accessToken: \(resp.accessToken)")
                BLog(log: "QQ expiration: \(resp.expiration)")
                
                // 用户信息
                BLog(log: "QQ name: " + resp.name)
                BLog(log: "QQ iconurl: " + resp.iconurl)
                BLog(log: "QQ gender: " + resp.gender)
                
                // 第三方平台SDK源数据
                BLog(log: "QQ originalResponse: \(resp.originalResponse)")
                
                self?.loginWithQQAccount(openid: resp.openid, nickName: resp.name + "", headPic: resp.iconurl)
            }
        }
    }
    
    private func loginWithQQAccount(openid: String, nickName: String, headPic: String) {
        
        self.showHudLoadingTipStr("")
        
        self.userViewModel.qqLogin(openId: openid, nickName: nickName, headPic: headPic, success: { [weak self] (data) in
            
            let loginUser = User.fromJSON(json: data["user"])
            
            sharedGlobal.saveToken(token: data["token"].stringValue)
            sharedGlobal.saveUser(user: loginUser)
            
            showedLogin = false
            
            //标记是三方登录
            kUserDefaults.set(true, forKey: "thirdLoginSuccess")
            kUserDefaults.set(0, forKey: "ThirdLoginType")
            
            kUserDefaults.set(true, forKey: "canAutoLogin")
            kUserDefaults.synchronize()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshUserInfo"), object: nil)
            
            self?.loginInEMChat(userName: openid)
            
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    override func leftNavBarButtonClicked() {
        self.dismiss(animated: true, completion: nil)
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
