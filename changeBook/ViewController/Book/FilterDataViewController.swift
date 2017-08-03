//
//  FilterDataViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 03/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class FilterDataViewController: BaseViewController, DOPDropDownMenuDataSource, DOPDropDownMenuDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let filterType = [
        ["推荐"],
        ["理工", "社科"],
        ["查看最多", "购买最多", "打印最多", "评价最多", "最新发布"],
        ["pdf", "ppt", "doc", "excel", "txt", "pic"]
    ];
    
    private var type = 1
    private var rule = 1
    private var viewModel: DocumentViewModel = DocumentViewModel()
    private var pageInfo: PageInfo = PageInfo()
    private var doucumentList = [Document]()
    
    private lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(DataListTableViewCell.self, forCellReuseIdentifier: kCellIdDataListTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()
    
    private lazy var menu: DOPDropDownMenu = {
        let menu = DOPDropDownMenu.init(origin: CGPoint.init(x: 0, y: 0), andHeight: kSegmentBarHeight)
        return menu!
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        filterDocument(page: 1)
    }
    
    private func initSubviews() {
        self.title = "资料"
        self.showBackButton()
        
        self.menu.delegate = self
        self.menu.dataSource = self
        self.view.addSubview(self.menu)
        self.tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.filterDocument(page: 1)
        }
        self.tableView.setPullingFooter()
        self.tableView.setPullingHeader()
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.menu.snp.bottom).offset(1)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - DOPDropDownMenuDataSource, DOPDropDownMenuDelegate
    func numberOfColumns(in menu: DOPDropDownMenu!) -> Int {
        return filterType.count
    }
    
    func menu(_ menu: DOPDropDownMenu!, numberOfRowsInColumn column: Int) -> Int {
        return filterType[column].count
    }
    
    func menu(_ menu: DOPDropDownMenu!, titleForRowAt indexPath: DOPIndexPath!) -> String! {
        return filterType[indexPath.column][indexPath.row]
    }
    
    func menu(_ menu: DOPDropDownMenu!, numberOfItemsInRow row: Int, column: Int) -> Int {
        return 0
    }
    
    func menu(_ menu: DOPDropDownMenu!, titleForItemsInRowAt indexPath: DOPIndexPath!) -> String! {
        return ""
    }
    
    func menu(_ menu: DOPDropDownMenu!, didSelectRowAt indexPath: DOPIndexPath!) {
        
        self.type = indexPath.column + 1
        self.rule = indexPath.row + 1
        
        self.filterDocument(page: 1)
        
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.doucumentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdDataListTableViewCell, for: indexPath) as! DataListTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        
        let document = self.doucumentList[indexPath.row]
        cell.setDocument(document: document)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DataListTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let document = self.doucumentList[indexPath.row]
        let vc = DataDetailViewController()
        vc.document = document
        self.pushViewController(viewContoller: vc, animated: true)
    }
    
    // MARK: - Networking
    private func filterDocument(page: Int) {
        self.viewModel.filterDocument(type: self.type, rule: self.rule, page: page, cache: { [weak self] (data) in
            self?.updateDatas(data: data)
        }, success: { [weak self] (data) in
            self?.updateDatas(data: data)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func updateDatas(data: JSON) {
        if JSON.null == data {
            return
        }
        
        self.pageInfo = PageInfo.fromJSON(json: data["pageInfo"])
        let documents = Document.fromJSONArray(json: data["entities"].arrayObject!)
        
        if self.pageInfo.currentPage == 1 {
            self.doucumentList.removeAll()
        }
        
        if documents.count > 0 {
            for document in documents {
                self.doucumentList.append(document)
            }
        }
        
        if nil != self.tableView.mj_header {
            self.tableView.mj_header.endRefreshing()
        }
        
        if nil != self.tableView.mj_footer {
            if self.pageInfo.currentPage == self.pageInfo.maxPage {
                self.tableView.mj_footer.state = .noMoreData
            } else {
                self.tableView.mj_footer.state = .idle
            }
        }
        
        self.tableView.reloadData()
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
