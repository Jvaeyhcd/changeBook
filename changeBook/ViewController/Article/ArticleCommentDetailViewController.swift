//
//  ArticleCommentDetailViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 26/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArticleCommentDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var articleId = ""
    var comment: Comment!
    private var viewModel: ArticleViewModel = ArticleViewModel()
    private var replyList = [Comment]()
    private var pageInfo = PageInfo()
    
    private lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: kCellIdCommentTableViewCell)
        tableView.register(CommentReplyTableViewCell.self, forCellReuseIdentifier: kCellIdCommentReplyTableViewCell)
        return tableView
    }()
    
    //底部view
    lazy var toolBarBottomView: InfomationToolBarView = {
        let bottomViewNew = InfomationToolBarView.init(frame: CGRect(x: 0, y: kScreenHeight - kTabBarHeight, width: kScreenWidth, height: kTabBarHeight))
        
        return bottomViewNew
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
        getCommentDetail(page: 1)
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initSubviews() {
        self.title = "评论详情"
        self.showBackButton()
        
        self.view.addSubview(self.toolBarBottomView)
        self.toolBarBottomView.addCommentBlock = {
            [weak self] (Void) in
            
            self?.addCommentReply()
            
        }
        self.toolBarBottomView.praiseBlock = {
            [weak self] (Void) in
            self?.praiseComment()
        }
        
        self.toolBarBottomView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(kTabBarHeight)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setPullingHeader()
        self.tableView.setPullingFooter()
        self.tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.getCommentDetail(page: 1)
        }
        self.tableView.footerRefreshBlock = {
            
            if self.pageInfo.nextPage == self.pageInfo.currentPage {
                
            } else {
                self.getCommentDetail(page: self.pageInfo.nextPage)
            }
            
        }
        self.tableView.reloadBlock = {
            [weak self] (Void) in
            self?.getCommentDetail(page: 1)
        }
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(self.toolBarBottomView.snp.top)
        }
    }
    
    private func addCommentReply() {
        if sharedGlobal.getToken().tokenExists {
            let replyView = HcdReplyView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            replyView.placeHolder = "我来说几句..."
            replyView.commitReplyBlock = { [weak self]
                (content, score) in
                
                self?.replayComment(content: content!)
                
            }
            replyView.showReply(in: UIApplication.shared.keyWindow)
        } else {
            self.showLoginViewController()
        }
    }
    
    // 评论点赞
    private func praiseComment() {
        
        if (INT_TRUE == self.comment.isLike) {
            return
        }
        
        
    }
    
    // 获取评论详情
    private func getCommentDetail(page: Int) {

        self.viewModel.getArticleCommentDetail(articleCommentId: self.comment.id, page: page, cache: { [weak self] (data) in
            self?.updateDatas(data: data)
        }, success: { [weak self] (data) in
            self?.updateDatas(data: data)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    // 评论文章的评论
    private func replayComment(content: String) {
        
        
    }
    
    // 回复别人的评论
    private func replayReplayComment(content: String, user: User) {
        
    }
    
    private func updateDatas(data: JSON) {
        if JSON.null == data {
            return
        }
        
        self.pageInfo = PageInfo.fromJSON(json: data["pageInfo"])
        self.comment = Comment.fromJSON(json: data["entities"]["commentOneLv"].object)
        
        let replies = Comment.fromJSONArray(json: data["entities"]["commentTwoLv"].arrayObject!)
        
        if self.pageInfo.currentPage == 1 {
            self.replyList.removeAll()
        }
        
        if replies.count > 0 {
            for reply in replies {
                self.replyList.append(reply)
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
        
        self.toolBarBottomView.setPraiseNumber(number: self.comment.likeNum)
        self.toolBarBottomView.setReplyNumber(number: self.comment.commentNum)
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 == section {
            return 1
        }
        return self.replyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if 0 == indexPath.section {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdCommentTableViewCell, for: indexPath) as! CommentTableViewCell
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
            cell.setComment(comment: self.comment)
            cell.userBlock = {
                [weak self] (user) in
                let vc = OthersHomeViewController()
                vc.user = user
                self?.pushViewController(viewContoller: vc, animated: true)
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdCommentReplyTableViewCell, for: indexPath) as! CommentReplyTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        let reply = self.replyList[indexPath.row]
        cell.setReplyComment(comment: reply)
        cell.userBlock = {
            [weak self] (user) in
            let vc = OthersHomeViewController()
            vc.user = user
            self?.pushViewController(viewContoller: vc, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if 0 == indexPath.section {
            return CommentTableViewCell.cellHeightWithComment(comment: self.comment)
        }
        
        let reply = self.replyList[indexPath.row]
        return CommentReplyTableViewCell.cellHeightWithComment(comment: reply)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
