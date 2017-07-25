//
//  ArticleDetailTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 25/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdArticleDetailTableViewCell = "ArticleDetailTableViewCell"

class ArticleDetailTableViewCell: UITableViewCell {
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var headImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.backgroundColor = kMainBgColor
        img.clipsToBounds = true
        img.layer.cornerRadius = scaleFromiPhone6Desgin(x: 15)
        return img
    }()
    
    private lazy var userNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var timeLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .right
        lbl.textColor = UIColor(hex: 0x888888)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var coverImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.backgroundColor = kMainBgColor
        img.clipsToBounds = true
        return img
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubview()
    }
    
    private func initSubview() {
        self.selectionStyle = .none
        
        self.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.top.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
        }
        
        let lineView = UIView()
        lineView.backgroundColor = kMainBgColor
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(1)
            make.top.equalTo(self.titleLbl.snp.bottom).offset(kBasePadding)
        }
        
        self.addSubview(self.headImg)
        self.headImg.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.top.equalTo(lineView.snp.bottom).offset(kBasePadding)
        }
        
        self.addSubview(self.timeLbl)
        self.timeLbl.snp.makeConstraints { (make) in
            make.right.equalTo(-kBasePadding)
            make.centerY.equalTo(self.headImg.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 100))
        }
        
        self.addSubview(self.userNameLbl)
        self.userNameLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImg.snp.right).offset(8)
            make.right.equalTo(self.timeLbl.snp.left).offset(-8)
            make.centerY.equalTo(self.headImg.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.coverImg)
        self.coverImg.snp.makeConstraints { (make) in
            make.top.equalTo(self.headImg.snp.bottom).offset(kBasePadding)
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 150))
        }
    }
    
    func setArticle(article: Article) {
        var titleHeight = article.title.heightWithConstrainedWidth(width: kScreenWidth - 2 * kBasePadding, font: UIFont.systemFont(ofSize: 20))
        if titleHeight < scaleFromiPhone6Desgin(x: 30) {
            titleHeight = scaleFromiPhone6Desgin(x: 30)
        }
        
        self.titleLbl.snp.remakeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.top.equalTo(kBasePadding)
            make.height.equalTo(titleHeight)
        }
        
        self.titleLbl.text = article.title
        self.headImg.sd_setImage(with: URL.init(string: article.user.headPic), placeholderImage: kNoImgDefaultImage)
        self.userNameLbl.text = article.user.nickName
        self.timeLbl.text = NSDate.stringTimesAgo(fromTimeInterval: article.createAt.doubleValue)
        self.coverImg.sd_setImage(with: URL.init(string: article.cover), placeholderImage: kNoImgDefaultImage)
    }
    
    static func cellHeightWithArticle(article: Article) -> CGFloat {
        
        let height = scaleFromiPhone6Desgin(x: 150 + 30) + 5 * kBasePadding
        
        var titleHeight = article.title.heightWithConstrainedWidth(width: kScreenWidth - 2 * kBasePadding, font: UIFont.systemFont(ofSize: 20))
        if titleHeight < scaleFromiPhone6Desgin(x: 30) {
            titleHeight = scaleFromiPhone6Desgin(x: 30)
        }
        
        return height + titleHeight
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
