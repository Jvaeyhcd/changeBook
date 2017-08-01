//
//  ConfirmBookOrderViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 30/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class ConfirmBookOrderViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var bookList: [Book] = [Book]()
    private var viewModel = BookViewModel()
    // 还书时间
    private var returnTime: String = ""
    // 运费
    private var freight: String = ""
    // 支付方式，默认微信支付
    private var payWay: String = kPayWayWechat
    // 配送收货地址
    private var address: Address!
    // 自取配送地址
    private var ownAddress: String = ""
    
    // 配送方式，默认配送
    private var deliveryMode: Int = kDeliveryModePeiSong
    
    private lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(DeliveryModeTableViewCell.self, forCellReuseIdentifier: kCellIdDeliveryModeTableViewCell)
        tableView.register(ConfirmOrderTableViewCell.self, forCellReuseIdentifier: kCellIdConfirmOrderTableViewCell)
        tableView.register(OrderBookTableViewCell.self, forCellReuseIdentifier: kCellIdOrderBookTableViewCell)
        tableView.register(SimpleShowTableViewCell.self, forCellReuseIdentifier: kCellIdSimpleShowTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var okBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("提交订单", for: .normal)
        btn.backgroundColor = kMainColor
        btn.titleLabel?.textColor = UIColor.white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return btn
    }()
    
    private lazy var moneyLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 18)
        lbl.textColor = UIColor(hex: 0xF85B5A)
        return lbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        getFreight()
        getOwnAddress()
    }
    
    private func initSubviews() {
        self.title = "提交订单"
        self.showBackButton()
        
        self.view.addSubview(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(kTabBarHeight)
        }
        
        self.okBtn.addTarget(self, action: #selector(okBtnClicked), for: .touchUpInside)
        self.bottomView.addSubview(self.okBtn)
        self.okBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 120))
        }
        
        let tipsLbl = UILabel()
        tipsLbl.text = "合计"
        tipsLbl.textAlignment = .left
        tipsLbl.font = UIFont.systemFont(ofSize: 14)
        tipsLbl.textColor = UIColor(hex: 0x555555)
        self.bottomView.addSubview(tipsLbl)
        tipsLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.centerY.equalTo(self.bottomView.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        self.moneyLbl.text = "0元"
        self.bottomView.addSubview(self.moneyLbl)
        self.moneyLbl.snp.makeConstraints { (make) in
            make.left.equalTo(tipsLbl.snp.right).offset(8)
            make.centerY.equalTo(self.bottomView.snp.centerY)
            make.right.equalTo(self.okBtn.snp.left).offset(-8)
            make.height.equalTo(30)
        }
        
        let line = UIView()
        line.backgroundColor = kMainBgColor
        self.bottomView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(1)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(self.bottomView.snp.top)
        }
    }
    
    @objc private func okBtnClicked() {
        let vc = PayWayViewController()
        vc.payMoney = self.freight
        vc.payWay = self.payWay
        vc.payWayBlock = {
            [weak self] (payWay) in
            self?.payWay = payWay
            
            self?.generateBookOrder()
            
        }
        
        let popupController = STPopupController.init(rootViewController: vc)
        popupController.style = STPopupStyle.bottomSheet
        
        popupController.present(in: self)
    }
    
    // MARK: - Networking
    private func getFreight() {
        self.viewModel.getFreight(cache: { [weak self] (data) in
            
            self?.updateFreight(data: data)
            
        }, success: { [weak self] (data) in
            
            self?.updateFreight(data: data)
            
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func updateFreight(data: JSON) {
        self.returnTime = data["borrowTime"].stringValue
        self.freight = data["freight"].stringValue
        
        self.moneyLbl.text = self.freight + "元"
        self.tableView.reloadData()
    }
    
    // 获取自提地址
    private func getOwnAddress() {
        self.viewModel.getBookAddress(cache: { [weak self] (data) in
            self?.ownAddress = data["address"].stringValue
        }, success: { [weak self] (data) in
            self?.ownAddress = data["address"].stringValue
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    // 提交订单
    private func generateBookOrder() {
        
        var address = ""
        if kDeliveryModeZhiQu == self.deliveryMode {
            address = self.ownAddress
        } else if kDeliveryModePeiSong == self.deliveryMode {
            if nil == self.address {
                return
            }
            address = self.address.addressId
        }
        
        let bookListInfo = self.convertBookListToStr()
        
        self.viewModel.generateBookOrder(freight: self.freight, payWay: self.payWay, returnTime: self.returnTime, bookInfoList: bookListInfo, addressId: address, deliveryMode: self.deliveryMode, sendTime: "2017-08-01", success: { [weak self] (data) in
            self?.showHudTipStr("提交成功")
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    // 将书的数组转成str字符串
    private func convertBookListToStr() -> String {
        
        var list = [Dictionary<String, Any>]()
        for book in self.bookList {
            var bookDic = Dictionary<String, Any>()
            bookDic["bookId"] = book.bookId
            bookDic["bookName"] = book.bookName
            bookDic["bookCover"] = book.bookCover
            bookDic["bookType"] = book.bookType
            bookDic["bookCount"] = book.bookCount
            bookDic["score"] = book.score
            list.append(bookDic)
        }
        
        return "\(list)"
        
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var row = 0
        
        if 0 == section {
            row = 3
        } else if 1 == section {
            row = self.bookList.count + 2
        } else {
            row = 1
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdDeliveryModeTableViewCell, for: indexPath) as! DeliveryModeTableViewCell
                tableView.addLineLeftAndRightSpaceForPlainCell(cell: cell, indexPath: indexPath, leftSpace: kBasePadding, rightSpace: kBasePadding)
                cell.setDeliveryWay(deliveryWay: self.deliveryMode)
                cell.deliveryWayBlock = {
                    [weak self] (deliveryMode) in
                    self?.deliveryMode = deliveryMode
                    self?.tableView.reloadData()
                }
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdConfirmOrderTableViewCell, for: indexPath) as! ConfirmOrderTableViewCell
            if 1 == indexPath.row {
                cell.iconImageView.image = UIImage(named: "dingdan_icon_shijiani")
                cell.titleLbl.text = "选择送出时间"
            } else if 2 == indexPath.row {
                cell.iconImageView.image = UIImage(named: "dingdan_icon_dizhi")
                cell.titleLbl.text = "收货地址"
                if kDeliveryModePeiSong == self.deliveryMode && nil != self.address {
                    cell.descLbl.text = self.address.addressDetail
                } else if kDeliveryModeZhiQu == self.deliveryMode {
                    cell.descLbl.text = self.ownAddress
                }
            }
            tableView.addLineLeftAndRightSpaceForPlainCell(cell: cell, indexPath: indexPath, leftSpace: kBasePadding, rightSpace: kBasePadding)
            return cell
        } else if (1 == indexPath.section) {
            if indexPath.row < self.bookList.count {
                let book = self.bookList[indexPath.row]
                let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdOrderBookTableViewCell, for: indexPath) as! OrderBookTableViewCell
                cell.setBook(book: book)
                tableView.addLineLeftAndRightSpaceForPlainCell(cell: cell, indexPath: indexPath, leftSpace: kBasePadding, rightSpace: kBasePadding)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSimpleShowTableViewCell, for: indexPath) as! SimpleShowTableViewCell
                let bookCount = self.bookList.count;
                if bookCount == indexPath.row {
                    cell.titleLbl.text = "运费"
                    cell.descLbl.text = self.freight + "元"
                } else if bookCount + 1 == indexPath.row {
                    cell.titleLbl.text = "合计"
                    cell.descLbl.text = self.freight + "元"
                }
                
                tableView.addLineLeftAndRightSpaceForPlainCell(cell: cell, indexPath: indexPath, leftSpace: kBasePadding, rightSpace: kBasePadding)
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSimpleShowTableViewCell, for: indexPath) as! SimpleShowTableViewCell
            cell.titleLbl.text = "还书截止时间"
            cell.descLbl.text = self.returnTime
            return cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat(0)
        
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                height = DeliveryModeTableViewCell.cellHeight()
            } else {
                height = ConfirmOrderTableViewCell.cellHeight()
            }
            
        } else if 1 == indexPath.section {
            if indexPath.row < self.bookList.count {
                height = OrderBookTableViewCell.cellHeight()
            } else {
                height = SimpleShowTableViewCell.cellHeight()
            }
            
        } else {
            height = SimpleShowTableViewCell.cellHeight()
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var height = CGFloat(0)
        
        if section == 1 {
            height = kBasePadding + scaleFromiPhone6Desgin(x: 40)
        } else if section == 2 {
            height = kBasePadding
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
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
        } else if section == 1 {
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kBasePadding))
            view.backgroundColor = kMainBgColor
            return view
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if 0 == indexPath.section {
            if 1 == indexPath.row {
                
            } else if 2 == indexPath.row {
                let vc = AddressListViewController()
                vc.selectType = .chose
                vc.choseAddressBlock = {
                    [weak self] (address) in
                    self?.address = address
                    self?.tableView.reloadData()
                }
                self.pushViewController(viewContoller: vc, animated: true)
            }
        }
        
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
