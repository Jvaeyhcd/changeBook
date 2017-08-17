//
//  ArticleCommentTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 26/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdArticleCommentTableViewCell = "ArticleCommentTableViewCell"

class ArticleCommentTableViewCell: UITableViewCell {
    
    var userBlock: ((User)->())!
    private var comment: Comment!

    private lazy var userHead: UITapImageView = {
        let imgView = UITapImageView()
        imgView.contentMode = .scaleToFill
        imgView.backgroundColor = kMainBgColor
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = scaleFromiPhone6Desgin(x: 10)
        return imgView
    }()
    
    private lazy var userNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = UIColor(hex: 0x888888)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private var commentLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private var likeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(UIColor(hex: 0x888888), for: .normal)
        btn.setImage(UIImage(named: "pingjia_btn_like"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3)
        return btn
    }()
    
    private var commentBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(UIColor(hex: 0x888888), for: .normal)
        btn.setImage(UIImage(named: "pingjia_btn_comment"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3)
        return btn
    }()
    
    private lazy var timeLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = UIFont.systemFont(ofSize: 12)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setComment(comment: Comment) {
        
        self.comment = comment
        
        self.userHead.sd_setImage(with: URL.init(string: comment.sender.headPic), placeholderImage: kUserDefaultImage)
        self.userNameLbl.text = comment.sender.nickName
        self.commentLbl.text = comment.commentContent
        self.likeBtn.setTitle(comment.likeNum, for: .normal)
        self.commentBtn.setTitle(comment.commentNum, for: .normal)
        //        self.timeLbl.text = NSDate.stringTimesAgo(fromTimeInterval: TimeInterval((post?.createTime)!)!)
        self.timeLbl.text = NSDate.stringTimesAgo(fromTimeInterval: comment.createAt.doubleValue)
        
        let commentWidth = comment.commentNum.widthWithConstrainedWidth(width: 100, font: UIFont.systemFont(ofSize: 14)) + 8
        let likeWidth = comment.likeNum.widthWithConstrainedWidth(width: 100, font: UIFont.systemFont(ofSize: 14)) + 8
        
        self.commentBtn.snp.remakeConstraints { (make) in
            make.left.equalTo(self.likeBtn.snp.right).offset(scaleFromiPhone6Desgin(x: 10))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 20) + likeWidth)
            make.bottom.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.likeBtn.snp.remakeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 20) + commentWidth)
            make.bottom.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        
        
    }
    
    static func cellHeightWithComment(comment: Comment)->CGFloat {
        
        var height = scaleFromiPhone6Desgin(x: 60) + kBasePadding * 2
        
        var detailHeight = comment.commentContent.heightWithConstrainedWidth(width: kScreenWidth - 2 * kBasePadding, font: UIFont.systemFont(ofSize: 14))
        if detailHeight < 20 {
            detailHeight = 20
        }
        
        height += detailHeight
        
        return height
    }
    
    private func initSubviews() {
        
        self.backgroundColor = UIColor.white
        
        self.selectedBackgroundView = UIView.init(frame: self.frame)
        self.selectedBackgroundView?.backgroundColor = kSelectedCellBgColor
        
        self.addSubview(self.userHead)
        self.userHead.addTap { [weak self] (imgView) in
            if nil != self?.userBlock && nil != self?.comment {
                self?.userBlock((self?.comment.sender)!)
            }
        }
        self.userHead.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.timeLbl)
        self.timeLbl.snp.makeConstraints { (make) in
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 100))
            make.top.equalTo(self.userHead.snp.top)
        }
        
        self.addSubview(self.userNameLbl)
        self.userNameLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.userHead.snp.right).offset(scaleFromiPhone6Desgin(x: 10))
            make.centerY.equalTo(self.userHead.snp.centerY)
            make.right.equalTo(self.timeLbl.snp.left)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.likeBtn)
        self.likeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.width.equalTo(80)
            make.bottom.bottom.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.commentBtn)
        self.commentBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.likeBtn.snp.right).offset(scaleFromiPhone6Desgin(x: 10))
            make.width.equalTo(80)
            make.bottom.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.commentLbl)
        self.commentLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.top.equalTo(self.userHead.snp.bottom).offset(scaleFromiPhone6Desgin(x: 10))
            make.bottom.equalTo(self.likeBtn.snp.top).offset(-scaleFromiPhone6Desgin(x: 10))
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
