//
//  BookListTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 01/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import HCSStarRatingView

let kCellIdBookListTableViewCell = "BookListTableViewCell"

class BookListTableViewCell: UITableViewCell {
    
    // 封面图
    private lazy var coverImg: UIImageView = {
        let coverImg = UIImageView.init()
        coverImg.backgroundColor = kMainBgColor
        coverImg.contentMode = .scaleAspectFill
        coverImg.clipsToBounds = true
        return coverImg
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
    
    private var soreLbl: UILabel = {
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
    
    private lazy var otherLbl: UILabel = {
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
            make.width.equalTo(scaleFromiPhone6Desgin(x: 60))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 80))
        }
        
        self.titleLbl.text = ""
        self.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.coverImg.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.coverImg.snp.top)
            make.right.equalTo(-kBasePadding)
        }
        
        self.rateStar.value = 4.2
        self.addSubview(self.rateStar)
        self.rateStar.snp.makeConstraints { (make) in
            make.left.equalTo(self.coverImg.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 100))
            make.top.equalTo(self.titleLbl.snp.bottom)
        }
        
        self.soreLbl.text = ""
        self.addSubview(self.soreLbl)
        self.soreLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.rateStar.snp.right).offset(scaleFromiPhone6Desgin(x: 6))
            make.centerY.equalTo(self.rateStar.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 40))
        }
        
        self.authorLbl.text = ""
        self.addSubview(self.authorLbl)
        self.authorLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.coverImg.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.rateStar.snp.bottom)
            make.right.equalTo(-kBasePadding)
        }
        
        self.otherLbl.text = ""
        self.addSubview(self.otherLbl)
        self.otherLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.coverImg.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.authorLbl.snp.bottom)
            make.right.equalTo(-kBasePadding)
        }
    }
    
    func setBook(book: Book) {
        self.coverImg.sd_setImage(with: URL.init(string: book.bookCover), placeholderImage: kNoImgDefaultImage)
        self.titleLbl.text = book.bookName
        self.soreLbl.text = book.score
        self.rateStar.value = CGFloat(book.score.floatValue)
        self.authorLbl.text = book.publisher + " 著"
        self.otherLbl.text = "剩余" + book.bookCount + "本 " + book.commentNum + "条评论"
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 80) + 2 * kBasePadding
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
