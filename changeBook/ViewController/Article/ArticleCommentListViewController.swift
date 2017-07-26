//
//  ArticleCommentListViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 26/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArticleCommentListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var articleId = ""
    private var viewModel: ArticleViewModel = ArticleViewModel()
    private var commentList = [Comment]()
    private var pageInfo = PageInfo()
    
    private lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(ArticleCommentTableViewCell.self, forCellReuseIdentifier: kCellIdArticleCommentTableViewCell)
        return tableView
    }()
    
    private lazy var addCommentView: AddCommentBottomView = {
        let view = AddCommentBottomView.init(frame: .zero)
        view.backgroundColor = kMainBgColor
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
        getBookComments(page: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initSubviews() {
        self.title = "全部评价"
        self.showBackButton()
        
        self.view.addSubview(self.addCommentView)
        self.addCommentView.addCommentBlock = {
            let replyView = HcdReplyView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            
            replyView.placeHolder = "我来评两句~"
            replyView.commitReplyBlock = { [weak self]
                (content, score) in
                
                self?.addBookComment(content: content!, score: score!)
                
            }
            replyView.showReply(in:UIApplication.shared.keyWindow)
        }
        self.addCommentView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(kTabBarHeight)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setPullingFooter()
        self.tableView.setPullingHeader()
        self.view.addSubview(self.tableView)
        self.tableView.headerRefreshBlock = {
            self.getBookComments(page: 1)
        }
        self.tableView.footerRefreshBlock = {
            
            if self.pageInfo.nextPage == self.pageInfo.currentPage {
                
            } else {
                self.getBookComments(page: self.pageInfo.nextPage)
            }
            
        }
        self.tableView.reloadBlock = {
            [weak self] (Void) in
            self?.getBookComments(page: 1)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(self.addCommentView.snp.top)
        }
        
    }
    
    // 获取资料评论
    private func getBookComments(page: Int) {

        self.viewModel.getArticleComment(articleId: self.articleId, page: page, cache: { [weak self] (data) in
            self?.updateCommentData(data: data)
        }, success: { [weak self] (data) in
            self?.updateCommentData(data: data)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) {
            
        }
    }
    
    private func updateCommentData(data: JSON) {
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
    
    private func addBookComment(content: String, score: String) {
        
        self.showHudLoadingTipStr("")
        
        self.viewModel.addArticleComment(articleId: self.articleId, content: content, commentType: kCommentLv1, score: score, articleCommentId: "0", receiverId: "0", success: { [weak self] (data) in
            self?.showHudTipStr("评价成功")
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
        return self.commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdArticleCommentTableViewCell, for: indexPath) as! ArticleCommentTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        let comment = self.commentList[indexPath.row]
        cell.setComment(comment: comment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let comment = self.commentList[indexPath.row]
        return ArticleCommentTableViewCell.cellHeightWithComment(comment: comment)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let comment = self.commentList[indexPath.row]
        let vc = ArticleCommentDetailViewController()
        vc.articleId = self.articleId
        vc.comment = comment
        self.pushViewController(viewContoller: vc, animated: true)
        
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
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