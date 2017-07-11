//
//  EditNickNameViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 11/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class EditNickNameViewController: BaseViewController {
    
    var changeNickNameBlock: ((String)->())!
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入昵称"
        textField.textColor = UIColor.black
        textField.clearButtonMode = .whileEditing
        textField.textAlignment = .left
        return textField
    }()
    
    private var viewModel: UserViewModel = UserViewModel()
    private var nickName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        self.title = "修改昵称"
        self.showBackButton()
        self.showBarButtonItem(position: RIGHT, withStr: "确定")
        
        self.nickName = sharedGlobal.getSavedUser().nickName
        
        let topBottomView = UIView()
        topBottomView.backgroundColor = UIColor.white
        self.view.addSubview(topBottomView)
        topBottomView.snp.makeConstraints{
            make -> Void in
            make.top.equalTo(scaleFromiPhone6Desgin(x: 10))
            make.left.right.equalTo(0)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 50))
        }
        
        self.nameTextField.text = self.nickName
        self.view.addSubview(self.nameTextField)
        self.nameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 50))
            make.top.equalTo(scaleFromiPhone6Desgin(x: 10))
        }
    }
    
    private func editNickName(nickName: String) {
        
        self.showHudLoadingTipStr("")
        
        var user = sharedGlobal.getSavedUser()
        self.viewModel.changeUserInfo(headPic: "", nickName: nickName, sex: user.sex, introduce: user.introduce, success: { [weak self] (data) in
            
            self?.hideHud()
            
            user.nickName = nickName
            sharedGlobal.saveUser(user: user)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshUserInfo"), object: nil)
            
            if nil != self?.changeNickNameBlock {
                self?.changeNickNameBlock(nickName)
            }
            
            self?.popViewController(animated: true)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            self.hideHud()
        }
    }

    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        
        self.view.endEditing(true)
        
        if "" == self.nameTextField.text{
            self.showHudTipStr("请输入昵称")
        } else {
            if self.nickName != self.nameTextField.text{
                self.editNickName(nickName: self.nameTextField.text!)
            } else {
                self.popViewController(animated: true)
            }
        }
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
