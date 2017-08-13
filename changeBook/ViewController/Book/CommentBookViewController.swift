//
//  CommentBookViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 03/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class CommentBookViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var book: Book!
    
    private var star: String = "5"
    private var comment: String = ""
    private var viewModel: BookViewModel = BookViewModel()
    
    lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(BookListTableViewCell.self, forCellReuseIdentifier: kCellIdBookListTableViewCell)
        tableView.register(RateStarTableViewCell.self, forCellReuseIdentifier: kCellIdRateStarTableViewCell)
        tableView.register(PlaceHolderViewTableViewCell.self, forCellReuseIdentifier: kCellIdPlaceHolderViewTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
    }

    private func initSubviews() {
        self.title = "评价书籍"
        self.showBackButton()
        self.showBarButtonItem(position: RIGHT, withStr: "提交")
        
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
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        self.commentBook()
    }
    
    private func commentBook() {
        
        self.view.endEditing(true)
        
        self.showHudLoadingTipStr("")
        
        self.viewModel.addBookComment(bookId: self.book.bookId, content: self.comment, commentType: kCommentLv1, score: self.star, bookCommentId: "0", receiverId: "0", orderDetailId: self.book.id, success: { [weak self] (data) in
                self?.showHudTipStr("评价成功")
                self?.popViewController(animated: true)
            }, fail: { [weak self] (message) in
                self?.showHudTipStr(message)
        }) {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if 0 == indexPath.section {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdBookListTableViewCell, for: indexPath) as! BookListTableViewCell
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
            
            cell.setBook(book: self.book)
            
            return cell
        } else if 1 == indexPath.section {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdRateStarTableViewCell, for: indexPath) as! RateStarTableViewCell
            cell.rateStarView.value = CGFloat(self.star.floatValue)
            cell.starValueChangedBlock = {
                [weak self] (value) in
                self?.star = String.init(format: "%f", value)
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdPlaceHolderViewTableViewCell, for: indexPath) as! PlaceHolderViewTableViewCell
        cell.textChangedBlock = {
            [weak self] (str) in
            self?.comment = str
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if 0 == indexPath.section {
            return BookListTableViewCell.cellHeight()
        } else if 1 == indexPath.section {
            return RateStarTableViewCell.cellHeight()
        }
        return PlaceHolderViewTableViewCell.cellHeight()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
