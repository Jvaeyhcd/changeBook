//
//  UsersBrowListViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 01/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class UsersBrowListViewController: BaseTableViewController, UITableViewDataSource, UITableViewDelegate {

    
    var parentVC: UIViewController?
    var bookList: [Book] = [Book]()
    var user: User!
    
    private var viewModel: UserViewModel = UserViewModel()
    private var pageInfo: PageInfo = PageInfo()
    
    lazy var tableHeaderView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0,
                                                  y: 0,
                                                  width: kScreenWidth,
                                                  height: kHomeHeadViewHeight))
        view.backgroundColor = kMainBgColor
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = kMainColor
        
        tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.userBorrowBook(page: 1)
        }
        tableView.footerRefreshBlock = {
            [weak self] (Void) in
            if self?.pageInfo.nextPage == self?.pageInfo.currentPage {
                
            } else {
                self?.userBorrowBook(page: (self?.pageInfo.nextPage)!)
            }
        }
        tableView.setPullingHeader()
        tableView.setPullingFooter()
        tableView.tableHeaderView = self.tableHeaderView
        tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: kHomeHeadViewHeight,
                                                            left: 0,
                                                            bottom: 0,
                                                            right: 0)
        
        self.tableView.register(BookListTableViewCell.self, forCellReuseIdentifier: kCellIdBookListTableViewCell)
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
        
        self.userBorrowBook(page: 1)
    }
    
    // MARK: - private
    private func userBorrowBook(page: Int) {
        
        self.viewModel.userBorrowBook(userId: self.user.userId, page: page, cache: { [weak self] (data) in
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
        
        if self.pageInfo.currentPage == 1 {
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
            if self.pageInfo.currentPage == self.pageInfo.maxPage {
                self.tableView.mj_footer.state = .noMoreData
            } else {
                self.tableView.mj_footer.state = .idle
            }
        }
        
        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.contentOffset.y = self.tableViewOffsetY
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
        return DataListTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
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
