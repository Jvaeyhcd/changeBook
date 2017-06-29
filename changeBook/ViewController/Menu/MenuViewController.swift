//
//  MenuViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 22/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SnapKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var headbgImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.backgroundColor = kMainColor
        return imgView
    }()
    
    private lazy var userHeadImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = scaleFromiPhone6Desgin(x: 30)
        imgView.contentMode = .scaleAspectFill
        imgView.isUserInteractionEnabled = true
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = 1
        imgView.backgroundColor = kMainBgColor
        return imgView
    }()
    
    private lazy var userNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = UIColor.init(hex: 0xFFFFFF)
        return lbl
    }()
    
    private var menuTableView: UITableView = {
        let menuTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        menuTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: kCellIdMenuTableViewCell)
        menuTableView.backgroundColor = UIColor.clear
        menuTableView.separatorStyle = .none
        
        return menuTableView
    }()
    
    private var menuTitles = [
        ["我的消息", "我的借阅", "我的押金", "文章中心", "我的积分", "使用指南", "加入我们", "个人设置"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MAKR: - private
    private func initSubviews() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        let width = 0.8 * kScreenWidth
        self.headbgImageView.image = UIImage(named: "wode_bg")
        self.view.addSubview(self.headbgImageView)
        self.headbgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(width)
            make.height.equalTo(width * 13 / 30)
        }
        
        let tapGR = UITapGestureRecognizer.init(target: self, action: #selector(userHeadClick))
        self.userHeadImageView.addGestureRecognizer(tapGR)
        self.headbgImageView.addSubview(self.userHeadImageView)
        self.userHeadImageView.snp.makeConstraints { (make) in
            make.width.equalTo(scaleFromiPhone6Desgin(x: 60))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 60))
            make.left.equalTo(scaleFromiPhone6Desgin(x: 28))
            make.centerY.equalTo(self.headbgImageView.snp.centerY).offset(10)
        }
        
        self.userNameLbl.text = "Jvaeyhcd"
        self.headbgImageView.addSubview(self.userNameLbl)
        self.userNameLbl.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.userHeadImageView.snp.centerY)
            make.left.equalTo(self.userHeadImageView.snp.right).offset(scaleFromiPhone6Desgin(x: 8))
            make.right.equalTo(0)
            make.height.equalTo(30)
        }
        
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.view.addSubview(self.menuTableView)
        self.menuTableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(headbgImageView.snp.bottom).offset(scaleFromiPhone6Desgin(x: 26))
            make.bottom.equalTo(0)
            make.right.equalTo(-kScreenWidth / 6)
        }
        
    }
    
    @objc private func userHeadClick() {
        
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let array = menuTitles[section] as Array
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdMenuTableViewCell, for: indexPath) as! MenuTableViewCell
        cell.backgroundColor = UIColor.clear
        let text = menuTitles[indexPath.section][indexPath.row]
        cell.titleLbl.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MenuTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.hcd_sideMenu.showRootViewController(animated: true)
        
        if indexPath.row == 0 {
            let vc = MessageListViewController()
            self.hcd_sideMenu.pushViewController(viewContoller: vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = BorrowedBookViewController()
            self.hcd_sideMenu.pushViewController(viewContoller: vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = MyDepositViewController()
            self.hcd_sideMenu.pushViewController(viewContoller: vc, animated: true)
        } else if indexPath.row == 3 {
            let vc = UserArticleViewController()
            self.hcd_sideMenu.pushViewController(viewContoller: vc, animated: true)
        } else if indexPath.row == 4 {
            let vc = MyIntegralViewController()
            self.hcd_sideMenu.pushViewController(viewContoller: vc, animated: true)
        } else if indexPath.row == 5 {
            
        } else if indexPath.row == 6 {
            
        } else if indexPath.row == 7 {
            let vc = SettingViewController()
            self.hcd_sideMenu.pushViewController(viewContoller: vc, animated: true)
        }
        
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
