//
//  CommitISBNViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 20/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class CommitISBNViewController: BaseViewController {
    
    var ISBN = ""
    var tips = ""
    
    private lazy var ISBNTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = UIColor(hex: 0x555555)
        textField.placeholder = "请输入ISBN码"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = kMainColor?.cgColor
        return textField
    }()
    
    private lazy var tipsLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        lbl.textColor = UIColor(hex: 0x888888)
        return lbl
    }()
    
    private lazy var commitBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = kMainColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("立即提交", for: .normal)
        return btn
    }()
    
    fileprivate lazy var viewModel = BookViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }
    
    private func initSubviews() {
        self.title = "扫一扫"
        self.showBackButton()
        
        self.ISBNTextField.text = self.ISBN
        self.ISBNTextField.isEnabled = false
        self.view.addSubview(self.ISBNTextField)
        self.ISBNTextField.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.top.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 50))
        }
        
        self.tips = "很抱歉，没有为您找到ISBN码为" + self.ISBN + "的书籍，您可以向我们反馈， 我们将尽快收录    "
        let width = kScreenWidth - 2 * kBasePadding
        let height = self.tips.heightWithConstrainedWidth(width: width, font: UIFont.systemFont(ofSize: 14)) + 8
        self.view.addSubview(self.tipsLbl)
        self.tipsLbl.text = self.tips
        self.tipsLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(height)
            make.top.equalTo(self.ISBNTextField.snp.bottom).offset(kBasePadding)
        }
        
        self.commitBtn.addTarget(self, action: #selector(commitBtnClicked), for: .touchUpInside)
        self.view.addSubview(self.commitBtn)
        self.commitBtn.snp.makeConstraints { (make) in
            make.height.equalTo(scaleFromiPhone6Desgin(x: 50))
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.top.equalTo(self.tipsLbl.snp.bottom).offset(kBasePadding)
        }
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        
    }
    
    @objc private func commitBtnClicked() {
        
        self.ISBNTextField.resignFirstResponder()
        
        let ISBN = self.ISBNTextField.text
        if "" == ISBN || nil == ISBN {
            self.showHudTipStr("请输入ISBN码")
            return
        }
        self.addISBN(ISBN: ISBN!)
    }
    
    private func addISBN(ISBN: String) {
        
        self.showHudLoadingTipStr("")
        
        self.viewModel.addISBN(ISBN: ISBN, success: { [weak self] (data) in
            self?.showHudTipStr("提交成功，我们将尽快收录")
            }, fail: { [weak self] (message) in
                self?.showHudTipStr(message)
        }) {
            
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
