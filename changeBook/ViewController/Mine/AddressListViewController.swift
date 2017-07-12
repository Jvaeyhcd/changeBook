//
//  AddressListViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 07/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class AddressListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
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

    private func initSubviews() {
        self.title = "收货地址"
        self.showBackButton()
        
        self.view.addSubview(self.addBtn)
        self.addBtn.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 50))
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
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdAddressListTableViewCell, for: indexPath) as! AddressListTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AddressListTableViewCell.cellHeight()
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
