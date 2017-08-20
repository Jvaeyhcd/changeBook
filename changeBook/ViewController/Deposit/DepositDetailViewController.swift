//
//  DepositDetailViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 09/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class DepositDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var viewModel = UserViewModel()
    private var accountLogs = [AccountLog]()
    
    private var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: .zero, style: .plain)
        tableView.register(AccountLogTableViewCell.self, forCellReuseIdentifier: kCellIdAccountLogTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubvewis()
        userAccountLog()
    }
    
    private func initSubvewis() {
        self.title = "押金明细"
        self.showBackButton()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    private func userAccountLog() {
        self.viewModel.userAccountLog(success: { [weak self] (data) in
            self?.accountLogs = AccountLog.fromJSONArray(json: data.arrayObject!)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accountLogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdAccountLogTableViewCell, for: indexPath) as! AccountLogTableViewCell
        let accountLog = self.accountLogs[indexPath.row]
        cell.setAccountLog(accountLog: accountLog)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AccountLogTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
