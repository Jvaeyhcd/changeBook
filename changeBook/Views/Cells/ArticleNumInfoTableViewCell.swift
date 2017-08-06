//
//  ArticleNumInfoTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 06/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdArticleNumInfoTableViewCell = "ArticleNumInfoTableViewCell"

class ArticleNumInfoTableViewCell: UITableViewCell {
    
    private lazy var seeBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.imageView!.contentMode = .scaleAspectFit
        btn.setTitleColor(UIColor(hex: 0x888888), for: .normal)
        btn.setImage(UIImage(named: "home_icon_chakan"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 2)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, -2)
        btn.sizeToFit()
        return btn
    }()
    
    private lazy var commentBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(UIColor(hex: 0x888888), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 2)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, -2)
        btn.setImage(UIImage(named: "home_icon_zan"), for: .normal)
        btn.sizeToFit()
        return btn
    }()
    
    private lazy var zanBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(UIColor(hex: 0x888888), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 2)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, -2)
        btn.setImage(UIImage(named: "home_icon_pinglun"), for: .normal)
        btn.sizeToFit()
        return btn
    }()
    
    private lazy var rewordBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(UIColor(hex: 0x888888), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 2)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, -2)
        btn.setImage(UIImage(named: "wenzhang_btn_zan"), for: .normal)
        btn.sizeToFit()
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubviews()
    }
    
    private func initSubviews() {
        
        self.selectionStyle = .none
        
        self.addSubview(self.seeBtn)
        self.seeBtn.snp.makeConstraints{
            make -> Void in
            make.bottom.equalTo(-kBasePadding)
            make.left.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.zanBtn)
        self.zanBtn.snp.makeConstraints{
            make -> Void in
            make.bottom.equalTo(-kBasePadding)
            make.left.equalTo(self.seeBtn.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.commentBtn)
        self.commentBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-kBasePadding)
            make.left.equalTo(self.zanBtn.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.rewordBtn)
        self.rewordBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(-kBasePadding)
            make.left.equalTo(self.commentBtn.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        let line = UIView()
        line.backgroundColor = kMainBgColor
        self.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(1)
            make.bottom.equalTo(0)
        }
        
    }
    
    func setArticle(article: Article) {
        self.seeBtn.setTitle(article.readNum, for: .normal)
        self.commentBtn.setTitle(article.commentNum, for: .normal)
        self.rewordBtn.setTitle(article.integral, for: .normal)
        self.zanBtn.setTitle(article.likeNum, for: .normal)
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 20) + 2 * kBasePadding
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
