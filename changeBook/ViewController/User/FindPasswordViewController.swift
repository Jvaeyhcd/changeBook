//
//  FindPasswordViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 26/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

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
        btn.backgroundColor = UIColor.clear
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
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
        
        self.view.addSubview(self.userNameTextField)
        self.userNameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 54))
            make.top.equalTo(kNavHeight + scaleFromiPhone6Desgin(x: 24))
        }
        
        let userNameTextFieldLine = UIView()
        userNameTextFieldLine.backgroundColor = UIColor(hex: 0xDDDDDD)
        self.view.addSubview(userNameTextFieldLine)
        userNameTextFieldLine.snp.makeConstraints { (make) in
            make.left.equalTo(userNameTextField.snp.left)
            make.right.equalTo(userNameTextField.snp.right)
            make.height.equalTo(0.5)
            make.bottom.equalTo(userNameTextField.snp.bottom)
        }
        
        self.view.addSubview(self.verificationCodeTF)
        self.verificationCodeTF.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 54))
            make.top.equalTo(userNameTextField.snp.bottom).offset(scaleFromiPhone6Desgin(x: 6))
        }
        
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
        
        self.view.addSubview(self.passwordTextField)
        self.passwordTextField.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 54))
            make.top.equalTo(verificationCodeTF.snp.bottom).offset(scaleFromiPhone6Desgin(x: 6))
        }
        
        let passwordTextFieldLine = UIView()
        passwordTextFieldLine.backgroundColor = UIColor(hex: 0xDDDDDD)
        self.view.addSubview(passwordTextFieldLine)
        passwordTextFieldLine.snp.makeConstraints { (make) in
            make.left.equalTo(passwordTextField.snp.left)
            make.right.equalTo(passwordTextField.snp.right)
            make.height.equalTo(0.5)
            make.bottom.equalTo(passwordTextField.snp.bottom)
        }
        
        self.view.addSubview(self.repetPassTextField)
        self.repetPassTextField.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 54))
            make.top.equalTo(passwordTextField.snp.bottom).offset(scaleFromiPhone6Desgin(x: 6))
        }
        
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
