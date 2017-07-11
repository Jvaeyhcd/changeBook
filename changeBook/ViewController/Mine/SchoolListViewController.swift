//
//  SchoolListViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 11/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class SchoolListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var changeSchoolBlock: ((School)->())!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(SchoolListTableViewCell.self, forCellReuseIdentifier: kCellIdSchoolListTableViewCell)
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    private var viewModel = UserViewModel()
    private var schoolList = [School]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        getSchoolList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func initSubviews() {
        self.title = "选择学校"
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
    }
    
    // 获取学校列表
    private func getSchoolList() {
        self.viewModel.getSchoolList(cache: { [weak self] (data) in
            self?.updateListData(data: data)
        }, success: { [weak self] (data) in
            self?.updateListData(data: data)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    // 设置学校
    private func bindSchool(school: School) {
        self.showHudLoadingTipStr("")
        self.viewModel.bindSchool(schoolId: school.id, success: { [weak self] (data) in
            self?.hideHud()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshUserInfo"), object: nil)
            
            if nil != self?.changeSchoolBlock {
                self?.changeSchoolBlock(school)
            }
            
            self?.popViewController(animated: true)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func updateListData(data: JSON) {
        if JSON.null == data {
            return
        }
        self.schoolList = School.fromJSONArray(json: data.arrayObject!)
        self.tableView.reloadData()
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        
    }
    
    // MAKR: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.schoolList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdSchoolListTableViewCell, for: indexPath) as! SchoolListTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: kBasePadding)
        
        let school = self.schoolList[indexPath.row]
        cell.titleLbl.text = school.schoolName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SchoolListTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let school = self.schoolList[indexPath.row]
        self.bindSchool(school: school)
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
