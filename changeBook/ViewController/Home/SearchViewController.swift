//
//  SearchViewController.swift
//  changeBook
//
//  Created by Jvaeyhcd on 13/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import SwiftyJSON

let SECTION_BOOK = 0
let SECTION_ARTICLE = 1
let SECTION_DOCUMENT = 2

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var keyWords: String = ""
    private var searchBar: UISearchBar!
    private var viewModel: OtherViewModel = OtherViewModel()
    private var articleList = [Article]()
    private var documentList = [Document]()
    private var bookList = [Book]()
    
    lazy var tableView: UIRefreshTableView = {
        let tableView = UIRefreshTableView.init(frame: CGRect.zero, style: .plain)
        tableView.register(ArticleListTableViewCell.self, forCellReuseIdentifier: kCellIdArticleListTableViewCell)
        tableView.register(DataListTableViewCell.self, forCellReuseIdentifier: kCellIdDataListTableViewCell)
        tableView.register(BookListTableViewCell.self, forCellReuseIdentifier: kCellIdBookListTableViewCell)
        tableView.separatorStyle = .none
        tableView.backgroundColor = kMainBgColor
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        initSubviews()
        initSearchView()
        
        if "" != self.keyWords {
            self.searchBar.text = self.keyWords
            self.searchContent()
        }
    }
    
    private func initSubviews() {
        self.showBackButton()
        self.showBarButtonItem(position: RIGHT, withStr: "搜索")
        
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.setPullingHeader()
        self.tableView.headerRefreshBlock = {
            [weak self] (Void) in
            self?.searchContent()
        }
        
        self.tableView.reloadBlock = {
            [weak self] (Void) in
            self?.searchContent()
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
        }
    }
    
    private func initSearchView() {
        let titleView = UIView()
        titleView.py_x = CGFloat(PYSEARCH_MARGIN) * 0.5
        titleView.py_y = 7
        titleView.py_width = self.view.py_width - 64 - titleView.py_x * 2
        titleView.py_height = 30
        
        let search = UISearchBar.init(frame: titleView.bounds)
        titleView.addSubview(search)
        
        titleView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        self.navigationItem.titleView = titleView
        
        // close autoresizing
        search.translatesAutoresizingMaskIntoConstraints = false
        let widthCons: NSLayoutConstraint = NSLayoutConstraint.init(item: search, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: titleView, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0)
        let heightCons: NSLayoutConstraint = NSLayoutConstraint.init(item: search, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: titleView, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 0)
        let xCons: NSLayoutConstraint = NSLayoutConstraint.init(item: search, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: titleView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
        let yCons: NSLayoutConstraint = NSLayoutConstraint.init(item: search, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: titleView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0)
        
        titleView.addConstraint(widthCons)
        titleView.addConstraint(heightCons)
        titleView.addConstraint(xCons)
        titleView.addConstraint(yCons)
        
        self.searchBar = search
        self.searchBar.delegate = self
        
        search.barStyle = .default
        search.placeholder = "请输入关键字搜索"
        search.backgroundImage = Bundle.py_imageNamed("bgImage")
        
    }
    
    override func leftNavBarButtonClicked() {
        self.popViewController(animated: true)
    }
    
    override func rightNavBarButtonClicked() {
        if "" == self.keyWords {
            self.showHudTipStr("请输入搜索内容")
            return
        }
        
        self.tableView.resignFirstResponder()
        self.searchContent()
    }
    
    // MARK: - Networking
    private func searchContent() {
        self.viewModel.searchContent(keyWords: self.keyWords, success: { [weak self] (data) in
            self?.updateSearchData(data: data)
        }, fail: { [weak self] (message) in
            self?.showHudTipStr(message)
        }) { 
            
        }
    }
    
    private func updateSearchData(data: JSON) {
        if JSON.null == data {
            return
        }
        
        self.articleList = Article.fromJSONArray(json: data["articleList"].arrayObject!)
        self.documentList = Document.fromJSONArray(json: data["documentList"].arrayObject!)
        self.bookList = Book.fromJSONArray(json: data["bookList"].arrayObject!)
        
        if nil != self.tableView.mj_header {
            self.tableView.mj_header.endRefreshing()
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if SECTION_BOOK == section {
            row = self.bookList.count
        } else if SECTION_ARTICLE == section {
            row = self.articleList.count
        } else if SECTION_DOCUMENT == section {
            row = self.documentList.count
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if SECTION_BOOK == indexPath.section {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdBookListTableViewCell, for: indexPath) as! BookListTableViewCell
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
            let book = self.bookList[indexPath.row]
            cell.setBook(book: book)
            return cell
        } else if SECTION_ARTICLE == indexPath.section {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdArticleListTableViewCell, for: indexPath) as! ArticleListTableViewCell
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
            let article = self.articleList[indexPath.row]
            cell.setArticle(article: article)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdDataListTableViewCell, for: indexPath) as! DataListTableViewCell
            tableView.addLineforPlainCell(cell: cell, indexPath: indexPath, leftSpace: 0)
            
            let document = self.documentList[indexPath.row]
            cell.setDocument(document: document)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat(0)
        if SECTION_BOOK == indexPath.section {
            height = BookListTableViewCell.cellHeight()
        } else if SECTION_ARTICLE == indexPath.section {
            height = ArticleListTableViewCell.cellHeight()
        } else if SECTION_DOCUMENT == indexPath.section {
            height = DataListTableViewCell.cellHeight()
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if SECTION_BOOK == indexPath.section {
            let book = self.bookList[indexPath.row]
            // 跳转到书籍详情页面
            let vc = BookDetailViewController()
            vc.book = book
            self.pushViewController(viewContoller: vc, animated: true)
        } else if SECTION_ARTICLE == indexPath.section {
            let article = self.articleList[indexPath.row]
            let vc = ArticleDetailViewController()
            vc.article = article
            vc.hidesBottomBarWhenPushed = true
            self.pushViewController(viewContoller: vc, animated: true)
        } else if SECTION_DOCUMENT == indexPath.section {
            let document = self.documentList[indexPath.row]
            let vc = DataDetailViewController()
            vc.document = document
            self.pushViewController(viewContoller: vc, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        var height = CGFloat(0)
        switch section {
        case SECTION_ARTICLE:
            if self.articleList.count > 0 {
                height = kBasePadding + scaleFromiPhone6Desgin(x: 40)
            }
        case SECTION_DOCUMENT:
            if self.documentList.count > 0 {
                height = kBasePadding + scaleFromiPhone6Desgin(x: 40)
            }
        case SECTION_BOOK:
            if self.bookList.count > 0 {
                height = kBasePadding + scaleFromiPhone6Desgin(x: 40)
            }
        default:
            height = CGFloat(0)
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kBasePadding + scaleFromiPhone6Desgin(x: 40)))
        
        let topView = UIView()
        topView.backgroundColor = kMainBgColor
        view.addSubview(topView)
        topView.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(kBasePadding)
        })
        
        let tipsLbl = UILabel()
        tipsLbl.font = UIFont.systemFont(ofSize: 14)
        tipsLbl.textColor = UIColor(hex: 0x555555)
        tipsLbl.textAlignment = .left
        tipsLbl.text = "学生证/一卡通照片"
        view.addSubview(tipsLbl)
        tipsLbl.snp.makeConstraints({ (make) in
            make.top.equalTo(topView.snp.bottom)
            make.right.equalTo(-kBasePadding)
            make.left.equalTo(kBasePadding)
            make.bottom.equalTo(0)
        })
        
        let arrowImg = UIImageView()
        arrowImg.contentMode = UIViewContentMode.scaleAspectFit
        arrowImg.image = UIImage(named: "xiangqing_btn_xiti")
        view.addSubview(arrowImg)
        arrowImg.snp.makeConstraints { (make) in
            make.right.equalTo(-kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 9))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 16))
            make.centerY.equalTo(tipsLbl.snp.centerY)
        }
        
        let seeAllBtn = UIButton.init()
        seeAllBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        seeAllBtn.titleLabel?.textAlignment = .right
        seeAllBtn.setTitleColor(UIColor(hex: 0xF85B5A), for: .normal)
        seeAllBtn.addTarget(self, action: #selector(seeAnswerBtnClicked(btn:)), for: .touchUpInside)
        seeAllBtn.setTitle("更多", for: .normal)
        seeAllBtn.tag = section
        view.addSubview(seeAllBtn)
        seeAllBtn.snp.makeConstraints { (make) in
            make.right.equalTo(arrowImg.snp.left)
            make.centerY.equalTo(arrowImg.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.width.equalTo(40)
        }
        
        let line = UIView()
        line.backgroundColor = kMainBgColor
        view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        
        switch section {
        case SECTION_BOOK:
            tipsLbl.text = "书籍"
        case SECTION_DOCUMENT:
            tipsLbl.text = "资料"
        case SECTION_ARTICLE:
            tipsLbl.text = "文章"
        default:
            break
        }
        
        view.backgroundColor = UIColor.white
        return view
    }
    
    @objc private func seeAnswerBtnClicked(btn: UIButton) {
    
        let tag = btn.tag
        switch tag {
        case SECTION_ARTICLE:
            let vc = SerachArticleViewController()
            vc.keyWords = self.keyWords
            self.pushViewController(viewContoller: vc, animated: true)
        case SECTION_BOOK:
            let vc = SearchBookViewController()
            vc.keyWords = self.keyWords
            self.pushViewController(viewContoller: vc, animated: true)
        case SECTION_DOCUMENT:
            let vc = SearchDocumentViewController()
            vc.keyWords = self.keyWords
            self.pushViewController(viewContoller: vc, animated: true)
        default:
            break
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.keyWords = searchBar.text!
        self.searchContent()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.keyWords = searchText
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
