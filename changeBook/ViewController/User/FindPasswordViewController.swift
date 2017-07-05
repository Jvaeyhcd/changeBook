//
//  FindPasswordViewController.swift
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

class FindPasswordViewController: UIViewController {
    
    // 找回密码的类型
    enum FindPasswordType {
        // 重置密码
        case reset
        // 忘记密码
        case forget
    }
    
    var type: FindPasswordType = .forget
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = kBarButtonItemTitleFont
        textField.textColor = UIColor(hex: 0x555555)
        textField.keyboardType = .numberPad
        textField.textAlignment = .left
        textField.placeholder = "请输入注册手机号"
        return textField
    }()
    
    private lazy var verificationCodeTF: UITextField = {
        let textField = UITextField()
        textField.font = kBarButtonItemTitleFont
        textField.textColor = UIColor(hex: 0x555555)
        textField.keyboardType = .numberPad
        textField.textAlignment = .left
        textField.placeholder = "请输入验证码"
        return textField
    }()
    
    private lazy var verificationCodeBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = kBaseFont
        btn.setTitleColor(UIColor.init(hex: 0x79C505), for: UIControlState.normal)
        btn.setTitleColor(kBtnDisableBgColor, for: UIControlState.disabled)
        btn.backgroundColor = kMainBgColor
        btn.contentHorizontalAlignment = .right
        btn.setTitle("获取验证码", for: UIControlState.normal)
        btn.sizeToFit()
        return btn
    }()
    private lazy var passwordTextField: UITextField = {
        
        let textField = UITextField()
        textField.font = kBarButtonItemTitleFont
        textField.textColor = UIColor(hex: 0x555555)
        textField.isSecureTextEntry = true
        textField.textAlignment = .left
        textField.placeholder = "请设置新密码，6~20位"
        
        return textField
    }()
    private lazy var repetPassTextField: UITextField = {
        let textField = UITextField()
        textField.font = kBarButtonItemTitleFont
        textField.textColor = UIColor(hex: 0x555555)
        textField.isSecureTextEntry = true
        textField.textAlignment = .left
        textField.placeholder = "请设置新密码，6~20位"
        
        return textField
    }()
    
    private lazy var resetPassworBtn: UIButton = {
        
        let size = CGSize(width: kScreenWidth - scaleFromiPhone6Desgin(x: 60),
                          height: scaleFromiPhone6Desgin(x: 52))
        
        let btn = UIButton()
        btn.setTitle("确认提交", for: UIControlState.normal)
        btn.titleLabel?.font = kBarButtonItemTitleFont
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.setBackgroundImage(UIImage.init(color: kBtnNormalBgColor!, size: size), for: .normal)
        btn.setBackgroundImage(UIImage.init(color: kBtnTouchInBgColor!, size: size), for: .selected)
        btn.setBackgroundImage(UIImage.init(color: kBtnDisableBgColor!, size: size), for: .disabled)
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        return btn
    }()
    
    //用NSTimer实现倒计时
    var countdownTimer: Timer?
    
    //开启和关闭倒计时的变量
    var isCounting = false{
        willSet{
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1,
                                                      target: self,
                                                      selector: #selector(updateTime(timer:)),
                                                      userInfo: nil,
                                                      repeats: true)
                
                verificationCodeBtn.backgroundColor = kMainBgColor
                verificationCodeBtn.layer.borderColor = kDisableColor?.cgColor
                
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                verificationCodeBtn.layer.borderColor = UIColor.init(hex: 0x79C505)?.cgColor
                verificationCodeBtn.backgroundColor = kMainBgColor
                verificationCodeBtn.setTitle("获取验证码", for: UIControlState.normal)
            }
            
            verificationCodeBtn.isEnabled = !newValue
        }
    }
    
    //当前倒计时剩余的秒数
    var remainingSeconds: Int = 0{
        willSet{
            verificationCodeBtn.setTitle("\(newValue)秒后重试", for: .normal)
            if newValue <= 0{
                verificationCodeBtn.setTitle("获取验证码", for: .normal)
                isCounting = false
            }
        }
    }
    
    lazy var viewModel = ResetPasswordViewModel(provider: UserAPIProvider)
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        bindToRx()
    }
    
    private func initSubviews() {
        
        if self.type == .forget {
            self.title = "找回密码"
        } else if self.type == .reset {
            self.title = "忘记密码"
        }
        
        self.view.backgroundColor = kMainBgColor
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(backgroundViewClicked))
        self.view.addGestureRecognizer(tapGesture)
        
        let item = UIBarButtonItem(image: UIImage(named: "top_btn_back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftNavBarButtonClicked))
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
        
        self.verificationCodeTF.addTarget(self, action: #selector(textfieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        self.view.addSubview(self.verificationCodeTF)
        self.verificationCodeTF.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 54))
            make.top.equalTo(userNameTextField.snp.bottom).offset(scaleFromiPhone6Desgin(x: 6))
        }
        self.verificationCodeTF.rx.text.orEmpty.bindTo(viewModel.vcode).addDisposableTo(disposeBag)
        
        let verificationCodeTFLine = UIView()
        verificationCodeTFLine.backgroundColor = UIColor(hex: 0xDDDDDD)
        self.view.addSubview(verificationCodeTFLine)
        verificationCodeTFLine.snp.makeConstraints { (make) in
            make.left.equalTo(verificationCodeTF.snp.left)
            make.right.equalTo(verificationCodeTF.snp.right)
            make.height.equalTo(0.5)
            make.bottom.equalTo(verificationCodeTF.snp.bottom)
        }
        
        self.view.addSubview(self.verificationCodeBtn)
        self.verificationCodeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(verificationCodeTF.snp.right)
            make.centerY.equalTo(verificationCodeTF.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.checkCountTime()
        verificationCodeBtn.rx.tap.bindTo(viewModel.vcodeTaps).addDisposableTo(disposeBag)
        viewModel.getVcodeEnabled
            .drive(onNext: { [weak self] enabled in
                self?.verificationCodeBtn.isEnabled = enabled && !(self?.isCounting)!
                if (self?.verificationCodeBtn.isEnabled)! {
                    self?.verificationCodeBtn.layer.borderColor = kMainColor?.cgColor
                } else {
                    self?.verificationCodeBtn.layer.borderColor = kDisableColor?.cgColor
                }
            })
            .addDisposableTo(disposeBag)
        
        self.passwordTextField.addTarget(self, action: #selector(textfieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        self.view.addSubview(self.passwordTextField)
        self.passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 54))
            make.top.equalTo(verificationCodeTF.snp.bottom).offset(scaleFromiPhone6Desgin(x: 6))
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
        
        self.repetPassTextField.addTarget(self, action: #selector(textfieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        self.view.addSubview(self.repetPassTextField)
        self.repetPassTextField.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 54))
            make.top.equalTo(passwordTextField.snp.bottom).offset(scaleFromiPhone6Desgin(x: 6))
        }
        
        self.repetPassTextField.rx.text.orEmpty.bindTo(viewModel.repeatPassword).addDisposableTo(disposeBag)
        
        let repetPassTextFieldLine = UIView()
        repetPassTextFieldLine.backgroundColor = UIColor(hex: 0xDDDDDD)
        self.view.addSubview(repetPassTextFieldLine)
        repetPassTextFieldLine.snp.makeConstraints { (make) in
            make.left.equalTo(repetPassTextField.snp.left)
            make.right.equalTo(repetPassTextField.snp.right)
            make.height.equalTo(0.5)
            make.bottom.equalTo(repetPassTextField.snp.bottom)
        }
        
        self.view.addSubview(resetPassworBtn)
        resetPassworBtn.snp.makeConstraints{
            make -> Void in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 52))
            make.top.equalTo(repetPassTextField.snp.bottom).offset(scaleFromiPhone6Desgin(x: 26))
        }
        
        resetPassworBtn.rx.tap.bindTo(viewModel.changedTaps).addDisposableTo(disposeBag)
        viewModel.changedEnabled
            .drive(onNext: { enabled in
                self.resetPassworBtn.isEnabled = enabled
                if enabled == true {
                    self.resetPassworBtn.setTitle("确认提交", for: UIControlState.normal)
                }
            })
            .addDisposableTo(disposeBag)
        
        viewModel.samePassword
            .drive(onNext: { same in
                if true == same {
                    self.resetPassworBtn.setTitle("确认提交", for: UIControlState.normal)
                } else {
                    self.resetPassworBtn.setTitle("两次密码不一致", for: UIControlState.normal)
                }
            })
            .addDisposableTo(disposeBag)
        
        viewModel.passwordEnabled
            .drive(onNext: { enabled in
                if false == enabled {
                    self.resetPassworBtn.setTitle("密码长度不够", for: UIControlState.normal)
                }
            }).addDisposableTo(disposeBag)
        
    }
    
    private func bindToRx() {
        viewModel.changedExecuting
            .drive(onNext: { [weak self] executing in
                UIApplication.shared.isNetworkActivityIndicatorVisible = executing
                if executing {
                    self?.showHudLoadingTipStr("")
                } else {
                    self?.hideHud()
                }
            })
            .addDisposableTo(disposeBag)
        
        viewModel.getVcodeExecuting
            .drive(onNext: { [weak self] executing in
                UIApplication.shared.isNetworkActivityIndicatorVisible = executing
                if executing {
                    self?.showHudLoadingTipStr("")
                } else {
                    self?.hideHud()
                }
            })
            .addDisposableTo(disposeBag)
        
        viewModel.changedFinished
            .drive(onNext: { [weak self] loginResult in
                
                self?.hideHud()
                
                switch loginResult {
                case .Failed(let message):
                    self?.showHudTipStr(message, in: self?.view)
                case .Scuccess:
                    self?.showHudTipStr("修改成功", in: UIApplication.shared.keyWindow)
                    
                    self?.popViewController(animated: true)
                }
            })
            .addDisposableTo(disposeBag)
        
        viewModel.getVcodeFinished
            .drive(onNext: { [weak self] requestResult in
                
                self?.hideHud()
                
                switch requestResult {
                case .Failed(let message):
                    self?.showHudTipStr(message, in: self?.view)
                case .Scuccess:
                    
                    self?.showHudTipStr("验证码发送成功，请注意查收", in: self?.view)
                    
                    // 得到发送验证码成功的时间
                    let date = NSDate().timeIntervalSince1970
                    kUserDefaults.set(date, forKey: "lastSendResetCodeDateTime")
                    kUserDefaults.synchronize()
                    
                    self!.remainingSeconds = 60
                    self!.isCounting = true
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    // 检测倒计时
    private func checkCountTime() {
        // 判断是否在倒计时
        let lastSendRegisterCodeDateTime = Int64(kUserDefaults.double(forKey: "lastSendRegisterCodeDateTime"))
        let nowTime = Int64(NSDate().timeIntervalSince1970)
        
        if nowTime - lastSendRegisterCodeDateTime > Int64(60) {
            isCounting = false
        } else {
            remainingSeconds = Int(Int64(60) - (nowTime - lastSendRegisterCodeDateTime))
            isCounting = true
        }
    }
    
    func updateTime(timer: Timer) -> Void {
        //计时开始时，逐秒减少remainingSeconds的值
        remainingSeconds -= 1
    }
    
    func textfieldDidChange(textField: UITextField) {
        var maxLength = 0
        switch textField {
        case userNameTextField:
            maxLength = 11
        case passwordTextField:
            maxLength = 20
        case verificationCodeTF:
            maxLength = 6
        case repetPassTextField:
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
        self.verificationCodeTF.resignFirstResponder()
        self.repetPassTextField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
