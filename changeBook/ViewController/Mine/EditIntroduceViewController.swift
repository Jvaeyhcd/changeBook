//
//  EditIntroduceViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 11/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class EditIntroduceViewController: BaseViewController, UITextViewDelegate {
    
    var changeIntroduceBlock: ((String)->())!
    
    private var viewModel: UserViewModel = UserViewModel()
    private var introduce: String = ""
    
    fileprivate var textView: UIPlaceHolderTextView = {
        let textView = UIPlaceHolderTextView.init()
        textView.backgroundColor = UIColor.clear
        textView.returnKeyType = .default
        textView.textColor = UIColor(hex: 0x555555)
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.placeholder = "请输入您的简介"
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        
        self.title = "个人简介"
        self.showBackButton()
        self.showBarButtonItem(position: RIGHT, withStr: "确定")
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints{
            make -> Void in
            make.left.right.equalTo(0)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 183))
            make.top.equalTo(0)
        }
        
        self.introduce = sharedGlobal.getSavedUser().introduce
        self.textView.text = self.introduce
        bottomView.addSubview(self.textView)
        self.textView.delegate = self
        self.textView.becomeFirstResponder()
        self.textView.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 12))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 12))
            make.top.equalTo(scaleFromiPhone6Desgin(x: 10))
            make.bottom.equalTo(bottomView.snp.bottom)
        }
    }
    
    private func editIntroduce(introduce: String) {
        
        self.showHudLoadingTipStr("")
        
        var user = sharedGlobal.getSavedUser()
        self.viewModel.changeUserInfo(headPic: "", nickName: user.nickName, sex: user.sex, introduce: introduce, success: { [weak self] (data) in
            
            self?.hideHud()
            
            user.introduce = introduce
            sharedGlobal.saveUser(user: user)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshUserInfo"), object: nil)
            
            if nil != self?.changeIntroduceBlock {
                self?.changeIntroduceBlock(introduce)
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
        
        if "" == self.textView.text{
            self.showHudTipStr("请输入昵称")
        } else {
            if self.introduce != self.textView.text{
                self.editIntroduce(introduce: self.textView.text)
            } else {
                self.popViewController(animated: true)
            }
        }
    }
    
    // MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        
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
