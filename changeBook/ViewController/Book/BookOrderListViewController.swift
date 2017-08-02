//
//  BookOrderListViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 02/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class BookOrderListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var parentVC: UIViewController?
    var orderStatus: Int = 0
    
    lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(OrderListTableViewCell.self, forCellReuseIdentifier: kCellIdOrderListTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()
    
    private var viewModel: BookViewModel = BookViewModel()
    private var pageInfo: PageInfo = PageInfo()
    
    private var orderList: [BookOrder] = [BookOrder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        getUserBookOrder(page: 1)
    }
    
    private func initSubviews() {
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setPullingFooter()
        self.tableView.setPullingHeader()
        self.tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.getUserBookOrder(page: 1)
        }
        self.tableView.footerRefreshBlock = {
            
            [weak self] (Void) in
            
            if self?.pageInfo.nextPage == self?.pageInfo.currentPage {
                
            } else {
                self?.getUserBookOrder(page: (self?.pageInfo.nextPage)!)
            }
            
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
    }
    
    private func getUserBookOrder(page: Int) {
        self.viewModel.getUserBookOrder(orderStatus: self.orderStatus, page: page, cache: { [weak self] (data) in
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
        let bookOrders = BookOrder.fromJSONArray(json: data["entities"].arrayObject!)//Book.fromJSONArray(json: data["entities"].arrayObject!)
        
        if self.pageInfo.currentPage == 1 {
            self.orderList.removeAll()
        }
        
        if bookOrders.count > 0 {
            for order in bookOrders {
                self.orderList.append(order)
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdOrderListTableViewCell, for: indexPath) as! OrderListTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        
        let bookOrder = self.orderList[indexPath.row]
        cell.setBookOrder(bookOrder: bookOrder)
        cell.seeDetailBlock = {
            [weak self] (order) in
            
            let vc = BookOrderDetailViewController()
            vc.bookOrder = order
            self?.pushViewController(viewContoller: vc, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let bookOrder = self.orderList[indexPath.row]
        return OrderListTableViewCell.cellHeightWithBookOrder(order: bookOrder)
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
