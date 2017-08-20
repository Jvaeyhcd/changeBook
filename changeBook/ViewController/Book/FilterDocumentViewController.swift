//
//  FilterDocumentViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 17/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

let sortTableViewTag = 101
let filterTableViewTag = 102
let documentTableViewTag = 103

class FilterDocumentViewController: BaseViewController, HcdTabBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let cates = ["推荐", "理工", "社科", "排序", "筛选"]
    let sortRules = ["查看最多", "购买最多", "打印最多", "评价最多", "最新发布"]
    let filterRules = ["PDF", "PPT/PPTX", "DOC/DOCX", "XLS/XLSX", "TXT", "图片"]
    private var type = 1
    private var rule = 1
    private var viewModel: DocumentViewModel = DocumentViewModel()
    private var pageInfo: PageInfo = PageInfo()
    private var doucumentList = [Document]()
    
    var sortTableViewHeight = CGFloat(0)
    var filterTableViewHeight = CGFloat(0)
    
    private lazy var tabBar: SlippedSegmentView = {
        
        let tabBar = SlippedSegmentView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: kSegmentBarHeight))
        tabBar.backgroundColor = UIColor.white
        tabBar.showSelectedBgView(show: false)
        return tabBar
        
    }()
    
    
    private lazy var sortTableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(SingleTableViewCell.self, forCellReuseIdentifier: kCellIdSingleTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.tag = sortTableViewTag
        return tableView
    }()
    
    
    private lazy var filterTableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(SingleTableViewCell.self, forCellReuseIdentifier: kCellIdSingleTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.tag = filterTableViewTag
        return tableView
    }()
    
    private lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(DataListTableViewCell.self, forCellReuseIdentifier: kCellIdDataListTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        tableView.tag = documentTableViewTag
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        filterDocument(page: 1)
    }

    private func initSubviews() {
        
        self.title = "资料"
        self.showBackButton()
        self.showBarButtonItem(position: RIGHT, withImage: UIImage(named: "jieshu_btn_sousuo")!)
        
        self.tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.filterDocument(page: 1)
        }
        self.tableView.footerRefreshBlock = {
            [weak self] (Void) in
            if self?.pageInfo.currentPage == self?.pageInfo.maxPage {
                
            } else {
                self?.filterDocument(page: (self?.pageInfo.nextPage)!)
            }
        }
        self.tableView.setPullingFooter()
        self.tableView.setPullingHeader()
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(kSegmentBarHeight + 1)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
        
        self.sortTableView.tag = sortTableViewTag
        sortTableViewHeight = CGFloat(self.sortRules.count) * SingleTableViewCell.cellHeight()
        self.sortTableView.frame = CGRect(x: CGFloat(0), y: kSegmentBarHeight - sortTableViewHeight, width: kScreenWidth, height: sortTableViewHeight)
        self.sortTableView.delegate = self
        self.sortTableView.dataSource = self
        self.view.addSubview(self.sortTableView)
        
        self.filterTableView.tag = filterTableViewTag
        filterTableViewHeight = CGFloat(self.filterRules.count) * SingleTableViewCell.cellHeight()
        self.filterTableView.frame = CGRect(x: CGFloat(0), y: kSegmentBarHeight - filterTableViewHeight, width: kScreenWidth, height: filterTableViewHeight)
        self.filterTableView.delegate = self
        self.filterTableView.dataSource = self
        self.view.addSubview(self.filterTableView)
        
        self.tabBar.delegate = self
        self.view.addSubview(self.tabBar)
        
        self.tabBar.setItemFontChangeFollowContentScroll(itemFontChangeFollowContentScroll: true)
        self.tabBar.setItemColorChangeFollowContentScroll(itemColorChangeFollowContentScroll: true)
        self.tabBar.showSelectedBgView(show: true)
        self.tabBar.setItemTitleFont(itemTitleFont: kBaseFont)
        self.tabBar.setItemTitleSelectedFont(itemTitleSelectedFont: kBaseFont)
        self.tabBar.setItemTitleSelectedColor(itemTitleSelectedColor: kMainColor!)
        self.tabBar.setItemSelectedBgImageViewColor(itemSelectedBgImageViewColor: kMainColor!)
        self.tabBar.setItemWidth(itemWidth: kScreenWidth / 5)
        let padding = scaleFromiPhone6Desgin(x: 10)
        self.tabBar.setItemSelectedBgInsets(itemSelectedBgInsets: UIEdgeInsetsMake(kSegmentBarHeight - 2, padding, 0, padding))
        self.tabBar.setFramePadding(top: 0, left: 0, bottom: 0, right: 0)
        
        self.tabBar.setTitles(titles: self.cates)
        self.tabBar.setSelectedItemIndex(selectedItemIndex: 0)
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        let vc = SearchDocumentViewController()
        self.pushViewController(viewContoller: vc, animated: true)
    }
    
    // MARK: - HcdTabBarDelegate
    func tabBar(tabBar: SlippedSegmentView, willSelectItemAtIndex: Int) -> Bool {
        return true
    }
    
    func tabBar(tabBar: SlippedSegmentView, didSelectedItemAtIndex: Int) {
        
        var rule = 1
        var type = 1
        if didSelectedItemAtIndex == 0 {
            rule = 1
            type = 1
            self.hideRulesTable()
        } else if didSelectedItemAtIndex == 1 {
            rule = 2
            type = 1
            self.hideRulesTable()
        } else if didSelectedItemAtIndex == 2 {
            rule = 2
            type = 2
            self.hideRulesTable()
        } else if didSelectedItemAtIndex == 3 {
            type = 3
            self.showSortTableView(show: true)
            return
        } else if didSelectedItemAtIndex == 4 {
            type = 4
            self.showFilterTableView(show: true)
            return
        }
        
        if self.rule != rule || self.type != type {
            self.rule = rule
            self.type = type
            self.filterDocument(page: 1)
        }
        
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == sortTableViewTag {
            return self.sortRules.count
        } else if tableView.tag == filterTableViewTag {
            return self.filterRules.count
        } else {
            return self.doucumentList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == sortTableViewTag {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSingleTableViewCell, for: indexPath) as! SingleTableViewCell
            cell.titleLbl.text = self.sortRules[indexPath.row]
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
            return cell
        } else if tableView.tag == filterTableViewTag {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSingleTableViewCell, for: indexPath) as! SingleTableViewCell
            cell.titleLbl.text = self.filterRules[indexPath.row]
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdDataListTableViewCell, for: indexPath) as! DataListTableViewCell
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
            
            let document = self.doucumentList[indexPath.row]
            cell.setDocument(document: document)
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == sortTableViewTag {
            return SingleTableViewCell.cellHeight()
        } else if tableView.tag == filterTableViewTag {
            return SingleTableViewCell.cellHeight()
        } else {
            return DataListTableViewCell.cellHeight()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.tag == sortTableViewTag {
            self.hideRulesTable()
            self.type = 3
            self.rule = indexPath.row + 1
            self.filterDocument(page: 1)
        } else if tableView.tag == filterTableViewTag {
            self.hideRulesTable()
            self.type = 4
            self.rule = indexPath.row + 1
            self.filterDocument(page: 1)
        } else {
            let document = self.doucumentList[indexPath.row]
            let vc = DataDetailViewController()
            vc.document = document
            self.pushViewController(viewContoller: vc, animated: true)
        }
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
    
    // MARK: - private
    func showSortTableView(show: Bool) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.sortTableView.frame = CGRect(x: CGFloat(0), y: kSegmentBarHeight, width: kScreenWidth, height: self.sortTableViewHeight)
            self.filterTableView.frame = CGRect(x: CGFloat(0), y: kSegmentBarHeight - self.filterTableViewHeight, width: kScreenWidth, height: self.filterTableViewHeight)
        }) { (complete) in
            self.sortTableView.frame = CGRect(x: CGFloat(0), y: kSegmentBarHeight, width: kScreenWidth, height: self.sortTableViewHeight)
            self.filterTableView.frame = CGRect(x: CGFloat(0), y: kSegmentBarHeight - self.filterTableViewHeight, width: kScreenWidth, height: self.filterTableViewHeight)
            self.sortTableView.reloadData()
        }
    }
    
    func showFilterTableView(show: Bool) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.sortTableView.frame = CGRect(x: CGFloat(0), y: kSegmentBarHeight - self.sortTableViewHeight, width: kScreenWidth, height: self.sortTableViewHeight)
            self.filterTableView.frame = CGRect(x: CGFloat(0), y: kSegmentBarHeight, width: kScreenWidth, height: self.filterTableViewHeight)
        }) { (complete) in
            self.sortTableView.frame = CGRect(x: CGFloat(0), y: kSegmentBarHeight - self.sortTableViewHeight, width: kScreenWidth, height: self.sortTableViewHeight)
            self.filterTableView.frame = CGRect(x: CGFloat(0), y: kSegmentBarHeight, width: kScreenWidth, height: self.filterTableViewHeight)
            self.filterTableView.reloadData()
        }
    }
    
    func hideRulesTable() {
        UIView.animate(withDuration: 0.5, animations: {
            self.sortTableView.frame = CGRect(x: CGFloat(0), y: kSegmentBarHeight - self.sortTableViewHeight, width: kScreenWidth, height: self.sortTableViewHeight)
            self.filterTableView.frame = CGRect(x: CGFloat(0), y: kSegmentBarHeight - self.filterTableViewHeight, width: kScreenWidth, height: self.filterTableViewHeight)
        }) { (complete) in
            self.sortTableView.frame = CGRect(x: CGFloat(0), y: kSegmentBarHeight - self.sortTableViewHeight, width: kScreenWidth, height: self.sortTableViewHeight)
            self.filterTableView.frame = CGRect(x: CGFloat(0), y: kSegmentBarHeight - self.filterTableViewHeight, width: kScreenWidth, height: self.filterTableViewHeight)
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
