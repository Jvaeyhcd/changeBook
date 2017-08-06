//
//  ArticleListTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 01/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdArticleListTableViewCell = "ArticleListTableViewCell"

class ArticleListTableViewCell: UITableViewCell {
    
    private lazy var coverImg: UIImageView = {
        let coverImg = UIImageView.init()
        coverImg.backgroundColor = kMainBgColor
        coverImg.contentMode = .scaleAspectFill
        coverImg.clipsToBounds = true
        return coverImg
    }()
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x555555)
        return lbl
    }()
    
    private lazy var authorLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x888888)
        return lbl
    }()
    
    private lazy var timeLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x888888)
        return lbl
    }()
    
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubviews() {
        
        self.selectedBackgroundView = UIView.init(frame: self.frame)
        self.selectedBackgroundView?.backgroundColor = kSelectedCellBgColor
        
        self.addSubview(self.coverImg)
        self.coverImg.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 80))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 80))
        }
        
        self.titleLbl.text = "Nodejs学习过程"
        self.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.coverImg.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.coverImg.snp.top)
            make.right.equalTo(-kBasePadding)
        }
        
        self.authorLbl.text = "作者：黄成达"
        self.addSubview(self.authorLbl)
        self.authorLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.coverImg.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.titleLbl.snp.bottom)
            make.right.equalTo(-kBasePadding)
        }
        
        self.timeLbl.text = "发表时间：2017-06-20 12:00:00"
        self.addSubview(self.timeLbl)
        self.timeLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.coverImg.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.authorLbl.snp.bottom)
            make.right.equalTo(-kBasePadding)
        }
        
        self.addSubview(self.seeBtn)
        self.seeBtn.snp.makeConstraints{
            make -> Void in
            make.bottom.equalTo(-kBasePadding)
            make.left.equalTo(self.coverImg.snp.right).offset(kBasePadding)
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
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 80) + 2 * kBasePadding
    }
    
    func setArticle(article: Article) {
        self.coverImg.sd_setImage(with: URL.init(string: article.cover), placeholderImage: kNoImgDefaultImage)
        self.titleLbl.text = article.title
        self.authorLbl.text = "作者：" + article.user.nickName
        self.timeLbl.text = "发表时间：" + NSDate.stringTimesAgo(fromTimeInterval: article.createAt.doubleValue)
        self.seeBtn.setTitle(article.readNum, for: .normal)
        self.commentBtn.setTitle(article.commentNum, for: .normal)
        self.zanBtn.setTitle(article.likeNum, for: .normal)
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
