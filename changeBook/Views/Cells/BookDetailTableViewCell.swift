//
//  BookDetailTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 22/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import HCSStarRatingView

let kCellIdBookDetailTableViewCell = "BookDetailTableViewCell"

class BookDetailTableViewCell: UITableViewCell {
    
    var seeAnswerBlock: (()->())!

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
    private lazy var priceLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x888888)
        return lbl
    }()
    
    // 出版社
    private lazy var publisherLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x888888)
        return lbl
    }()
    
    private lazy var ISBNLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x888888)
        return lbl
    }()
    
    private lazy var arrowImg: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = UIViewContentMode.scaleAspectFit
        return imgView
    }()
    
    private lazy var seeAnswerBtn: UIButton = {
        let btn = UIButton.init()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.titleLabel?.textAlignment = .right
        btn.setTitleColor(UIColor(hex: 0xF85B5A), for: .normal)
        return btn
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
        
        self.titleLbl.text = ""
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
        
        self.scoreLbl.text = ""
        self.addSubview(self.scoreLbl)
        self.scoreLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.rateStar.snp.right).offset(scaleFromiPhone6Desgin(x: 6))
            make.centerY.equalTo(self.rateStar.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 40))
        }
        
        self.authorLbl.text = ""
        self.addSubview(self.authorLbl)
        self.authorLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.rateStar.snp.bottom)
            make.right.equalTo(-kBasePadding)
        }
        
        self.priceLbl.text = ""
        self.addSubview(self.priceLbl)
        self.priceLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.authorLbl.snp.bottom)
            make.right.equalTo(-kBasePadding)
        }
        
        self.publisherLbl.text = ""
        self.addSubview(self.publisherLbl)
        self.publisherLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.priceLbl.snp.bottom)
            make.right.equalTo(-kBasePadding)
        }
        
        self.ISBNLbl.text = ""
        self.addSubview(self.ISBNLbl)
        self.ISBNLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.publisherLbl.snp.bottom)
            make.right.equalTo(-kBasePadding)
        }
        
        self.arrowImg.image = UIImage(named: "xiangqing_btn_xiti")
        self.addSubview(self.arrowImg)
        self.arrowImg.snp.makeConstraints { (make) in
            make.right.equalTo(-kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 9))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 16))
            make.centerY.equalTo(self.ISBNLbl.snp.centerY)
        }
        
        self.seeAnswerBtn.addTarget(self, action: #selector(seeAnswerBtnClicked), for: .touchUpInside)
        self.seeAnswerBtn.setTitle("习题答案", for: .normal)
        self.addSubview(self.seeAnswerBtn)
        self.seeAnswerBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.arrowImg.snp.left)
            make.centerY.equalTo(self.arrowImg.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.width.equalTo(65)
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
    
    @objc private func seeAnswerBtnClicked() {
        if nil != self.seeAnswerBlock {
            self.seeAnswerBlock()
        }
    }
    
    func setBook(book: Book) {
        
        self.coverImg.sd_setImage(with: URL.init(string: book.bookCover), placeholderImage: kNoImgDefaultImage)
        self.authorLbl.text = "作者：" + book.bookAuthor + "著"
        self.titleLbl.text = book.bookName
        self.priceLbl.text = "原价：" + book.bookPrice
        self.publisherLbl.text = "出版社：" + book.publisher
        self.ISBNLbl.text = "ISBN码：" + book.ISBN
        if INT_TRUE == book.hasFile {
            self.tagImgView.image = UIImage(named: "home_icon_daan")
        } else {
            self.tagImgView.image = UIImage(named: "home_icon_daan_1")
        }
//        self.publisherLbl.text = "浏览次数：" + document.readNum
//        self.priceLbl.text = "文件大小：" + document.fileSize + "MB"
//        self.scoreLbl.text = document.score
//        self.rateStar.value = CGFloat(document.score.floatValue)
//        
//        if kDocumentTypeDOC == document.fileFormat {
//            self.tagImgView.image = UIImage(named: "home_icon_doc")
//        } else if kDocumentTypeEXC == document.fileFormat {
//            self.tagImgView.image = UIImage(named: "home_icon_xls")
//        } else if kDocumentTypePDF == document.fileFormat {
//            self.tagImgView.image = UIImage(named: "home_icon_pdf")
//        } else if kDocumentTypePPT == document.fileFormat {
//            self.tagImgView.image = UIImage(named: "home_icon_ppt")
//        } else if kDocumentTypeTXT == document.fileFormat {
//            self.tagImgView.image = UIImage(named: "home_icon_txt")
//        }
        
    }
    
    static func cellHeight()->CGFloat {
        return scaleFromiPhone6Desgin(x: 300) + 3 * kBasePadding
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
