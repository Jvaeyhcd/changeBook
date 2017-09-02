//
//  DonateViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 15/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class DonateViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var userName: String = ""
    private var phone: String = ""
    private var address: String = ""
    private var number: String = ""
    
    private lazy var tableView : UITableView = {
        let contentTableView = TPKeyboardAvoidingTableView.init()
        contentTableView.register(SimpleInputTableViewCell.self, forCellReuseIdentifier: kCellIdSimpleInputTableViewCell)
        contentTableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: kCellIdButtonTableViewCell)
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.separatorStyle = .none
        contentTableView.backgroundColor = kMainBgColor
        return contentTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initDatas()
        initSubviews()
    }
    
    private func initDatas() {
        if sharedGlobal.getSavedUser().nickName != "" {
            self.userName = sharedGlobal.getSavedUser().nickName
        }
        if false == sharedGlobal.getSavedUser().address.isEmpty {
            self.address = sharedGlobal.getSavedUser().address
        }
        if sharedGlobal.getSavedUser().userName.isPhoneNumber() {
            self.phone = sharedGlobal.getSavedUser().userName
        }

    }
    
    private func initSubviews() {
        self.title = "捐赠"
        self.showBackButton()
        
        self.showBarButtonItem(position: RIGHT, withStr: "捐赠记录")
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSimpleInputTableViewCell, for: indexPath) as! SimpleInputTableViewCell
            switch indexPath.row {
            case 0:
                cell.lbName.text = "姓名"
                cell.tfName.placeholder = "请输入捐赠人姓名"
                cell.tfName.text = self.userName
                cell.textChangedBlock = {
                    [weak self] (text) in
                    self?.userName = text
                }
            case 1:
                cell.lbName.text = "电话"
                cell.tfName.placeholder = "请输入捐赠人联系电话"
                cell.tfName.text = self.phone
                cell.textChangedBlock = {
                    [weak self] (text) in
                    self?.phone = text
                }
            case 2:
                cell.lbName.text = "地址"
                cell.tfName.placeholder = "请输入捐赠地址"
                cell.tfName.text = self.address
                cell.textChangedBlock = {
                    [weak self] (text) in
                    self?.address = text
                }
            case 3:
                cell.lbName.text = "捐赠数量"
                cell.tfName.placeholder = "请输入捐赠书籍数量"
                cell.tfName.text = self.number
                cell.textChangedBlock = {
                    [weak self] (text) in
                    self?.number = text
                }
            default:
                break
            }
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdButtonTableViewCell, for: indexPath) as! ButtonTableViewCell
            cell.btnSure.setTitle("提交", for: .normal)
            cell.selectionStyle = .none
            cell.backgroundColor = kMainBgColor
            cell.btnSure.addTarget(self, action: #selector(btnClick), for: UIControlEvents.touchUpInside)
            return cell
        }
    }
    
    //按钮点击事件
    @objc private func btnClick() {
        // 提交捐赠
        self.showHudTipStr("提交成功")
        self.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return SimpleInputTableViewCell.cellHeight()
        } else {
            return ButtonTableViewCell.cellHeight()
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
