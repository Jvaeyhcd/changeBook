//
//  HotDataListViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 05/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class HotDataListViewController: BaseTableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedDocumentBlock: ((Document)->())!
    fileprivate lazy var viewModel = DocumentViewModel()
    fileprivate var documentList = [Document]()
    
    var parentVC: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = kMainColor

        let view = UIView.init(frame: CGRect.init(x: 0,
                                                  y: 0,
                                                  width: kScreenWidth,
                                                  height: kHomeHeadViewHeight))
        view.backgroundColor = kMainBgColor
        tableView.tableHeaderView = view
        tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: kHomeHeadViewHeight,
                                                                   left: 0,
                                                                   bottom: 0,
                                                                   right: 0)
        
        self.tableView.register(DataListTableViewCell.self, forCellReuseIdentifier: kCellIdDataListTableViewCell)
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
        
        self.getHotDocument()
    }
    
    // MARK: - private
    private func getHotDocument() {
        
        self.viewModel.getHotDocument(cache: { [weak self] (data) in
            self?.updateHotDocument(data: data)
        }, success: { [weak self] (data) in
            self?.updateHotDocument(data: data)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func updateHotDocument(data: JSON) {
        
        self.documentList = Document.fromJSONArray(json: data.arrayObject!)
        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.contentOffset.y = self.tableViewOffsetY
    }

    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.documentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdDataListTableViewCell, for: indexPath) as! DataListTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        
        let document = self.documentList[indexPath.row]
        cell.setDocument(document: document)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DataListTableViewCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let document = self.documentList[indexPath.row]
        if nil != self.selectedDocumentBlock {
            self.selectedDocumentBlock(document)
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
