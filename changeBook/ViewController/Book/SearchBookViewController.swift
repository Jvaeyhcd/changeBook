//
//  SearchBookViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 23/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchBookViewController: BaseViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var keyWords: String = ""
    
    private var searchBar: UISearchBar!
    private var viewModel = BookViewModel()
    private var bookList = [Book]()
    private var pageInfo: PageInfo?
    
    lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(BookListTableViewCell.self, forCellReuseIdentifier: kCellIdBookListTableViewCell)
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
            self.searchBook(page: 1)
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
        
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setPullingFooter()
        self.tableView.setPullingHeader()
        self.tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.searchBook(page: 1)
        }
        self.tableView.footerRefreshBlock = {
            [weak self] (Void) in
            if self?.pageInfo?.nextPage == self?.pageInfo?.currentPage {
                
            } else {
                self?.searchBook(page: (self?.pageInfo?.nextPage)!)
            }
        }
        self.tableView.reloadBlock = {
            [weak self] (Void) in
            self?.searchBook(page: 1)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
        
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
        search.placeholder = "搜索书籍"
        search.backgroundImage = Bundle.py_imageNamed("bgImage")
        
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdBookListTableViewCell, for: indexPath) as! BookListTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        let book = self.bookList[indexPath.row]
        cell.setBook(book: book)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BookListTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let book = self.bookList[indexPath.row]
        
        // 跳转到书籍详情页面
        let vc = BookDetailViewController()
        vc.book = book
        self.pushViewController(viewContoller: vc, animated: true)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    // MARK: - Networking
    
    func searchBook(page: Int) {
        self.viewModel.searchBook(keyWords: self.keyWords, page: page, success: { [weak self] (data) in
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
        let books = Book.fromJSONArray(json: data["entities"].arrayObject!)
        
        if self.pageInfo?.currentPage == 1 {
            self.bookList.removeAll()
        }
        
        if books.count > 0 {
            for book in books {
                self.bookList.append(book)
            }
        }
        
        if nil != self.tableView.mj_header {
            self.tableView.mj_header.endRefreshing()
        }
        
        if nil != self.tableView.mj_footer {
            if self.pageInfo?.currentPage == self.pageInfo?.maxPage {
                self.tableView.mj_footer.state = .noMoreData
            } else {
                self.tableView.mj_footer.state = .idle
            }
        }
        
        self.tableView.reloadData()
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
        self.searchBook(page: 1)
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.keyWords = searchBar.text!
        self.searchBook(page: 1)
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
