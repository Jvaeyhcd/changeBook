//
//  ArticleDetailViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 25/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArticleDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var article: Article!
    private var viewModel: ArticleViewModel = ArticleViewModel()
    private var commentList = [Comment]()
    private var pageInfo = PageInfo()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(ArticleDetailTableViewCell.self, forCellReuseIdentifier: kCellIdArticleDetailTableViewCell)
        tableView.register(ArticleCommentTableViewCell.self, forCellReuseIdentifier: kCellIdArticleCommentTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        self.getArticleComments(page: 1)
    }
    
    private func initSubviews() {
        self.title = "文章详情"
        self.showBackButton()
        
        self.view.addSubview(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(kTabBarHeight)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(self.bottomView.snp.top)
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
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if 0 == section {
            row = 1
        } else if 1 == section {
            row = self.commentList.count
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if 0 == indexPath.section {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdArticleDetailTableViewCell, for: indexPath) as! ArticleDetailTableViewCell
            cell.setArticle(article: self.article)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdArticleCommentTableViewCell, for: indexPath) as! ArticleCommentTableViewCell
            let comment = self.commentList[indexPath.row]
            cell.setComment(comment: comment)
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height = CGFloat(0)
        
        if 0 == indexPath.section {
            height = ArticleDetailTableViewCell.cellHeightWithArticle(article: self.article)
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
