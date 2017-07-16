//
//  DataDetailViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 16/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class DataDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var document: Document!
    private var viewModel: DocumentViewModel = DocumentViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(DocumentTableViewCell.self, forCellReuseIdentifier: kCellIdDocumentTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        getDocumentDetail()
    }
    
    private func initSubviews() {
        self.title = "资料详情"
        self.showBackButton()
        
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
    }
    
    private func getDocumentDetail() {
        
        if nil == self.document {
            return
        }
        
        self.viewModel.getDocumentDetail(documentId: self.document.id, cache: { [weak self] (data) in
            
            self?.document = Document.fromJSON(json: data.object)
            
        }, success: { [weak self] (data) in
            
            self?.document = Document.fromJSON(json: data.object)
            
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdDocumentTableViewCell, for: indexPath) as! DocumentTableViewCell
        tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DocumentTableViewCell.cellHeight()
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
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
