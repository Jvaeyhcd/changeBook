//
//  MineViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 06/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SnapKit

class MineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var menuTableView: UITableView = {
        let menuTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        menuTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: kCellIdMenuTableViewCell)
        menuTableView.register(MineUserInfoTableViewCell.self, forCellReuseIdentifier: kCellIdMineUserInfoTableViewCell)
        menuTableView.backgroundColor = UIColor.white
        menuTableView.separatorStyle = .none
        
        return menuTableView
    }()
    
    private var menuTitles = [
        ["我的消息", "我的借阅", "我的押金", "文章中心", "我的积分", "使用指南", "加入我们", "个人设置"]
    ]
    private var menuIcons = [
        ["wode_btn_touxiang", "wode_btn_jieyue", "wode_btn_yajin", "wode_btn_wenzhang", "wode_btn_jifen", "wode_btn_bangzhu", "wode_btn_jiaru", "wode_btn_shezhi"]
    ]
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUserInfo), name: NSNotification.Name(rawValue: "refreshUserInfo"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUserInfo), name: NSNotification.Name(rawValue: "logoutSuccess"), object: nil)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.view.addSubview(self.menuTableView)
        self.menuTableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
        
    }
    
    @objc private func refreshUserInfo() {
        self.menuTableView.reloadData()
    }
    
    @objc private func userHeadClick() {
        
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuTitles.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        let array = menuTitles[section - 1] as Array
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdMineUserInfoTableViewCell, for: indexPath) as! MineUserInfoTableViewCell
            cell.setUserInfo(user: sharedGlobal.getSavedUser())
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdMenuTableViewCell, for: indexPath) as! MenuTableViewCell
        cell.backgroundColor = UIColor.clear
        let text = menuTitles[indexPath.section - 1][indexPath.row]
        let imgName = menuIcons[indexPath.section - 1][indexPath.row]
        cell.iconImageView.image = UIImage(named: imgName)
        cell.titleLbl.text = text
        
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: CGFloat(0))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return MineUserInfoTableViewCell.cellHeight()
        }
        return MenuTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            return
        }
        
        if indexPath.row == 0 {
            let vc = MessageListViewController()
            vc.hidesBottomBarWhenPushed = true
            self.pushViewController(viewContoller: vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = BorrowedBookViewController()
            vc.hidesBottomBarWhenPushed = true
            self.pushViewController(viewContoller: vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = MyDepositViewController()
            vc.hidesBottomBarWhenPushed = true
            self.pushViewController(viewContoller: vc, animated: true)
        } else if indexPath.row == 3 {
            let vc = UserArticleViewController()
            vc.hidesBottomBarWhenPushed = true
            self.pushViewController(viewContoller: vc, animated: true)
        } else if indexPath.row == 4 {
            let vc = MyIntegralViewController()
            vc.hidesBottomBarWhenPushed = true
            self.pushViewController(viewContoller: vc, animated: true)
        } else if indexPath.row == 5 {
            
        } else if indexPath.row == 6 {
            
        } else if indexPath.row == 7 {
            if sharedGlobal.getToken().tokenExists {
                let vc = SettingViewController()
                vc.hidesBottomBarWhenPushed = true
                self.pushViewController(viewContoller: vc, animated: true)
            } else {
                self.showLoginViewController()
            }
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
