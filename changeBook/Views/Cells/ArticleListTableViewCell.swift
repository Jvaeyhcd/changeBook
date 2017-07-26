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
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 80) + 2 * kBasePadding
    }
    
    func setArticle(article: Article) {
        self.coverImg.sd_setImage(with: URL.init(string: article.cover), placeholderImage: kNoImgDefaultImage)
        self.titleLbl.text = article.title
        self.authorLbl.text = "作者：" + article.user.nickName
        self.timeLbl.text = "发表时间：" + NSDate.stringTimesAgo(fromTimeInterval: article.createAt.doubleValue)
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
