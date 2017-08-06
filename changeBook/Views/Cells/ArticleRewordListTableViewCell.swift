//
//  ArticleRewordListTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 06/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdArticleRewordListTableViewCell = "ArticleRewordListTableViewCell"

class ArticleRewordListTableViewCell: UITableViewCell {
    
    lazy var userHead: UITapImageView = {
        let imgView = UITapImageView()
        imgView.contentMode = .scaleToFill
        imgView.backgroundColor = kMainBgColor
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = scaleFromiPhone6Desgin(x: 15)
        return imgView
    }()
    
    private lazy var userNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private var timeLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = UIColor(hex: 0x888888)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubviews()
    }
    
    private func initSubviews() {
        
        self.selectedBackgroundView = UIView.init(frame: self.frame)
        self.selectedBackgroundView?.backgroundColor = kSelectedCellBgColor
        
        self.addSubview(self.userHead)
        self.userHead.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
        }
        
        self.addSubview(self.userNameLbl)
        self.userNameLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.userHead.snp.right).offset(scaleFromiPhone6Desgin(x: 8))
            make.right.equalTo(-kBasePadding)
            make.top.equalTo(self.userHead.snp.top)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.timeLbl)
        self.timeLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.userNameLbl.snp.left)
            make.top.equalTo(self.userNameLbl.snp.bottom).offset(scaleFromiPhone6Desgin(x: 8))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.right.equalTo(-kBasePadding)
        }
    }
    
    func setRewordLog(rewordLog: RewardLog) {
        self.userNameLbl.text = rewordLog.user.nickName + "支持了文章"
        self.timeLbl.text = NSDate.stringTimesAgo(fromTimeInterval: rewordLog.createAt.doubleValue)
        self.userHead.sd_setImage(with: URL.init(string: rewordLog.user.headPic), placeholderImage: kNoImgDefaultImage)
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 48) + 2 * kBasePadding
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
