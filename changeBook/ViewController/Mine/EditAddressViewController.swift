//
//  EditAddressViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 12/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class EditAddressViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // 找回密码的类型
    enum EditAddressType {
        // 重置密码
        case addNew
        // 忘记密码
        case edit
    }
    
    var type: EditAddressType = .addNew
    var address: Address = Address()
    private var viewModel: UserViewModel = UserViewModel()
    
    
    private var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(AddressInfoTableViewCell.self, forCellReuseIdentifier: kCellIdAddressInfoTableViewCell)
        tableView.backgroundColor = kMainBgColor
        tableView.separatorStyle = .none
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        intiSubviews()
    }
    
    private func intiSubviews() {
        self.title = "编辑地址"
        self.showBackButton()
        self.showBarButtonItem(position: RIGHT, withStr: "确定")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        if self.type == .addNew {
            self.addAddress(address: self.address)
        } else if self.type == .edit {
            self.editAddress(address: self.address)
        }
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdAddressInfoTableViewCell, for: indexPath) as! AddressInfoTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        
        if 0 == indexPath.row {
            cell.lbTitle.text = "联系人"
            cell.inputText.placeholder = "请输入联系人姓名"
            cell.inputText.keyboardType = .default
            cell.inputText.text = self.address.userName
        } else if 1 == indexPath.row {
            cell.lbTitle.text = "联系电话"
            cell.inputText.placeholder = "请输入联系人电话"
            cell.inputText.keyboardType = .numberPad
            cell.inputText.text = self.address.phone
        } else if 2 == indexPath.row {
            cell.lbTitle.text = "联系地址"
            cell.inputText.placeholder = "请输入联系人地址"
            cell.inputText.keyboardType = .default
            cell.inputText.text = self.address.addressDetail
        }
        
        cell.inputText.tag = indexPath.row
        cell.inputText.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
        return cell
    }
    
    func textFieldDidChange(textField: UITextField) {
        switch textField.tag {
        case 0:
            self.address.userName = textField.text!
            break
        case 1:
            self.address.phone = textField.text!
            break
        case 2:
            self.address.addressDetail = textField.text!
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AddressInfoTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addAddress(address: Address) {
        
        self.showHudLoadingTipStr("")
        
        self.viewModel.addAddress(userName: address.userName, phone: address.phone, addressDetail: address.addressDetail, isDefault: INT_TRUE, success: { [weak self] (data) in
            
            self?.showHudTipStr("添加成功")
            
            self?.popViewController(animated: true)
            
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func editAddress(address: Address) {
        
        self.showHudLoadingTipStr("")
        
        self.viewModel.editAddress(addressId: address.addressId, userName: address.userName, phone: address.phone, addressDetail: address.addressDetail, success: { [weak self] (data) in
            
            self?.showHudTipStr("修改成功")
            
            self?.popViewController(animated: true)
            
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) {
            
        }
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
