//
//  DataDetailViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 16/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class DataDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var document: Document!
    private var viewModel: DocumentViewModel = DocumentViewModel()
    private var commentList = [Comment]()
    private var pageInfo = PageInfo()
    
    private lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(DocumentTableViewCell.self, forCellReuseIdentifier: kCellIdDocumentTableViewCell)
        tableView.register(InfoDetailTableViewCell.self, forCellReuseIdentifier: kCellIdInfoDetailTableViewCell)
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: kCellIdCommentTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()
    
    // 打开文档按钮
    private lazy var openBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = kMainColor
        btn.titleLabel?.textColor = UIColor.white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.setTitle("打开文档", for: .normal)
        return btn
    }()
    
    // 打印按钮
    private lazy var printBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitleColor(kMainColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.setTitle("加入打印", for: .normal)
        return btn
    }()
    
    // 提示Lable
    private lazy var tipsLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor(hex: 0x555555)
        return lbl
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        self.getDocumentDetail()
        self.getDocumentComments(page: 1)
    }
    
    private func initSubviews() {
        self.title = "资料详情"
        self.showBackButton()
        
        self.view.addSubview(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(kTabBarHeight)
        }
        
        self.view.addSubview(self.tableView)
        self.tableView.setPullingHeader()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.getDocumentDetail()
            self?.getDocumentComments(page: 1)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(self.bottomView.snp.top)
            make.left.equalTo(0)
        }
        
        self.bottomView.addSubview(self.openBtn)
        self.openBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 120))
        }
        
        self.bottomView.addSubview(self.printBtn)
        self.printBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(self.openBtn.snp.left)
            make.bottom.equalTo(0)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 120))
        }
        
        let vLine = UIView()
        vLine.backgroundColor = kMainBgColor
        self.bottomView.addSubview(vLine)
        vLine.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(self.printBtn.snp.left)
            make.width.equalTo(1)
            make.bottom.equalTo(0)
        }
        
        self.tipsLbl.text = "需要1积分"
        self.bottomView.addSubview(self.tipsLbl)
        self.tipsLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.centerY.equalTo(self.bottomView.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(vLine.snp.left).offset(-8)
        }
        
    }
    
    // 获取资料评论
    private func getDocumentComments(page: Int) {
        
        self.viewModel.getDocumentComment(documentId: self.document.id, page: page, cache: { [weak self] (data) in
            self?.updateCommentData(data: data)
        }, success: { [weak self] (data) in
            self?.updateCommentData(data: data)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func updateCommentData(data: JSON) {
        if JSON.null == data {
            return
        }
        
        self.pageInfo = PageInfo.fromJSON(json: data["pageInfo"])
        let comments = Comment.fromJSONArray(json: data["entities"].arrayObject!)
        
        if self.pageInfo.currentPage == 1 {
            self.commentList.removeAll()
        }
        
        if comments.count > 0 {
            for comment in comments {
                self.commentList.append(comment)
            }
        }
        
        if nil != self.tableView.mj_header {
            self.tableView.mj_header.endRefreshing()
        }
        
        self.tableView.reloadData()
    }
    
    // 获取资料详情
    private func getDocumentDetail() {
        
        if nil == self.document {
            return
        }
        
        self.viewModel.getDocumentDetail(documentId: self.document.id, cache: { [weak self] (data) in
            
            self?.document = Document.fromJSON(json: data.object)
            self?.reloadDatas()
            
        }, success: { [weak self] (data) in
            
            self?.document = Document.fromJSON(json: data.object)
            self?.reloadDatas()
            
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func reloadDatas() {
        self.tipsLbl.text = "需要" + self.document.needIntegral + "积分"
        self.tableView.reloadData()
    }
    
    @objc private func seeAllComments() {
        if nil == self.document {
            return
        }
        let vc = DocumentCommentListViewController()
        vc.documentId = self.document.id
        self.pushViewController(viewContoller: vc, animated: true)
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var row = 0
        if 0 == section {
            row = 2
        } else if 1 == section {
            row = self.commentList.count
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdDocumentTableViewCell, for: indexPath) as! DocumentTableViewCell
                tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
                cell.setDocument(document: self.document)
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdInfoDetailTableViewCell, for: indexPath) as! InfoDetailTableViewCell
            cell.titleLbl.text = "资料简介"
            cell.detailLbl.text = self.document.introduce
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdCommentTableViewCell, for: indexPath) as! CommentTableViewCell
            let comment = self.commentList[indexPath.row]
            cell.setComment(comment: comment)
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                return DocumentTableViewCell.cellHeight()
            }
            return InfoDetailTableViewCell.cellHeightWithStr(str: self.document.introduce)
        } else {
            let comment = self.commentList[indexPath.row]
            return CommentTableViewCell.cellHeightWithComment(comment: comment)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if 1 == indexPath.section {
            let comment = self.commentList[indexPath.row]
            let vc = DocumentCommentDetailViewController()
            vc.documentId = self.document.id
            vc.comment = comment
            self.pushViewController(viewContoller: vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return scaleFromiPhone6Desgin(x: 40)
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: scaleFromiPhone6Desgin(x: 40)))
            view.backgroundColor = .white
            
            let tipsLbl = UILabel()
            tipsLbl.font = UIFont.systemFont(ofSize: 14)
            tipsLbl.textColor = UIColor(hex: 0x555555)
            tipsLbl.textAlignment = .left
            tipsLbl.text = String.init(format: "全部评价（%d）", self.pageInfo.allNum)
            view.addSubview(tipsLbl)
            tipsLbl.snp.makeConstraints({ (make) in
                make.left.equalTo(kBasePadding)
                make.top.equalTo(0)
                make.bottom.equalTo(0)
                make.right.equalTo(-scaleFromiPhone6Desgin(x: 40))
            })
            
            let arrowImg = UIImageView()
            arrowImg.image = UIImage(named: "xiangqing_btn_xiti")
            arrowImg.contentMode = .scaleAspectFit
            arrowImg.clipsToBounds = true
            view.addSubview(arrowImg)
            arrowImg.snp.makeConstraints({ (make) in
                make.right.equalTo(-kBasePadding)
                make.centerY.equalTo(view.snp.centerY)
                make.width.equalTo(scaleFromiPhone6Desgin(x: 9))
                make.height.equalTo(scaleFromiPhone6Desgin(x: 16))
            })
            
            let line = UIView()
            line.backgroundColor = kMainBgColor
            view.addSubview(line)
            line.snp.makeConstraints({ (make) in
                make.bottom.equalTo(0)
                make.height.equalTo(1)
                make.left.equalTo(0)
                make.right.equalTo(0)
            })
            
            let seeAllBtn = UIButton()
            seeAllBtn.backgroundColor = .clear
            view.addSubview(seeAllBtn)
            seeAllBtn.addTarget(self, action: #selector(seeAllComments), for: .touchUpInside)
            seeAllBtn.snp.makeConstraints({ (make) in
                make.bottom.equalTo(0)
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.top.equalTo(0)
            })
            
            return view
        }
        return nil
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
