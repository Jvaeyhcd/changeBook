//
//  CommentReplyTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 20/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdCommentReplyTableViewCell = "CommentReplyTableViewCell"

class CommentReplyTableViewCell: UITableViewCell {
    
    private lazy var userHead: UIImageView = {
        let imgView = UIImageView()
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
    
    private func initSubviews() {
        
        self.backgroundColor = UIColor.white
        
        self.selectedBackgroundView = UIView.init(frame: self.frame)
        self.selectedBackgroundView?.backgroundColor = kSelectedCellBgColor
        
        self.addSubview(self.userHead)
        self.userHead.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.timeLbl)
        self.timeLbl.snp.makeConstraints { (make) in
            make.right.equalTo(-kBasePadding)
            make.top.equalTo(self.userHead.snp.top)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 100))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.userNameLbl)
        self.userNameLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.userHead.snp.right).offset(scaleFromiPhone6Desgin(x: 10))
            make.centerY.equalTo(self.userHead.snp.centerY)
            make.right.equalTo(self.timeLbl.snp.left).offset(scaleFromiPhone6Desgin(x: 10))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.commentLbl)
        self.commentLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.userNameLbl.snp.left)
            make.right.equalTo(-kBasePadding)
            make.top.equalTo(self.userHead.snp.bottom).offset(scaleFromiPhone6Desgin(x: 10))
            make.bottom.equalTo(-kBasePadding)
        }
    }
    
    static func cellHeightWithComment(comment: Comment)->CGFloat {
        
        var height = scaleFromiPhone6Desgin(x: 30) + kBasePadding * 2
        
        var detailHeight = comment.commentContent.heightWithConstrainedWidth(width: kScreenWidth - 2 * kBasePadding - scaleFromiPhone6Desgin(x: 30), font: UIFont.systemFont(ofSize: 14))
        if detailHeight < 20 {
            detailHeight = 20
        }
        
        height += detailHeight
        
        return height
    }

    func setReplyComment(comment: Comment) {
        self.userHead.sd_setImage(with: URL.init(string: comment.sender.headPic), placeholderImage: kUserDefaultImage)
        self.userNameLbl.text = comment.sender.nickName
        self.commentLbl.text = comment.commentContent
        self.timeLbl.text = NSDate.stringTimesAgo(fromTimeInterval: comment.createAt.doubleValue)
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
