//
//  ArticleDetailViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 25/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON
import HcdActionSheet

class ArticleDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var article: Article!
    var rewordList = [RewardLog]()
    var rewordNumber = 0
    private var viewModel: ArticleViewModel = ArticleViewModel()
    private var commentList = [Comment]()
    private var pageInfo = PageInfo()
    private let integralList = ["2", "5", "10", "20", "50"]
    
    fileprivate var webviewHight: CGFloat = CGFloat(0)
    
    private lazy var toobarView: ArticleToolBarView = {
        let view = ArticleToolBarView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kTabBarHeight))
        return view
    }()
    
    private var rewordActionSheet: HcdActionSheet = {
        let sheet = HcdActionSheet.init(cancelStr: "取消", otherButtonTitles: ["2积分", "5积分", "10积分", "20积分", "50积分"], attachTitle: "请选择您要打赏的积分")
        return sheet!
    }()
    
    private lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(ArticleDetailTableViewCell.self, forCellReuseIdentifier: kCellIdArticleDetailTableViewCell)
        tableView.register(ArticleCommentTableViewCell.self, forCellReuseIdentifier: kCellIdArticleCommentTableViewCell)
        tableView.register(ArticleRewardTableViewCell.self, forCellReuseIdentifier: kCellIdArticleRewardTableViewCell)
        tableView.register(WKWebViewCell.self, forCellReuseIdentifier: kCellIdWKWebViewCell)
        tableView.register(ArticleNumInfoTableViewCell.self, forCellReuseIdentifier: kCellIdArticleNumInfoTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initSubviews()
        self.getArticleComments(page: 1)
        self.getArticleRewordLog()
        self.getArticleDetail()
    }
    
    private func initSubviews() {
        self.title = "文章详情"
        self.showBackButton()
        self.showBarButtonItem(position: RIGHT, withImage: UIImage(named: "top_btn_share_white")!)
        
        self.toobarView.goToCommentsBlock = {
            [weak self] (Void) in
            let vc = ArticleCommentListViewController()
            vc.articleId = (self?.article.id)!
            self?.pushViewController(viewContoller: vc, animated: true)
        }
        
        self.toobarView.addCommentBlock = {
            [weak self] (Void) in
            self?.showArticleCommentView()
        }
        
        self.toobarView.likeBlock = {
            [weak self] (Void) in
            self?.likeArticle()
        }
        
        self.toobarView.addRewordBlock = {
            [weak self] (Void) in
            self?.showRewordView()
        }
        
        self.view.addSubview(self.toobarView)
        self.toobarView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(kTabBarHeight)
        }
        
        self.tableView.setPullingHeader()
        self.tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.getArticleComments(page: 1)
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(self.toobarView.snp.top)
        }
        
        self.rewordActionSheet.selectButtonAtIndex = {
            
            [weak self] (index) in
            
            if index > 0 {
                let integral = self?.integralList[index - 1]
                self?.articleReward(integral: integral!)
            }
            
        }
        
    }
    
    // MARK: - Networking
    private func getArticleComments(page: Int) {
        self.viewModel.getArticleComment(articleId: self.article.id, page: page, cache: { [weak self] (data) in
            self?.updateCommetsData(data: data)
        }, success: { [weak self] (data) in
            self?.updateCommetsData(data: data)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func updateCommetsData(data: JSON) {
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
        
        self.tableView.reloadData()
    }
    
    private func getArticleRewordLog() {
        self.viewModel.getArticleReward(articleId: self.article.id, page: 1, cache: { [weak self] (data) in
            self?.rewordList = RewardLog.fromJSONArray(json: data["entities"].arrayObject!)
            let pageInfo = PageInfo.fromJSON(json: data["pageInfo"].object)
            self?.rewordNumber = pageInfo.allNum
            self?.tableView.reloadData()
        }, success: { [weak self] (data) in
            self?.rewordList = RewardLog.fromJSONArray(json: data["entities"].arrayObject!)
            let pageInfo = PageInfo.fromJSON(json: data["pageInfo"].object)
            self?.rewordNumber = pageInfo.allNum
            self?.tableView.reloadData()
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func likeArticle() {
        
        self.showHudLoadingTipStr("")
        
        self.viewModel.likeArticle(articleId: self.article.id, success: { [weak self] (data) in
            self?.showHudTipStr("点赞成功")
            
            self?.article.isLike = INT_TRUE
            self?.toobarView.setLike(isLike: (self?.article.isLike)!)
            
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func showArticleCommentView() {
        if sharedGlobal.getToken().tokenExists {
            let replyView = HcdReplyView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
            replyView.placeHolder = "我来说几句..."
            replyView.commitReplyBlock = { [weak self]
                (content, score) in
                
                self?.addArticleComment(comment: content!)
                
            }
            replyView.showReply(in: UIApplication.shared.keyWindow)
        } else {
            self.showLoginViewController()
        }
    }
    
    private func addArticleComment(comment: String) {
        
        self.showHudLoadingTipStr("")
        
        self.viewModel.addArticleComment(articleId: self.article.id, content: comment, commentType: kCommentLv1, score: "0", articleCommentId: "0", receiverId: "0", success: { [weak self] (data) in
            self?.showHudTipStr("评论成功")
            }, fail: { [weak self] (message) in
                self?.showHudTipStr(message)
        }) {
            
        }
    }
    
    private func getArticleDetail() {
        self.viewModel.getArticleDetail(articleId: self.article.id, cache: { [weak self] (data) in
            
            self?.article = Article.fromJSON(json: data.object)
            self?.toobarView.setLike(isLike: (self?.article.isLike)!)
            
        }, success: { [weak self] (data) in
            
            self?.article = Article.fromJSON(json: data.object)
            self?.toobarView.setLike(isLike: (self?.article.isLike)!)
            
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func showRewordView() {
        if sharedGlobal.getToken().tokenExists {
            UIApplication.shared.keyWindow?.addSubview(self.rewordActionSheet)
            self.rewordActionSheet.show()
        } else {
            self.showLoginViewController()
        }
    }
    
    private func articleReward(integral: String) {
        
        self.showHudLoadingTipStr("")
        
        self.viewModel.articleReward(integral: integral, articleId: self.article.id, success: { [weak self] (data) in
            self?.showHudTipStr("感谢您的支持")
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if 0 == section {
            row = 4
        } else if 1 == section {
            row = self.commentList.count
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdArticleDetailTableViewCell, for: indexPath) as! ArticleDetailTableViewCell
                cell.setArticle(article: self.article)
                return cell
            } else if 1 == indexPath.row{
                let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdWKWebViewCell, for: indexPath) as! WKWebViewCell
                cell.content = self.article.content
                cell.cellHeightChanged = {
                    [weak self] height in
                    if height != self?.webviewHight {
                        self?.webviewHight = height
                        self?.tableView.reloadData()
                    }
                }
                return cell
            } else if 2 == indexPath.row {
                let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdArticleNumInfoTableViewCell, for: indexPath) as! ArticleNumInfoTableViewCell
                cell.setArticle(article: self.article)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdArticleRewardTableViewCell, for: indexPath) as! ArticleRewardTableViewCell
                cell.setRewordLog(logs: self.rewordList)
                cell.setRewordNumber(num: self.rewordNumber)
                cell.seeAllBlock = {
                    [weak self] (Void) in
                    let vc = ArticleRewordListViewController()
                    vc.article = self?.article
                    self?.pushViewController(viewContoller: vc, animated: true)
                }
                cell.addRewordBlock = {
                    [weak self] (Void) in
                    self?.showRewordView()
                }
                return cell
            }
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdArticleCommentTableViewCell, for: indexPath) as! ArticleCommentTableViewCell
            let comment = self.commentList[indexPath.row]
            cell.setComment(comment: comment)
            cell.userBlock = {
                [weak self] (user) in
                let vc = OthersHomeViewController()
                vc.user = user
                self?.pushViewController(viewContoller: vc, animated: true)
            }
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height = CGFloat(0)
        
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                height = ArticleDetailTableViewCell.cellHeightWithArticle(article: self.article)
            } else if 1 == indexPath.row {
                height = self.webviewHight + kBasePadding
            } else if 2 == indexPath.row {
                height = ArticleNumInfoTableViewCell.cellHeight()
            } else {
                height = ArticleRewardTableViewCell.cellHeight()
            }
            
        } else {
            let comment = self.commentList[indexPath.row]
            height = ArticleCommentTableViewCell.cellHeightWithComment(comment: comment)
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if 1 == indexPath.section {
            let comment = self.commentList[indexPath.row]
            let vc = ArticleCommentDetailViewController()
            vc.articleId = self.article.id
            vc.comment = comment
            self.pushViewController(viewContoller: vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return scaleFromiPhone6Desgin(x: 40)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: scaleFromiPhone6Desgin(x: 40)))
            view.backgroundColor = .white
            
            let tipsLbl = UILabel()
            tipsLbl.font = UIFont.systemFont(ofSize: 14)
            tipsLbl.textColor = UIColor(hex: 0x555555)
            tipsLbl.textAlignment = .left
            tipsLbl.text = String.init(format: "全部评价（%d）", self.pageInfo.allNum)
            view.addSubview(tipsLbl)
            tipsLbl.snp.makeConstraints({ (make) in
                make.left.equalTo(kBasePadding)
                make.top.equalTo(0)
                make.bottom.equalTo(0)
                make.right.equalTo(-scaleFromiPhone6Desgin(x: 40))
            })
            
            let arrowImg = UIImageView()
            arrowImg.image = UIImage(named: "xiangqing_btn_xiti")
            arrowImg.contentMode = .scaleAspectFit
            arrowImg.clipsToBounds = true
            view.addSubview(arrowImg)
            arrowImg.snp.makeConstraints({ (make) in
                make.right.equalTo(-kBasePadding)
                make.centerY.equalTo(view.snp.centerY)
                make.width.equalTo(scaleFromiPhone6Desgin(x: 9))
                make.height.equalTo(scaleFromiPhone6Desgin(x: 16))
            })
            
            let line = UIView()
            line.backgroundColor = kMainBgColor
            view.addSubview(line)
            line.snp.makeConstraints({ (make) in
                make.bottom.equalTo(0)
                make.height.equalTo(1)
                make.left.equalTo(0)
                make.right.equalTo(0)
            })
            
            let seeAllBtn = UIButton()
            seeAllBtn.backgroundColor = .clear
            view.addSubview(seeAllBtn)
            seeAllBtn.addTarget(self, action: #selector(seeAllComments), for: .touchUpInside)
            seeAllBtn.snp.makeConstraints({ (make) in
                make.bottom.equalTo(0)
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(0)
            })
            
            return view
        }
        return nil
    }
    
    // MARK: - Private
    @objc private func seeAllComments() {
        if nil == self.article {
            return
        }
        let vc = ArticleCommentListViewController()
        vc.articleId = self.article.id
        self.pushViewController(viewContoller: vc, animated: true)
        
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        UMSocialUIManager.showShareMenuViewInWindow { (platformType, userInfo) in
            // 根据获取的platformType确定所选平台进行下一步操作
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
