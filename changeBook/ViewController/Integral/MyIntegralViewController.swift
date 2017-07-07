//
//  MyIntegralViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 28/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyIntegralViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate var viewModel: UserViewModel = UserViewModel()
    fileprivate var logList = [IntegralLog]()
    fileprivate var pageInfo: PageInfo = PageInfo()
    
    private lazy var integralLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.white
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.backgroundColor = kMainColor
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(IntegralLogTableViewCell.self, forCellReuseIdentifier: kCellIdIntegralLogTableViewCell)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        self.title = "我的积分"
        self.showBackButton()
        self.showBarButtonItem(position: RIGHT, withStr: "积分须知")
        
        self.integralLbl.text = sharedGlobal.getSavedUser().integral
        self.view.addSubview(self.integralLbl)
        self.integralLbl.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 120))
        }
        
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setPullingHeader()
        self.tableView.setPullingFooter()
        self.tableView.headerRefreshBlock = {
            self.getUserIntegralLog(page: 1)
        }
        self.tableView.footerRefreshBlock = {
            self.getUserIntegralLog(page: self.pageInfo.currentPage + 1)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.integralLbl.snp.bottom)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    private func getUserIntegralLog(page: Int) {
        self.viewModel.getUserIntegralLog(page: page, cache: { [weak self] (data) in
            self?.updateData(data: data)
        }, success: { [weak self] (data) in
            self?.updateData(data: data)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func updateData(data: JSON) {
        
        self.pageInfo = PageInfo.fromJSON(json: data["pageInfo"])
        let logs = IntegralLog.fromJSONArray(json: data["entities"].arrayObject!)
        
        if self.logList.count > 0 {
            for log in logs {
                self.logList.append(log)
            }
        } else {
            self.logList = logs
        }
        
        self.tableView.mj_header.endRefreshing()
        self.tableView.mj_footer.endRefreshing()
        
    }
    
    // MARK :- UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.logList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdIntegralLogTableViewCell, for: indexPath) as! IntegralLogTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IntegralLogTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return scaleFromiPhone6Desgin(x: 50)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: scaleFromiPhone6Desgin(x: 50)))
        headView.backgroundColor = kMainBgColor
        let lbl = UILabel.init(frame: CGRect(x: kBasePadding, y: 0, width: kScreenWidth - 2 * kBasePadding, height: scaleFromiPhone6Desgin(x: 50)))
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.textAlignment = .left
        lbl.text = "积分记录"
        headView.addSubview(lbl)
        return headView
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        
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
