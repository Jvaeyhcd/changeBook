//
//  RegisterViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 03/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = kBarButtonItemTitleFont
        textField.textColor = UIColor(hex: 0x555555)
        textField.keyboardType = .numberPad
        textField.textAlignment = .left
        textField.placeholder = "请输入手机号"
        return textField
    }()
    
    lazy var verificationCodetf: UITextField = {
        let textField = UITextField()
        textField.font = kBarButtonItemTitleFont
        textField.textColor = UIColor(hex: 0x555555)
        textField.keyboardType = .numberPad
        textField.textAlignment = .left
        textField.placeholder = "请输入验证码"
        return textField
    }()
    
    lazy var verificationCodeBtn: UIButton = {
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
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = kBarButtonItemTitleFont
        textField.textColor = UIColor(hex: 0x555555)
        textField.isSecureTextEntry = true
        textField.textAlignment = .left
        textField.placeholder = "请设置密码，6~20位"
        return textField
    }()
    
    lazy var registerBtn: UIButton = {
        let size = CGSize(width: kScreenWidth - scaleFromiPhone6Desgin(x: 60),
                          height: scaleFromiPhone6Desgin(x: 52))
        let btn = UIButton()
        btn.setTitle("立即注册", for: UIControlState.normal)
        btn.titleLabel?.font = kBarButtonItemTitleFont
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.setBackgroundImage(UIImage.init(color: kBtnNormalBgColor!, size: size), for: .normal)
        btn.setBackgroundImage(UIImage.init(color: kBtnTouchInBgColor!, size: size), for: .selected)
        btn.setBackgroundImage(UIImage.init(color: kBtnDisableBgColor!, size: size), for: .disabled)
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        return btn
    }()
    
    lazy var agreementlb = UILabel()
    lazy var agreementBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        
        self.title = "注册账户"
        
        self.view.backgroundColor = kMainBgColor
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(backgroundViewClicked))
        self.view.addGestureRecognizer(tapGesture)
        
        let item = UIBarButtonItem(image: UIImage(named: "top_btn_back"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftNavBarButtonClicked))
        item.tintColor = UIColor(hex: 0x232323)
        self.navigationItem.leftBarButtonItem = item
        
        self.view.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints{
            make -> Void in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 54))
            make.top.equalTo(kNavHeight + scaleFromiPhone6Desgin(x: 24))
        }
        
        let userNameTextFieldBottomView = UIView()
        userNameTextFieldBottomView.backgroundColor = UIColor.init(hex: 0xdddddd)
        self.view.addSubview(userNameTextFieldBottomView)
        userNameTextFieldBottomView.snp.makeConstraints{
            make -> Void in
            make.left.equalTo(userNameTextField.snp.left)
            make.right.equalTo(userNameTextField.snp.right)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 0.5))
            make.bottom.equalTo(userNameTextField.snp.bottom)
        }
        
        
        self.view.addSubview(verificationCodetf)
        verificationCodetf.snp.makeConstraints{
            make -> Void in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 54))
            make.top.equalTo(userNameTextField.snp.bottom).offset(scaleFromiPhone6Desgin(x: 6))
        }
        
        let verificationCodetfBottomView = UIView()
        verificationCodetfBottomView.backgroundColor = UIColor.init(hex: 0xDDDDDD)
        self.view.addSubview(verificationCodetfBottomView)
        verificationCodetfBottomView.snp.makeConstraints{
            make -> Void in
            make.left.equalTo(verificationCodetf.snp.left)
            make.right.equalTo(verificationCodetf.snp.right)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 0.5))
            make.bottom.equalTo(verificationCodetf.snp.bottom)
        }
        
        
        self.view.addSubview(verificationCodeBtn)
        verificationCodeBtn.snp.makeConstraints{
            make -> Void in
            make.right.equalTo(verificationCodetf.snp.right)
            make.centerY.equalTo(verificationCodetf.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints{
            make -> Void in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 54))
            make.top.equalTo(verificationCodetf.snp.bottom).offset(scaleFromiPhone6Desgin(x: 6))
        }
        
        let passwordTextFieldLine = UIView()
        passwordTextFieldLine.backgroundColor = UIColor.init(hex: 0xDDDDDD)
        self.view.addSubview(passwordTextFieldLine)
        passwordTextFieldLine.snp.makeConstraints{
            make -> Void in
            make.left.equalTo(passwordTextField.snp.left)
            make.right.equalTo(passwordTextField.snp.right)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 0.5))
            make.bottom.equalTo(passwordTextField.snp.bottom)
        }
        
        self.view.addSubview(registerBtn)
        registerBtn.snp.makeConstraints{
            make -> Void in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 52))
            make.top.equalTo(passwordTextField.snp.bottom).offset(scaleFromiPhone6Desgin(x: 26))
        }
        
    }
    
    //view点击事件
    @objc private func backgroundViewClicked() {
        self.userNameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.verificationCodetf.resignFirstResponder()
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
