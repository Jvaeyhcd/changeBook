//
//  UsersCommentListViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 08/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class UsersCommentListViewController: BaseTableViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var parentVC: UIViewController?
    var commentList: [Comment] = [Comment]()
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
            self?.getUserComment(page: 1)
        }
        tableView.footerRefreshBlock = {
            [weak self] (Void) in
            if self?.pageInfo.nextPage == self?.pageInfo.currentPage {
                
            } else {
                self?.getUserComment(page: (self?.pageInfo.nextPage)!)
            }
        }
        tableView.setPullingHeader()
        tableView.setPullingFooter()
        tableView.tableHeaderView = self.tableHeaderView
        tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: kHomeHeadViewHeight,
                                                            left: 0,
                                                            bottom: 0,
                                                            right: 0)
        
        self.tableView.register(UsersCommentTableViewCell.self, forCellReuseIdentifier: kCellIdUsersCommentTableViewCell)
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
        
        self.getUserComment(page: 1)
    }
    
    // MARK: - private
    private func getUserComment(page: Int) {

        self.viewModel.getUserComment(userId: self.user.userId, page: page, cache: { [weak self] (data) in
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
        let comments = Comment.fromJSONArray(json: data["entities"].arrayObject!)
        
        if self.pageInfo.currentPage == 1 {
            self.commentList.removeAll()
        }
        
        if comments.count > 0 {
            for comment in comments {
                self.commentList.append(comment)
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
        return self.commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdUsersCommentTableViewCell, for: indexPath) as! UsersCommentTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        
        let comment = self.commentList[indexPath.row]
        cell.setComment(comment: comment)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let comment = self.commentList[indexPath.row]
        return UsersCommentTableViewCell.cellHeightWithComment(comment: comment)
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
