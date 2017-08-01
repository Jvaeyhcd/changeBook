//
//  OrderListTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 02/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdOrderListTableViewCell = "OrderListTableViewCell"

class OrderListTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var order: BookOrder!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(OrderBookTableViewCell.self, forCellReuseIdentifier: kCellIdOrderBookTableViewCell)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    // 分割线
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = kMainBgColor
        return view
    }()
    
    // 订单编号
    private lazy var orderNumLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hex: 0x555555)
        label.textAlignment = .left
        return label
    }()
    
    // 订单状态
    private lazy var statusLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(hex: 0x555555)
        label.textAlignment = .right
        return label
    }()
    
    // 订单总览
    private lazy var orderAllLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(hex: 0x555555)
        label.textAlignment = .left
        return label
    }()
    
    // 查看详情或者评价按钮
    private lazy var btn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = kMainColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubviews()
    }
    
    private func initSubviews() {
        
        self.selectionStyle = .none
        
        self.addSubview(self.separatorView)
        self.separatorView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 10))
        }
        
        self.statusLbl.text = "已完成"
        self.addSubview(self.statusLbl)
        self.statusLbl.snp.makeConstraints { (make) in
            make.top.equalTo(self.separatorView.snp.bottom)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 40))
            make.right.equalTo(-kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 60))
        }
        
        self.orderNumLbl.text = "订单编号：No12221321321"
        self.addSubview(self.orderNumLbl)
        self.orderNumLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(self.separatorView.snp.bottom)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 40))
            make.right.equalTo(self.statusLbl.snp.left)
        }
        
        self.orderAllLbl.text = "共2件商品，合计￥20.00"
        self.addSubview(self.orderAllLbl)
        self.orderAllLbl.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 50))
            make.right.equalTo(-kBasePadding)
        }
        
        self.btn.setTitle("查看详情", for: .normal)
        self.addSubview(self.btn)
        self.btn.snp.makeConstraints { (make) in
            make.right.equalTo(-kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 80))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.centerY.equalTo(self.orderAllLbl.snp.centerY)
        }
        
        self.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(self.orderNumLbl.snp.bottom)
            make.right.equalTo(0)
            make.bottom.equalTo(self.orderAllLbl.snp.top)
        }
        
        
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if nil != self.order {
            return self.order.orderDetail.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdOrderBookTableViewCell, for: indexPath) as! OrderBookTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        
        let book = self.order.orderDetail[indexPath.row]
        cell.setBook(book: book)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return OrderBookTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    static func cellHeightWithBookOrder(order: BookOrder) -> CGFloat {
        return CGFloat(order.orderDetail.count) * OrderBookTableViewCell.cellHeight() + scaleFromiPhone6Desgin(x: 100)
    }
    
    func setBookOrder(bookOrder: BookOrder) {
        self.order = bookOrder
        self.orderNumLbl.text = "订单号：" + bookOrder.orderSn
        self.orderAllLbl.text = "共" + bookOrder.bookCount + "件商品，合计￥" + bookOrder.overdueFee + "元"
        self.tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
