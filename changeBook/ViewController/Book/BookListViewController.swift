//
//  BookListViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 01/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class BookListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var parentVC: UIViewController?
    
    // 默认推荐
    var bookType = kBookFilterRecommend
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
        
        self.initSbuviews()
        self.filterBook(page: 1)
    }
    
    private func initSbuviews() {
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setPullingFooter()
        self.tableView.setPullingHeader()
        self.tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.filterBook(page: 1)
        }
        self.tableView.footerRefreshBlock = {
            [weak self] (Void) in
            if self?.pageInfo?.nextPage == self?.pageInfo?.currentPage {
                
            } else {
                self?.filterBook(page: (self?.pageInfo?.nextPage)!)
            }
        }
        self.tableView.reloadBlock = {
            [weak self] (Void) in
            self?.filterBook(page: 1)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.parentVC?.pushViewController(viewContoller: vc, animated: true)
        
    }
    
    // MARK: - Networking
    private func filterBook(page: Int) {
        self.viewModel.filterBook(type: self.bookType, page: page, cache: { [weak self] (data) in
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
