//
//  MyIntegralViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 28/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class MyIntegralViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var integralLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.white
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.backgroundColor = kMainColor
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(IntegralLogTableViewCell.self, forCellReuseIdentifier: kCellIdIntegralLogTableViewCell)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        self.title = "我的积分"
        self.showBackButton()
        self.showBarButtonItem(position: RIGHT, withStr: "积分须知")
        
        self.integralLbl.text = "100"
        self.view.addSubview(self.integralLbl)
        self.integralLbl.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 120))
        }
        
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.integralLbl.snp.bottom)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    // MARK :- UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdIntegralLogTableViewCell, for: indexPath) as! IntegralLogTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IntegralLogTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return scaleFromiPhone6Desgin(x: 50)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: scaleFromiPhone6Desgin(x: 50)))
        headView.backgroundColor = kMainBgColor
        let lbl = UILabel.init(frame: CGRect(x: kBasePadding, y: 0, width: kScreenWidth - 2 * kBasePadding, height: scaleFromiPhone6Desgin(x: 50)))
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.textAlignment = .left
        lbl.text = "积分记录"
        headView.addSubview(lbl)
        return headView
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
