//
//  BagViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 14/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON
import HcdActionSheet

class BagViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var deleteActionSheet: HcdActionSheet = {
        let sheet = HcdActionSheet.init(cancelStr: "取消", otherButtonTitles: ["是"], attachTitle: "您确定要从书包中删除这些书籍？")
        return sheet!
    }()
    
    private var viewModel: BookViewModel = BookViewModel()
    private var bookList: [Book] = [Book]()
    // 选中购物车的index
    private var selectedIndex = [Int]()
    // 选中要删除的index
    private var delectedIndex = [Int]()
    // 是否是在编辑购物车的状态下
    private var isEdit: Bool = false
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var okBtn: UIButton = {
        let btn = UIButton()
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
    
    lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
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
        getBagList()
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
        
        self.okBtn.addTarget(self, action: #selector(okBtnClicked), for: .touchUpInside)
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
        
        self.totalLbl.text = ""
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
        self.tableView.setPullingHeader()
        self.tableView.headerRefreshBlock = {
            self.getBagList()
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(self.bottomView.snp.top)
            make.left.equalTo(0)
        }
        
        self.deleteActionSheet.selectButtonAtIndex = {
            [weak self] (index) in
            if index == 1 {
                self?.deleteBagsBook()
            }
        }
    }
    
    // MARK: - Networking
    private func getBagList() {
        self.viewModel.getShopCar(success: { [weak self] (data) in
            self?.updateDatas(data: data)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func updateDatas(data: JSON) {
        if JSON.null == data {
            return
        }
        
        let books = Book.fromJSONArray(json: data["entities"].arrayObject!)
        
        self.bookList.removeAll()
        
        if books.count > 0 {
            for book in books {
                self.bookList.append(book)
            }
        }
        
        if nil != self.tableView.mj_header {
            self.tableView.mj_header.endRefreshing()
        }
        
        self.tableView.reloadData()
    }
    
    private func deleteBagsBook() {
        
        var bookIdList = [Int]()
        for i in self.delectedIndex {
            bookIdList.append(self.bookList[i].id.intValue)
        }
        
        BLog(log: "\(bookIdList)")
        self.showHudLoadingTipStr("")
        self.viewModel.deleteShopCar(shopCarIdList: "\(bookIdList)", success: { [weak self] (data) in
            self?.showHudTipStr("删除成功")
            self?.delectedIndex.removeAll()
            self?.selectedIndex.removeAll()
            self?.getBagList()
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func changeBookCount(book: Book) {
        
        self.view.endEditing(true)
        
        self.showHudLoadingTipStr("")
        self.viewModel.updateShopCar(bookId: book.id, bookCount: book.bookCount.intValue, success: { [weak self] (data) in
            
            let book = Book.fromJSON(json: data.object)
            
            for i in 0..<(self?.bookList.count)! {
                let b = self?.bookList[i]
                if book.bookId == b?.bookId {
                    self?.bookList[i] = book
                }
            }
            
            self?.hideHud()
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        
        self.isEdit = !self.isEdit
        
        self.rightBtn.isSelected = self.isEdit
        self.okBtn.isSelected = self.isEdit
        
        if true == self.isEdit {
            BLog(log: "现在是编辑状态")
            self.totalLbl.isHidden = true
            self.okBtn.setTitle("删除", for: .normal)
        } else {
            BLog(log: "现在是非编辑状态")
            self.totalLbl.isHidden = false
            self.totalLbl.text = "共3本书"
            self.okBtn.setTitle("立即结算", for: .normal)
        }
        
        self.tableView.reloadData()
        
        self.allBtn.isSelected = false
        
    }
    
    private func updateAllSubviews() {
        self.tableView.reloadData()
        
        // 判断是否全都选中了
        if self.isEdit {
            if self.delectedIndex.count == self.bookList.count {
                self.allBtn.isSelected = true
            } else {
                self.allBtn.isSelected = false
            }
        } else {
            if self.selectedIndex.count == self.bookList.count {
                self.allBtn.isSelected = true
            } else {
                self.allBtn.isSelected = false
            }
        }
    }
    
    func allBtnClicked() {
        self.allBtn.isSelected = !self.allBtn.isSelected
        
        if self.allBtn.isSelected {
            if self.isEdit {
                self.delectedIndex.removeAll()
                for i in 0..<self.bookList.count {
                    self.delectedIndex.append(i)
                }
            } else {
                self.selectedIndex.removeAll()
                for i in 0..<self.bookList.count {
                    self.selectedIndex.append(i)
                }
            }
        } else {
            if self.isEdit {
                self.delectedIndex.removeAll()
            } else {
                self.selectedIndex.removeAll()
            }
        }
        
        self.updateAllSubviews()
    }
    
    func okBtnClicked() {
        if self.isEdit {
            // 删除选中的书籍
            UIApplication.shared.keyWindow?.addSubview(self.deleteActionSheet)
            self.deleteActionSheet.show()
            
        } else {
            // 立即结算选中的书籍，跳转到提交订单页面
            
        }
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdBagTableViewCell, for: indexPath) as! BagTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        
        let book = self.bookList[indexPath.row]
        cell.setBook(book: book)
        cell.setSelected(selected: checkIsSelected(index: indexPath.row))
        cell.bookChangedBlock = {
            [weak self] (book) in
            
            BLog(log: "bookName = " + book.bookName)
            self?.changeBookCount(book: book)
        }
        
        return cell
    }
    
    // 检测Cell是否是被选中的
    private func checkIsSelected(index: Int) -> Bool {
        var selected = false
        
        if self.isEdit {
            
            for j in 0..<self.delectedIndex.count {
                if index == self.delectedIndex[j] {
                    selected = true
                    break
                }
            }
        } else {
            for i in 0..<self.selectedIndex.count {
                if index == self.selectedIndex[i] {
                    selected = true
                    break
                }
            }
        }
        
        return selected
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BagTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let index = indexPath.row
        var flag = true
        
        if self.isEdit {
            for j in 0..<self.delectedIndex.count {
                if index == self.delectedIndex[j] {
                    flag = false
                    self.delectedIndex.remove(at: j)
                    break
                }
            }
            if flag {
                self.delectedIndex.append(index)
            }
            
        } else {
            for i in 0..<self.selectedIndex.count {
                if index == self.selectedIndex[i] {
                    flag = false
                    self.selectedIndex.remove(at: i)
                    break
                }
            }
            if flag {
                self.selectedIndex.append(index)
            }
        }
        
        self.updateAllSubviews()
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
