//
//  BookDetailViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 22/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

class BookDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var book: Book!
    private var viewModel = BookViewModel()
    private var commentList = [Comment]()
    private var pageInfo = PageInfo()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    // 立即购买
    private lazy var buyNowBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = kMainColor
        btn.titleLabel?.textColor = UIColor.white
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.setTitle("立即借阅", for: .normal)
        return btn
    }()
    
    // 加入书包按钮
    private lazy var addBagBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitleColor(kMainColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.setTitle("加入书包", for: .normal)
        return btn
    }()
    
    private lazy var shareBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setImage(UIImage.init(named: "xiangqing_btn_fenxiang"), for: .normal)
        return btn
    }()
    
    private lazy var bagBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setImage(UIImage.init(named: "xiangqing_btn_shubao"), for: .normal)
        return btn
    }()
    
    lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(BookDetailTableViewCell.self, forCellReuseIdentifier: kCellIdBookDetailTableViewCell)
        tableView.register(InfoDetailTableViewCell.self, forCellReuseIdentifier: kCellIdInfoDetailTableViewCell)
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: kCellIdCommentTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        getBookDetail()
        getBookComments(page: 1)
    }
    
    private func initSubviews() {
        self.title = "书籍详情"
        self.showBackButton()
        
        self.view.addSubview(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(kTabBarHeight)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setPullingHeader()
        self.tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.getBookDetail()
            self?.getBookComments(page: 1)
        }
        self.tableView.reloadBlock = {
            [weak self] (Void) in
            self?.getBookDetail()
            self?.getBookComments(page: 1)
        }
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(self.bottomView.snp.top)
            make.left.equalTo(0)
        }
        
        self.buyNowBtn.addTarget(self, action: #selector(buyNowBtnClicked), for: .touchUpInside)
        self.bottomView.addSubview(self.buyNowBtn)
        self.buyNowBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 120))
        }
        
        self.bottomView.addSubview(self.addBagBtn)
        self.addBagBtn.addTarget(self, action: #selector(self.addBookToBag), for: .touchUpInside)
        self.addBagBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(self.buyNowBtn.snp.left)
            make.bottom.equalTo(0)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 120))
        }
        
        let btnWidth = (kScreenWidth - scaleFromiPhone6Desgin(x: 240)) / 2
        self.bottomView.addSubview(self.shareBtn)
        self.shareBtn.addTarget(self, action: #selector(self.shareBtnClicked), for: .touchUpInside)
        self.shareBtn.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(btnWidth)
            make.bottom.equalTo(0)
        }
        
        self.bottomView.addSubview(self.bagBtn)
        self.bagBtn.addTarget(self, action: #selector(self.bagBtnClicked), for: .touchUpInside)
        self.bagBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.shareBtn.snp.right)
            make.top.equalTo(0)
            make.width.equalTo(btnWidth)
            make.bottom.equalTo(0)
        }
        
        let vLine1 = UIView()
        vLine1.backgroundColor = kMainBgColor
        self.bottomView.addSubview(vLine1)
        vLine1.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(self.shareBtn.snp.right)
            make.width.equalTo(1)
            make.bottom.equalTo(0)
        }
        
        let vLine2 = UIView()
        vLine2.backgroundColor = kMainBgColor
        self.bottomView.addSubview(vLine2)
        vLine2.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(self.bagBtn.snp.right)
            make.width.equalTo(1)
            make.bottom.equalTo(0)
        }
        
        let hLine = UIView()
        hLine.backgroundColor = kMainBgColor
        self.bottomView.addSubview(hLine)
        hLine.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(1)
            make.right.equalTo(0)
        }
    }
    
    @objc private func buyNowBtnClicked() {
        // 立即结算选中的书籍，跳转到提交订单页面
        let vc = ConfirmBookOrderViewController()
        var selectedBookList = [Book]()
        var book = self.book
        book?.bookCount = "1"
        selectedBookList.append(book!)
        vc.bookList = selectedBookList
        self.pushViewController(viewContoller: vc, animated: true)
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            row = commentList.count
        }
        
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdBookDetailTableViewCell, for: indexPath) as! BookDetailTableViewCell
                cell.setBook(book: self.book)
                cell.seeAnswerBlock = {
                    [weak self] (Void) in
                    let vc = ProgressWebViewController()
                    vc.urlStr = (self?.book.bookFile)!
                    self?.pushViewController(viewContoller: vc, animated: true)
                }
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdInfoDetailTableViewCell, for: indexPath) as! InfoDetailTableViewCell
            cell.titleLbl.text = "书籍详情"
            cell.detailLbl.text = self.book.introduce
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdCommentTableViewCell, for: indexPath) as! CommentTableViewCell
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
            let comment = self.commentList[indexPath.row]
            cell.setComment(comment: comment)
            cell.userBlock = {
                [weak self] (user) in
                let vc = OthersHomeViewController()
                vc.user = user
                self?.pushViewController(viewContoller: vc, animated: true)
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                return BookDetailTableViewCell.cellHeight()
            }
            return InfoDetailTableViewCell.cellHeightWithStr(str: self.book.introduce)
        } else {
            let comment = self.commentList[indexPath.row]
            return CommentTableViewCell.cellHeightWithComment(comment: comment)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if 1 == indexPath.section {
            let comment = self.commentList[indexPath.row]
            let vc = BookCommentDetailViewController()
            vc.bookId = self.book.id
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
    
    // MARK: - Private
    @objc private func seeAllComments() {
        if nil == self.book {
            return
        }
        let vc = BookCommentListViewController()
        vc.bookId = self.book.id
        self.pushViewController(viewContoller: vc, animated: true)
        
    }
    
    // 将书加入到书包
    @objc private func addBookToBag() {
        self.viewModel.addShopCar(bookId: self.book.id, bookCount: 1, success: { [weak self] (data) in
            self?.showHudTipStr("加入成功")
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    @objc private func bagBtnClicked() {
        let vc = BagViewController()
        self.pushViewController(viewContoller: vc, animated: true)
    }
    
    @objc private func shareBtnClicked() {
        
        UMSocialUIManager.showShareMenuViewInWindow { (platformType, userInfo) in
            // 根据获取的platformType确定所选平台进行下一步操作
        }
    }
    
    // MARK: - Networking
    private func getBookDetail() {
        self.viewModel.getBookDetail(bookId: self.book.id, cache: { [weak self] (data) in
            self?.book = Book.fromJSON(json: data.object)
            self?.tableView.reloadData()
        }, success: { [weak self] (data) in
            self?.book = Book.fromJSON(json: data.object)
            self?.tableView.reloadData()
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    // 获取资料评论
    private func getBookComments(page: Int) {
        
        self.viewModel.getBookComment(bookId: self.book.id, page: page, cache: { [weak self] (data) in
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
