//
//  BookOrderDetailViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 02/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class BookOrderDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var bookOrder: BookOrder!
    
    private lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(OrderStatusTableViewCell.self, forCellReuseIdentifier: kCellIdOrderStatusTableViewCell)
        tableView.register(OrderAddressTableViewCell.self, forCellReuseIdentifier: kCellIdOrderAddressTableViewCell)
        tableView.register(OrderDetailBookTableViewCell.self, forCellReuseIdentifier: kCellIdOrderDetailBookTableViewCell)
        tableView.register(SimpleShowTableViewCell.self, forCellReuseIdentifier: kCellIdSimpleShowTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        self.title = "订单详情"
        self.showBackButton()
        
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
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var row = 0
        
        if 0 == section {
            row = 1
        } else if 1 == section {
            row = 1
        } else if 2 == section {
            row = self.bookOrder.orderDetail.count + 2
        } else if 3 == section {
            row = 4
        }
        
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if 0 == indexPath.section {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdOrderStatusTableViewCell, for: indexPath) as! OrderStatusTableViewCell
            return cell
        } else if 1 == indexPath.section {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdOrderAddressTableViewCell, for: indexPath) as! OrderAddressTableViewCell
            cell.setOrderAddress(order: self.bookOrder)
            return cell
        } else if 2 == indexPath.section {
            if indexPath.row < self.bookOrder.orderDetail.count {
                let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdOrderDetailBookTableViewCell, for: indexPath) as! OrderDetailBookTableViewCell
                
                let book = self.bookOrder.orderDetail[indexPath.row]
                cell.setBook(book: book)
                tableView.addLineLeftAndRightSpaceForPlainCell(cell: cell, indexPath: indexPath, leftSpace: kBasePadding, rightSpace: kBasePadding)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSimpleShowTableViewCell, for: indexPath) as! SimpleShowTableViewCell
                
                if self.bookOrder.orderDetail.count == indexPath.row {
                    cell.titleLbl.text = "运费"
                    cell.descLbl.text = "￥" + self.bookOrder.freight
                    cell.descLbl.textColor = UIColor(hex: 0x888888)
                } else if self.bookOrder.orderDetail.count + 1 == indexPath.row {
                    cell.titleLbl.text = ""
                    cell.descLbl.text = "实付款  ￥" + self.bookOrder.freight
                    cell.descLbl.textColor = UIColor(hex: 0xF85B5A)
                }
                tableView.addLineLeftAndRightSpaceForPlainCell(cell: cell, indexPath: indexPath, leftSpace: kBasePadding, rightSpace: kBasePadding)
                return cell
            }
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSimpleShowTableViewCell, for: indexPath) as! SimpleShowTableViewCell
            cell.descLbl.textColor = UIColor(hex: 0x888888)
            
            if 0 == indexPath.row {
                cell.titleLbl.text = "订单编号"
                cell.descLbl.text = bookOrder.orderSn
                
            } else if 1 == indexPath.row {
                cell.titleLbl.text = "下单时间"
                cell.descLbl.text = NSDate.stringTimesAgo(fromTimeInterval: self.bookOrder.createAt.doubleValue)
            } else if 2 == indexPath.row {
                cell.titleLbl.text = "支付方式"
                if kPayWayAli == self.bookOrder.payWay {
                    cell.descLbl.text = "支付宝支付"
                } else if kPayWayWechat == self.bookOrder.payWay {
                    cell.descLbl.text = "微信支付"
                }
            } else if 3 == indexPath.row {
                cell.titleLbl.text = "配送时间"
                cell.descLbl.text = bookOrder.deliveryDate
                
            }
            
            tableView.addLineLeftAndRightSpaceForPlainCell(cell: cell, indexPath: indexPath, leftSpace: kBasePadding, rightSpace: kBasePadding)
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var cellHeight = CGFloat(0)
        if 0 == indexPath.section {
            cellHeight = OrderStatusTableViewCell.cellHeight()
        } else if 1 == indexPath.section {
            cellHeight = OrderAddressTableViewCell.cellHeightWithOrder(order: self.bookOrder)
        } else if 2 == indexPath.section {
            if indexPath.row < self.bookOrder.orderDetail.count {
                cellHeight = OrderDetailBookTableViewCell.cellHeight()
            } else {
                cellHeight = SimpleShowTableViewCell.cellHeight()
            }
        } else if 3 == indexPath.section {
            cellHeight = SimpleShowTableViewCell.cellHeight()
        }
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var height = CGFloat(0)
        
        if section == 1 {
            height = kBasePadding
        } else if section == 2 {
            height = kBasePadding + scaleFromiPhone6Desgin(x: 40)
        } else if section == 3 {
            height = kBasePadding
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kBasePadding))
            view.backgroundColor = kMainBgColor
            return view
            
        } else if section == 2 {
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kBasePadding + scaleFromiPhone6Desgin(x: 40)))
            view.backgroundColor = kMainBgColor
            
            let bottomView = UIView.init(frame: CGRect(x: 0, y: kBasePadding, width: kScreenWidth, height: scaleFromiPhone6Desgin(x: 40)))
            bottomView.backgroundColor = UIColor.white
            view.addSubview(bottomView)
            
            let iconView = UIImageView()
            iconView.image = UIImage(named: "dingdan_icon_shangpin")
            iconView.contentMode = .scaleAspectFill
            iconView.clipsToBounds = true
            bottomView.addSubview(iconView)
            iconView.snp.makeConstraints({ (make) in
                make.left.equalTo(kBasePadding)
                make.width.equalTo(scaleFromiPhone6Desgin(x: 16))
                make.height.equalTo(scaleFromiPhone6Desgin(x: 16))
                make.centerY.equalTo(bottomView.snp.centerY)
            })
            
            let titleLbl = UILabel()
            titleLbl.text = "商品介绍"
            titleLbl.font = UIFont.systemFont(ofSize: 16)
            titleLbl.textColor = UIColor.init(hex: 0x555555)
            titleLbl.textAlignment = .left
            bottomView.addSubview(titleLbl)
            titleLbl.snp.makeConstraints { (make) in
                make.left.equalTo(iconView.snp.right).offset(kBasePadding)
                make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
                make.centerY.equalTo(bottomView.snp.centerY)
                make.width.equalTo(100)
            }
            
            let line = UIView()
            line.backgroundColor = kMainBgColor
            bottomView.addSubview(line)
            line.snp.makeConstraints({ (make) in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.bottom.equalTo(0)
                make.height.equalTo(1)
            })
            
            return view
        } else if section == 3 {
            
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kBasePadding))
            view.backgroundColor = kMainBgColor
            return view
            
        } else {
            return nil
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
