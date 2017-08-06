//
//  ArticleRewordViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 06/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class ArticleRewordListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var article: Article!
    private var viewModel = ArticleViewModel()
    private var rewordList = [RewardLog]()
    private var pageInfo = PageInfo()
    
    private lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(ArticleRewordListTableViewCell.self, forCellReuseIdentifier: kCellIdArticleRewordListTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        getArticleReward(page: 1)
    }

    private func initSubviews() {
        self.title = "积分支持明细"
        self.showBackButton()
        
        self.tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.getArticleReward(page: 1)
        }
        self.tableView.reloadBlock = {
            [weak self] (Void) in
            self?.getArticleReward(page: 1)
        }
        self.tableView.footerRefreshBlock = {
            [weak self] (Void) in
            if self?.pageInfo.nextPage == self?.pageInfo.currentPage {
                
            } else {
                self?.getArticleReward(page:  (self?.pageInfo.nextPage)!)
            }
        }
        self.tableView.setPullingFooter()
        self.tableView.setPullingHeader()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    private func getArticleReward(page: Int) {
        self.viewModel.getArticleReward(articleId: self.article.id, page: page, cache: { [weak self] (data) in
            self?.updateRewordList(data: data)
        }, success: { [weak self] (data) in
            self?.updateRewordList(data: data)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func updateRewordList(data: JSON) {
        if JSON.null == data {
            return
        }
        
        self.pageInfo = PageInfo.fromJSON(json: data["pageInfo"])
        let rewords = RewardLog.fromJSONArray(json: data["entities"].arrayObject!)
        
        if self.pageInfo.currentPage == 1 {
            self.rewordList.removeAll()
        }
        
        if rewords.count > 0 {
            for reword in rewords {
                self.rewordList.append(reword)
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
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rewordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdArticleRewordListTableViewCell, for: indexPath) as! ArticleRewordListTableViewCell
        
        let reword = self.rewordList[indexPath.row]
        cell.setRewordLog(rewordLog: reword)
        cell.userHead.addTap { (imgView) in
            BLog(log: "点击了个人头像")
        }
        
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ArticleRewordListTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
