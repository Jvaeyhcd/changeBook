//
//  ArticleListViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 01/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArticleListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var category: ArticleCategory!
    var parentVC: UIViewController?
    private var viewModel: ArticleViewModel = ArticleViewModel()
    private var articleList = [Article]()
    private var pageInfo: PageInfo?
    
    lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(ArticleListTableViewCell.self, forCellReuseIdentifier: kCellIdArticleListTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        getArticleList(page: 1)
    }
    
    private func initSubviews() {
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setPullingFooter()
        self.tableView.setPullingHeader()
        self.tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.getArticleList(page: 1)
        }
        
        self.tableView.footerRefreshBlock = {
            [weak self] (Void) in
            if self?.pageInfo?.nextPage == self?.pageInfo?.currentPage {
                
            } else {
                self?.getArticleList(page:  (self?.pageInfo?.nextPage)!)
            }
        }
        self.tableView.reloadBlock = {
            [weak self] (Void) in
            self?.getArticleList(page:  (self?.pageInfo?.nextPage)!)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-kTabBarHeight)
            make.left.equalTo(0)
        }
    }
    
    private func getArticleList(page: Int) {
        
        if nil == self.category {
            return
        }
        
        self.viewModel.filterArticle(category: self.category.id, page: page, cache: { [weak self] (data) in
            self?.updateArticleList(data: data)
        }, success: { [weak self] (data) in
            self?.updateArticleList(data: data)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func updateArticleList(data: JSON) {
        if JSON.null == data {
            return
        }
        
        self.pageInfo = PageInfo.fromJSON(json: data["pageInfo"])
        let articles = Article.fromJSONArray(json: data["entities"].arrayObject!)
        
        if self.pageInfo?.currentPage == 1 {
            self.articleList.removeAll()
        }
        
        if articles.count > 0 {
            for article in articles {
                self.articleList.append(article)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdArticleListTableViewCell, for: indexPath) as! ArticleListTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        let article = self.articleList[indexPath.row]
        cell.setArticle(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ArticleListTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = self.articleList[indexPath.row]
        let vc = ArticleDetailViewController()
        vc.article = article
        vc.hidesBottomBarWhenPushed = true
        self.pushViewController(viewContoller: vc, animated: true)
        
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
