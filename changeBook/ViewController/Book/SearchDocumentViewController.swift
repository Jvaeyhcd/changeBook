//
//  SearchDocumentViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 13/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchDocumentViewController: BaseViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    var keyWords: String = ""
    private var searchBar: UISearchBar!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
        initSearchView()
        if "" != self.keyWords {
            self.searchBar.text = self.keyWords
            self.searchDocument(page: 1)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.searchBar.resignFirstResponder()
    }
    
    private func initSubviews() {
        self.showBackButton()
        self.showBarButtonItem(position: RIGHT, withStr: "搜索")
        
        self.tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.searchDocument(page: 1)
        }
        self.tableView.footerRefreshBlock = {
            [weak self] (Void) in
            if self?.pageInfo.currentPage == self?.pageInfo.maxPage {
                
            } else {
                self?.searchDocument(page: (self?.pageInfo.nextPage)!)
            }
        }
        self.tableView.setPullingFooter()
        self.tableView.setPullingHeader()
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(1)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
    }
    
    private func searchDocument(page: Int) {
        self.viewModel.searchDocument(keyWords: self.keyWords, page: page, success: { [weak self] (data) in
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
    
    private func initSearchView() {
        let titleView = UIView()
        titleView.py_x = CGFloat(PYSEARCH_MARGIN) * 0.5
        titleView.py_y = 7
        titleView.py_width = self.view.py_width - 64 - titleView.py_x * 2
        titleView.py_height = 30
        
        let search = UISearchBar.init(frame: titleView.bounds)
        titleView.addSubview(search)
        
        titleView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        self.navigationItem.titleView = titleView
        
        // close autoresizing
        search.translatesAutoresizingMaskIntoConstraints = false
        let widthCons: NSLayoutConstraint = NSLayoutConstraint.init(item: search, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: titleView, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0)
        let heightCons: NSLayoutConstraint = NSLayoutConstraint.init(item: search, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: titleView, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 0)
        let xCons: NSLayoutConstraint = NSLayoutConstraint.init(item: search, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: titleView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
        let yCons: NSLayoutConstraint = NSLayoutConstraint.init(item: search, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: titleView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0)
        
        titleView.addConstraint(widthCons)
        titleView.addConstraint(heightCons)
        titleView.addConstraint(xCons)
        titleView.addConstraint(yCons)
        
        self.searchBar = search
        self.searchBar.delegate = self
        
        search.barStyle = .default
        search.placeholder = "搜索资料"
        search.backgroundImage = Bundle.py_imageNamed("bgImage")
        
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        if "" == self.keyWords {
            self.showHudTipStr("请输入搜索内容")
            return
        }
        
        self.searchBar.resignFirstResponder()
        self.searchDocument(page: 1)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }

    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.keyWords = searchBar.text!
        self.searchDocument(page: 1)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.keyWords = searchText
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
