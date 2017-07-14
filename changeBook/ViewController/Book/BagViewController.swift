//
//  BagViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 14/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class BagViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var okBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("删除", for: .selected)
        btn.setTitle("立即结算", for: .normal)
        btn.backgroundColor = kMainColor
        btn.titleLabel?.textColor = UIColor.white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return btn
    }()
    
    var allBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("全选", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(UIColor(hex: 0x888888), for: .normal)
        btn.setImage(UIImage(named: "zhifu_rb"), for: .normal)
        btn.setImage(UIImage(named: "zhifu_rb_pre"), for: .selected)
        btn.setImage(UIImage(named: "zhifu_rb_pre"), for: .highlighted)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3)
        return btn
    }()
    
    lazy var totalLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor(hex: 0x555555)
        return lbl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = TPKeyboardAvoidingTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(BagTableViewCell.self, forCellReuseIdentifier: kCellIdBagTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()
    
    lazy var rightBtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn.titleLabel?.font = kBaseFont
        btn.setTitle("编辑", for: UIControlState.normal)
        btn.setTitle("完成", for: UIControlState.selected)
        btn.setTitleColor(UIColor(hex: 0xFFFFFF), for: .normal)
        btn.setTitleColor(UIColor(hex: 0xBDBDBD), for: .disabled)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        self.title = "书包"
        self.showBackButton()
        
        let item = UIBarButtonItem(customView: self.rightBtn)
        self.navigationItem.rightBarButtonItem = item
        self.rightBtn.addTarget(self, action: #selector(rightNavBarButtonClicked), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(kTabBarHeight)
        }
        
        self.bottomView.addSubview(self.okBtn)
        self.okBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 120))
        }
        
        self.bottomView.addSubview(self.allBtn)
        self.allBtn.addTarget(self, action: #selector(allBtnClicked), for: .touchUpInside)
        self.allBtn.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.centerY.equalTo(self.bottomView.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.width.equalTo(60)
        }
        
        self.totalLbl.text = "共3本书 ￥120"
        self.bottomView.addSubview(self.totalLbl)
        self.totalLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.allBtn.snp.right).offset(8)
            make.centerY.equalTo(self.bottomView.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(self.okBtn.snp.left).offset(-8)
        }
        
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(self.bottomView.snp.top)
            make.left.equalTo(0)
        }
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        self.rightBtn.isSelected = !self.rightBtn.isSelected
    }
    
    func allBtnClicked() {
        self.allBtn.isSelected = !self.allBtn.isSelected
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdBagTableViewCell, for: indexPath) as! BagTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BagTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
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
