//
//  PrivacySettingsViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 05/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class PrivacySettingsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var viewComment = 0
    private var viewBorrow = 0
    private var viewModel: UserViewModel = UserViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: kCellIdSwitchTableViewCell)
        tableView.backgroundColor = kMainBgColor
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }
    
    private func initSubviews() {
        self.title = "隐私设置"
        self.showBackButton()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        if sharedGlobal.getToken().tokenExists {
            self.viewBorrow = sharedGlobal.getSavedUser().viewBorrow
            self.viewComment = sharedGlobal.getSavedUser().viewComment
        }
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSwitchTableViewCell, for: indexPath) as! SwitchTableViewCell
        
        if 0 == indexPath.section {
            cell.textLabel?.text = "不让其他人看我借阅的书籍"
            cell.switchBtnBlock = {
                [weak self] (on) in
                self?.viewBorrow = on ? 1 : 0
                self?.privacySettings()
            }
            cell.setOn(on: self.viewBorrow)
        } else if 1 == indexPath.section {
            cell.textLabel?.text = "不然其他人看我的评论"
            cell.switchBtnBlock = {
                [weak self] (on) in
                self?.viewComment = on ? 1 : 0
                self?.privacySettings()
            }
            cell.setOn(on: self.viewComment)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SwitchTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return kBasePadding
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kBasePadding))
        view.backgroundColor = kMainBgColor
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - NetWorking
    private func privacySettings() {
        
        self.showHudLoadingTipStr("")
        
        self.viewModel.privacySettings(viewComment: self.viewComment, viewBorrow: self.viewBorrow, success: { [weak self] (data) in
            self?.showHudTipStr("设置成功")
            
            let user = User.fromJSON(json: data.object)
            
            sharedGlobal.saveUser(user: user)
            
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) {
            
        }
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
