//
//  InputISBNViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 20/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class InputISBNViewController: BaseViewController {
    
    private lazy var ISBNTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = UIColor(hex: 0x555555)
        textField.placeholder = "请输入ISBN码"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = kMainColor?.cgColor
        textField.keyboardType = UIKeyboardType.asciiCapable
        return textField
    }()
    
    private lazy var commitBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = kMainColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitle("确定", for: .normal)
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
        
        self.view.addSubview(self.ISBNTextField)
        self.ISBNTextField.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.top.equalTo(scaleFromiPhone6Desgin(x: 60))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 50))
        }
        
        self.commitBtn.addTarget(self, action: #selector(commitBtnClicked), for: .touchUpInside)
        self.view.addSubview(self.commitBtn)
        self.commitBtn.snp.makeConstraints { (make) in
            make.height.equalTo(scaleFromiPhone6Desgin(x: 50))
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.top.equalTo(self.ISBNTextField.snp.bottom).offset(kBasePadding)
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
        self.getBookDetailByISBN(ISBN: ISBN!)
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
