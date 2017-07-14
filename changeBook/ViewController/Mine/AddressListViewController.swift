//
//  AddressListViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 07/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class AddressListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var viewModel: UserViewModel = UserViewModel()
    private var addressList = [Address]()
    
    private var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(AddressListTableViewCell.self, forCellReuseIdentifier: kCellIdAddressListTableViewCell)
        tableView.backgroundColor = kMainBgColor
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private var addBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("添加新地址", for: .normal)
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(UIColor(hex: 0xF85B5A), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAddressList()
    }

    private func initSubviews() {
        self.title = "收货地址"
        self.showBackButton()
        
        self.view.addSubview(self.addBtn)
        self.addBtn.addTarget(self, action: #selector(addBtnClicked), for: .touchUpInside)
        self.addBtn.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(kTabBarHeight)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(self.addBtn.snp.top)
            make.right.equalTo(0)
        }
    }
    
    @objc private func addBtnClicked() {
        let vc = EditAddressViewController()
        
        self.pushViewController(viewContoller: vc, animated: true)
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        
    }
    
    // MARK: - private
    private func getAddressList() {
        self.viewModel.getUserAddressList(cache: { [weak self] (data) in
            self?.updateDatas(data: data)
        }, success: { [weak self] (data) in
            self?.updateDatas(data: data)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func updateDatas(data: JSON) {
        if JSON.null != data {
            
            self.addressList = Address.fromJSONArray(json: data.arrayObject!)
            self.tableView.reloadData()
            
        }
    }
    
    private func setDefaultAddress(address: Address) {
        self.viewModel.setDefaultAddress(addressId: address.addressId, success: { [weak self] (data) in
            self?.showHudTipStr("设置成功")
            
            self?.getAddressList()
            
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func deleteAddress(address: Address) {
        
        self.showHudLoadingTipStr("")
        
        self.viewModel.deleteAddress(addressId: address.addressId, success: { [weak self] (data) in
            self?.showHudTipStr("删除成功")
            self?.getAddressList()
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func updateAddress(address: Address) {
        for i in 0 ..< self.addressList.count {
            let ad = self.addressList[i]
            if address.addressId == ad.addressId {
                self.addressList[i] = address
                break
            }
        }
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdAddressListTableViewCell, for: indexPath) as! AddressListTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        cell.selectionStyle = .none
        let address = self.addressList[indexPath.row]
        cell.setAddress(address: address)
        
        cell.defaultBtn.tag = indexPath.row
        cell.defaultBtn.addTarget(self, action: #selector(defaultBtnClicked), for: .touchUpInside)
        
        cell.editBtn.tag = indexPath.row
        cell.editBtn.addTarget(self, action: #selector(editBtnClicked), for: .touchUpInside)
        
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnClicked), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AddressListTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func defaultBtnClicked(button: UIButton) {
        let tag = button.tag
        let address = self.addressList[tag]
        self.setDefaultAddress(address: address)
    }
    
    func editBtnClicked(button: UIButton) {
        let tag = button.tag
        let address = self.addressList[tag]
        
        let vc = EditAddressViewController()
        vc.type = .edit
        vc.address = address
        self.pushViewController(viewContoller: vc, animated: true)
        
    }
    
    func deleteBtnClicked(button: UIButton) {
        let tag = button.tag
        let address = self.addressList[tag]
        self.deleteAddress(address: address)
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
