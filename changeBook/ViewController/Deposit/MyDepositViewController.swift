//
//  MyDepositViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 28/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kDepositTableViewWidth = kScreenWidth - 2 * kBasePadding
let kDepositTableViewHeight = kDepositTableViewWidth * CGFloat(CGFloat(1500) / CGFloat(1035))

class MyDepositViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    let bookNumbers = ["5", "10"]
    let moneys = ["29", "49"]
    var selectedIndex = 0
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DepositTableViewCell.self, forCellReuseIdentifier: kCellIdDepositTableViewCell)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        
        let bgImageView = UIImageView()
        bgImageView.contentMode = UIViewContentMode.scaleAspectFill
        bgImageView.image = UIImage(named: "yajin_bg")
        
        tableView.backgroundView = bgImageView
        return tableView
    }()
    
    private var payBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = kBarButtonItemTitleFont
        btn.setTitleColor(UIColor.white, for: UIControlState.normal)
        btn.backgroundColor = kMainColor
        btn.setTitle("立即支付", for: .normal)
        return btn
    }()

    private lazy var tipsLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    private lazy var authBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "yajin_btn_renzheng"), for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        self.title = "我的押金"
        self.showBackButton()
        self.showBarButtonItem(position: RIGHT, withStr: "押金明细")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(kDepositTableViewHeight)
        }
        
        self.tipsLbl.text = "点击学生认证免押金"
        self.view.addSubview(self.tipsLbl)
        self.tipsLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.tableView.snp.left)
            make.right.equalTo(self.tableView.snp.right)
            make.height.equalTo(20)
            make.bottom.equalTo(self.tableView.snp.bottom).offset(-scaleFromiPhone6Desgin(x: 80))
        }
        
        self.authBtn.addTarget(self, action: #selector(authBtnClicked), for: .touchUpInside)
        self.view.addSubview(self.authBtn)
        self.authBtn.snp.makeConstraints { (make) in
            make.width.equalTo(scaleFromiPhone6Desgin(x: 50))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 50))
            make.centerX.equalTo(self.tableView.snp.centerX)
            make.bottom.equalTo(self.tipsLbl.snp.top).offset(-kBasePadding)
        }
        
        self.view.addSubview(self.payBtn)
        self.payBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.tableView.snp.bottom).offset(kBasePadding)
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 50))
        }
    }
    
    @objc private func authBtnClicked() {
        let vc = RealnameAuthViewController()
        self.pushViewController(viewContoller: vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        let vc = DepositDetailViewController()
        self.pushViewController(viewContoller: vc, animated: true)
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdDepositTableViewCell, for: indexPath) as! DepositTableViewCell
        
        let bookNum = self.bookNumbers[indexPath.row]
        let money = self.moneys[indexPath.row]
        cell.bookNumberLbl.text = bookNum + "本书"
        cell.moneyLbl.text = "￥" + money
        cell.setCellSelected(selected: (self.selectedIndex == indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DepositTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedIndex = indexPath.row
        self.tableView.reloadData()
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
