//
//  HotArticleListViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 05/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class HotArticleListViewController: BaseTableViewController, UITableViewDelegate, UITableViewDataSource {

    var parentVC: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdArticleListTableViewCell, for: indexPath) as! ArticleListTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ArticleListTableViewCell.cellHeight()
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
