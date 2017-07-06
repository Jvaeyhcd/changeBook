//
//  SettingViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 28/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import HcdActionSheet
import SDWebImage

class SettingViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate lazy var viewModel = UserViewModel()
    fileprivate var savedUser = sharedGlobal.getSavedUser()
    
    //图片上传成功后返回的地址
    var imgBackUrl = ""
    //性别
    var sexSelected = MAN
    //昵称
    var userName = ""
    //个人介绍
    var introduce = ""
    
    //fileprivate上传的图片
    fileprivate var uploadImg : UIImage?
    
    fileprivate var choseSexSheet : HcdActionSheet = {
        let sheet = HcdActionSheet.init(cancelStr: "取消", otherButtonTitles: ["男", "女"], attachTitle: "更换性别")
        return sheet!
    }()
    
    fileprivate var choseHeadSheet: HcdActionSheet = {
        let sheet = HcdActionSheet.init(cancelStr: "取消", otherButtonTitles: ["拍照", "从手机相册选择"], attachTitle: "修改头像")
        return sheet!
    }()
    
    //注销时弹出的选择提示框
    fileprivate var loginOutSheet: HcdActionSheet = {
        let sheet = HcdActionSheet.init(cancelStr: "取消", otherButtonTitles: ["退出登录"], attachTitle: "您确定要退出登录吗？")
        return sheet!
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: kCellIdSettingTableViewCell)
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: kCellIdButtonTableViewCell)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = .none
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    // MARK: - private function
    
    // 修改用户信息
    private func changeUserInfo(headPic:String,
                                nickName:String,
                                sex:String,
                                introduce:String) {
        self.view.endEditing(true)
        
        self.showHudLoadingTipStr("")
        
        self.viewModel.changeUserInfo(headPic: headPic, nickName: nickName, sex: sex, introduce: introduce, success: { [weak self] (data) in
            self?.hideHud()
            self?.savedUser = User.fromJSON(json: data["user"].object)
            sharedGlobal.saveUser(user: (self?.savedUser)!)
            
            self?.uploadImg = nil
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshUserInfo"), object: nil)
            
            self?.tableView.reloadData()
            
        }, fail: { [weak self] (message) in
            self?.hideHud()
            self?.showHudTipStr(message)
        }) { 
            self.hideHud()
        }
    }
    
    // 获取用户信息
    private func getUserInfo() {
        self.viewModel.getUserInfo(success: { (data) in
            self.savedUser = User.fromJSON(json: data["user"].object)
            sharedGlobal.saveUser(user: self.savedUser)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshUserInfo"), object: nil)
            
            self.tableView.reloadData()
        }, fail: { [weak self] (message) in
            self!.showHudTipStr(message)
        }) { 
            
        }
    }
    
    // 退出用户登录
    private func userLogout() {
        self.showHudLoadingTipStr("")
        self.viewModel.logoutAccount(success: { [weak self] (data) in
            self?.hideHud()
            sharedGlobal.clearUser()
            
            // 发送退出登录成功的通知，然后在其他地方做相关的处理
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "logoutSuccess"), object: nil)
            
            // 返回到navagationController的根目录
            self?.navigationController?.popToRootViewController(animated: true)
        }) { [weak self] (message) in
            self?.showHudTipStr(message)
        }
    }
    
    private func initSubviews() {
        self.title = "个人设置"
        self.showBackButton()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
        
        self.choseHeadSheet.selectButtonAtIndex = {
            [weak self] index in
            if 1 == index{
                //拍照
            }else if 2 == index{
                //相册
            }
        }
        
        self.choseSexSheet.selectButtonAtIndex = {
            [weak self] index in
            let oldSex = self?.savedUser.sex
            if 1 == index {
                self?.sexSelected = MAN
            } else if 2 == index {
                self?.sexSelected = WOMAN
            }
            if oldSex != self?.sexSelected {
                self?.changeUserInfo(headPic: (self?.imgBackUrl)!, nickName: (self?.userName)!, sex: (self?.sexSelected)!, introduce: (self?.introduce)!)
            }
        }
        
        self.loginOutSheet.selectButtonAtIndex = {
            [weak self] index in
            if 1 == index {
                self?.userLogout()
            }
        }
    }
    
    //按钮点击事件
    func btnClick() {
        UIApplication.shared.keyWindow?.addSubview(self.loginOutSheet)
        self.loginOutSheet.show()
        
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0;
        if section == 0 {
            row = 6
        } else if section == 1 {
            row = 2
        } else if section == 2 {
            row = 1
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSettingTableViewCell, for: indexPath) as! SettingTableViewCell
            if indexPath.row == 0 {
                cell.titleLbl.text = "头像"
                cell.descLbl.isHidden = true
                cell.portraitImageView.isHidden = false
                cell.portraitImageView.sd_setImage(with: URL(string: self.savedUser.headPic), placeholderImage: kUserDefaultImage)
            } else if indexPath.row == 1 {
                cell.titleLbl.text = "昵称"
                cell.descLbl.isHidden = false
                cell.portraitImageView.isHidden = true
                cell.descLbl.text = self.savedUser.nickName
            } else if indexPath.row == 2 {
                cell.titleLbl.text = "性别"
                cell.descLbl.isHidden = false
                cell.portraitImageView.isHidden = true
                if self.savedUser.sex == MAN {
                    self.sexSelected = MAN
                    cell.descLbl.text = "男"
                } else {
                    self.sexSelected = WOMAN
                    cell.descLbl.text = "女"
                }
            } else if indexPath.row == 3 {
                cell.titleLbl.text = "学校"
                cell.descLbl.isHidden = false
                cell.portraitImageView.isHidden = true
            } else if indexPath.row == 4 {
                cell.titleLbl.text = "地址"
                cell.descLbl.isHidden = false
                cell.portraitImageView.isHidden = true
            } else if indexPath.row == 5 {
                cell.titleLbl.text = "个人简介"
                cell.descLbl.isHidden = false
                cell.portraitImageView.isHidden = true
            }
            cell.accessoryType = .disclosureIndicator
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: kBasePadding)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSettingTableViewCell, for: indexPath) as! SettingTableViewCell
            if indexPath.row == 0 {
                cell.titleLbl.text = "清除缓存"
                cell.descLbl.isHidden = false
                cell.portraitImageView.isHidden = true
            } else if indexPath.row == 1 {
                cell.titleLbl.text = "修改密码"
                cell.descLbl.isHidden = false
                cell.portraitImageView.isHidden = true
            }
            cell.accessoryType = .disclosureIndicator
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: kBasePadding)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdButtonTableViewCell, for: indexPath) as! ButtonTableViewCell
            cell.btnSure.setTitle("退出登录", for: .normal)
            cell.selectionStyle = .none
            cell.backgroundColor = kMainBgColor
            cell.btnSure.addTarget(self, action: #selector(btnClick), for: UIControlEvents.touchUpInside)
            return cell
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat(0)
        } else if section == 2 {
            return CGFloat(0)
        }
        return kBasePadding
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewBottom = UIView()
        viewBottom.backgroundColor = kMainBgColor
        viewBottom.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kBasePadding)
        return viewBottom
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                // 修改头像
                UIApplication.shared.keyWindow?.addSubview(self.choseHeadSheet)
                self.choseHeadSheet.show()
            } else if 1 == indexPath.row {
                // 修改昵称
            } else if 2 == indexPath.row {
                // 修改性别
                UIApplication.shared.keyWindow?.addSubview(self.choseSexSheet)
                self.choseSexSheet.show()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return ButtonTableViewCell.cellHeight()
        }
        return SettingTableViewCell.cellHeight()
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
