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
    
    private var userInfoView: UserInfoView = {
        let view = UserInfoView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kUserInfoViewHeight))
        return view
    }()
    
    private var menuTableView: UITableView = {
        let menuTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        menuTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: kCellIdMenuTableViewCell)
        menuTableView.backgroundColor = UIColor.white
        menuTableView.separatorStyle = .none
        
        return menuTableView
    }()
    
    private var menuTitles = [
        ["我的消息", "我的借阅", "我的押金", "我的积分"],
        ["使用指南", "加入我们", "个人设置"]
    ]
    private var menuIcons = [
        ["wode_btn_touxiang", "wode_btn_jieyue", "wode_btn_yajin", "wode_btn_jifen"],
        ["wode_btn_bangzhu", "wode_btn_jiaru", "wode_btn_shezhi"]
    ]
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.refreshUserInfo()
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
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(userHeadClick))
        self.userInfoView.addGestureRecognizer(tap)
        self.view.addSubview(self.userInfoView)
        self.userInfoView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(kUserInfoViewHeight)
        }
        
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.view.addSubview(self.menuTableView)
        self.menuTableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(self.userInfoView.snp.bottom)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
        
    }
    
    @objc private func refreshUserInfo() {
        self.userInfoView.setUserInfo(user: sharedGlobal.getSavedUser())
        self.menuTableView.reloadData()
    }
    
    @objc private func userHeadClick() {
        
        if sharedGlobal.getToken().tokenExists {
            let vc = UsersHomeViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.user = sharedGlobal.getSavedUser()
            self.pushViewController(viewContoller: vc, animated: true)
        } else {
            self.showLoginViewController()
        }
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
        let imgName = menuIcons[indexPath.section][indexPath.row]
        cell.iconImageView.image = UIImage(named: imgName)
        cell.titleLbl.text = text
        
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: CGFloat(0))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return MenuTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return kBasePadding
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kBasePadding))
        view.backgroundColor = kMainBgColor
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if 0 == indexPath.section {
            
            // 与个人相关的，都需要登录后才能查看
            if false == sharedGlobal.getToken().tokenExists {
                self.showLoginViewController()
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
                if sharedGlobal.getSavedUser().isDeposit == INT_TRUE {
                    let vc = DepositViewController()
                    vc.hidesBottomBarWhenPushed = true
                    self.pushViewController(viewContoller: vc, animated: true)
                } else {
                    let vc = MyDepositViewController()
                    vc.hidesBottomBarWhenPushed = true
                    self.pushViewController(viewContoller: vc, animated: true)
                }
            } else if indexPath.row == 3 {
                let vc = MyIntegralViewController()
                vc.hidesBottomBarWhenPushed = true
                self.pushViewController(viewContoller: vc, animated: true)
            }
        } else if 1 == indexPath.section {
            if indexPath.row == 0 {
                let vc = ProgressWebViewController()
                vc.urlStr = kGuideUrl
                vc.hidesBottomBarWhenPushed = true
                self.pushViewController(viewContoller: vc, animated: true)
            } else if indexPath.row == 1 {
                let vc = ProgressWebViewController()
                vc.urlStr = kJoinUsUrl
                vc.hidesBottomBarWhenPushed = true
                self.pushViewController(viewContoller: vc, animated: true)
            } else if indexPath.row == 2 {
                if sharedGlobal.getToken().tokenExists {
                    let vc = SettingViewController()
                    vc.hidesBottomBarWhenPushed = true
                    self.pushViewController(viewContoller: vc, animated: true)
                } else {
                    self.showLoginViewController()
                }
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
