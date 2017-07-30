//
//  PayWayViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 30/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class PayWayViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // 支付金额
    var payMoney: String = ""
    var payWay: String = kPayWayWechat
    var payWayBlock: ((String)->())!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: kBasePadding, width: kScreenWidth, height: SelectPayWayTableViewCell.cellHeight() * 2), style: .plain)
        tableView.register(SelectPayWayTableViewCell.self, forCellReuseIdentifier: kCellIdSelectPayWayTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private lazy var okBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("确认支付", for: .normal)
        btn.backgroundColor = kMainColor
        btn.titleLabel?.textColor = UIColor.white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.layer.cornerRadius = 4
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        
        self.view.backgroundColor = UIColor.white
        
        self.title = "选择支付方式"
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18),NSForegroundColorAttributeName: UIColor.white]
        
        self.contentSizeInPopup = CGSize(width: kScreenWidth, height: SelectPayWayTableViewCell.cellHeight() * 2 + scaleFromiPhone6Desgin(x: 50) + 3 * kBasePadding)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        self.okBtn.setTitle("确认支付" + self.payMoney + "元", for: .normal)
        self.view.addSubview(self.okBtn)
        self.okBtn.addTarget(self, action: #selector(okBtnClicked), for: .touchUpInside)
        self.okBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.tableView.snp.bottom).offset(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.left.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 50))
        }
    }
    
    @objc private func okBtnClicked() {
        
        if nil != self.payWayBlock {
            self.payWayBlock(self.payWay)
            self.dismiss(animated: true, completion: nil)
        }
        
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSelectPayWayTableViewCell, for: indexPath) as! SelectPayWayTableViewCell
        
        if 0 == indexPath.row {
            cell.iconImageView.image = UIImage(named: "zhifu_icon_wx")
            cell.titleLbl.text = "微信支付"
            if self.payWay == kPayWayWechat {
                cell.selectBtn.setImage(UIImage(named: "zhifu_rb_pre"), for: .normal)
            } else {
                cell.selectBtn.setImage(UIImage(named: "zhifu_rb"), for: .normal)
            }
        } else if 1 == indexPath.row {
            cell.iconImageView.image = UIImage(named: "zhifu_icon_zfb")
            cell.titleLbl.text = "支付宝支付"
            if self.payWay == kPayWayAli {
                cell.selectBtn.setImage(UIImage(named: "zhifu_rb_pre"), for: .normal)
            } else {
                cell.selectBtn.setImage(UIImage(named: "zhifu_rb"), for: .normal)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SelectPayWayTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if 0 == indexPath.row {
            self.payWay = kPayWayWechat
        } else if 1 == indexPath.row {
            self.payWay = kPayWayAli
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
