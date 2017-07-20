//
//  DocumentTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 16/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import HCSStarRatingView

let kCellIdDocumentTableViewCell = "DocumentTableViewCell"

class DocumentTableViewCell: UITableViewCell {
    
    // 封面图
    private lazy var coverImg: UIImageView = {
        let coverImg = UIImageView.init()
        coverImg.backgroundColor = kMainBgColor
        coverImg.clipsToBounds = true
        coverImg.contentMode = .scaleAspectFill
        return coverImg
    }()
    
    // 标签
    private lazy var tagImgView: UIImageView = {
        let imgView = UIImageView.init()
        imgView.backgroundColor = kMainBgColor
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    // 评分
    private var rateStar: HCSStarRatingView = {
        let star = HCSStarRatingView.init()
        star.maximumValue = 5
        star.minimumValue = 0
        star.allowsHalfStars = true
        star.emptyStarImage = UIImage(named: "pingjia_btn_star2")
        star.filledStarImage = UIImage(named: "pingjia_btn_star1")
        star.backgroundColor = UIColor.clear
        star.isUserInteractionEnabled = false
        return star
    }()
    
    private var scoreLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0xF85B5A)
        return lbl
    }()
    
    // 书名
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x555555)
        return lbl
    }()
    
    
    // 作者
    private lazy var authorLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x888888)
        return lbl
    }()
    
    // 大小
    private lazy var sizeLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x888888)
        return lbl
    }()
    
    private lazy var seeLbl: UILabel = {
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
    
    private func initSubviews() {
        
        self.selectionStyle = .none
        
        self.addSubview(self.coverImg)
        self.coverImg.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 120))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 160))
        }
        
        self.tagImgView.image = UIImage(named: "home_icon_doc")
        self.coverImg.addSubview(self.tagImgView)
        self.tagImgView.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 40))
        }
        
        let lineView = UIView()
        lineView.backgroundColor = kMainBgColor
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(1)
            make.top.equalTo(self.coverImg.snp.bottom).offset(kBasePadding)
        }
        
        self.titleLbl.text = "Nodejs学习过程"
        self.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(lineView.snp.bottom).offset(scaleFromiPhone6Desgin(x: 10))
            make.right.equalTo(-kBasePadding)
        }
        
        self.addSubview(self.rateStar)
        self.rateStar.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 100))
            make.top.equalTo(self.titleLbl.snp.bottom)
        }
        
        self.scoreLbl.text = "4.2"
        self.addSubview(self.scoreLbl)
        self.scoreLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.rateStar.snp.right).offset(scaleFromiPhone6Desgin(x: 6))
            make.centerY.equalTo(self.rateStar.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 40))
        }
        
        self.authorLbl.text = "上传者：黄成达"
        self.addSubview(self.authorLbl)
        self.authorLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.rateStar.snp.bottom)
            make.right.equalTo(-kBasePadding)
        }
        
        self.sizeLbl.text = "文件大小：12MB"
        self.addSubview(self.sizeLbl)
        self.sizeLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.authorLbl.snp.bottom)
            make.right.equalTo(-kBasePadding)
        }
        
        self.seeLbl.text = "浏览次数：23次"
        self.addSubview(self.seeLbl)
        self.seeLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.sizeLbl.snp.bottom)
            make.right.equalTo(-kBasePadding)
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = kMainBgColor
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(kBasePadding)
        }
        
    }
    
    func setDocument(document: Document) {
        
        self.coverImg.sd_setImage(with: URL.init(string: document.documentCover), placeholderImage: kNoImgDefaultImage)
        self.authorLbl.text = "上传者：" + document.uploader
        self.titleLbl.text = document.documentName
        self.seeLbl.text = "浏览次数：" + document.readNum
        self.sizeLbl.text = "文件大小：" + document.fileSize + "MB"
        self.scoreLbl.text = document.score
        self.rateStar.value = CGFloat(document.score.floatValue)
        
        if kDocumentTypeDOC == document.fileFormat {
            self.tagImgView.image = UIImage(named: "home_icon_doc")
        } else if kDocumentTypeEXC == document.fileFormat {
            self.tagImgView.image = UIImage(named: "home_icon_xls")
        } else if kDocumentTypePDF == document.fileFormat {
            self.tagImgView.image = UIImage(named: "home_icon_pdf")
        } else if kDocumentTypePPT == document.fileFormat {
            self.tagImgView.image = UIImage(named: "home_icon_ppt")
        } else if kDocumentTypeTXT == document.fileFormat {
            self.tagImgView.image = UIImage(named: "home_icon_txt")
        }
        
    }
    
    static func cellHeight()->CGFloat {
        return scaleFromiPhone6Desgin(x: 280) + 3 * kBasePadding
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
