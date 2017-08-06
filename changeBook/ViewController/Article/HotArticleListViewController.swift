//
//  HotArticleListViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 05/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class HotArticleListViewController: BaseTableViewController, UITableViewDelegate, UITableViewDataSource {

    var parentVC: UIViewController?
    private var viewModel: ArticleViewModel = ArticleViewModel()
    private var articleList = [Article]()
    private var pageInfo = PageInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
        getHotArticle(page: 1)
    }
    
    private func initSubviews() {
        let view = UIView.init(frame: CGRect.init(x: 0,
                                                  y: 0,
                                                  width: kScreenWidth,
                                                  height: kHomeHeadViewHeight))
        view.backgroundColor = kMainBgColor
        tableView.tableHeaderView = view
        tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: kHomeHeadViewHeight,
                                                            left: 0,
                                                            bottom: 0,
                                                            right: 0)
        
        self.view.addSubview(self.tableView)
        self.tableView.register(ArticleListTableViewCell.self, forCellReuseIdentifier: kCellIdArticleListTableViewCell)
        
        self.tableView.setPullingHeader()
        self.tableView.setPullingFooter()
        self.tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.getHotArticle(page: 1)
        }
        self.tableView.footerRefreshBlock = {
            [weak self] (Void) in
            if self?.pageInfo.nextPage == self?.pageInfo.currentPage {
                
            } else {
                self?.getHotArticle(page: (self?.pageInfo.nextPage)!)
            }
        }
        self.tableView.reloadBlock = {
            [weak self] (Void) in
            self?.getHotArticle(page: 1)
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.contentOffset.y = self.tableViewOffsetY
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let article = self.articleList[indexPath.row]
        let vc = ArticleDetailViewController()
        vc.article = article
        self.pushViewController(viewContoller: vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ArticleListTableViewCell.cellHeight()
    }
    
    // MARK: - Networking
    private func getHotArticle(page: Int) {
        self.viewModel.getHotArticle(page: page, cache: { [weak self] (data) in
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
        
        if self.pageInfo.currentPage == 1 {
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
            if self.pageInfo.currentPage == self.pageInfo.maxPage {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
