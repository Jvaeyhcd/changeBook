//
//  UsersCommentTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 07/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdUsersCommentTableViewCell = "UsersCommentTableViewCell"

class UsersCommentTableViewCell: UITableViewCell, TTTAttributedLabelDelegate {
    
    private lazy var userHead: UITapImageView = {
        let imgView = UITapImageView()
        imgView.layer.cornerRadius = scaleFromiPhone6Desgin(x: 15)
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private lazy var commentLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        return lbl
    }()
    
    private lazy var contentLbl: UITTTAttributedLabel = {
        let lbl = UITTTAttributedLabel.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        lbl.numberOfLines = 0
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.sizeToFit()
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
        
        self.selectionStyle = .none
        
        self.addSubview(self.userHead)
        self.userHead.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
        }
        
        self.contentLbl.linkAttributes = [NSForegroundColorAttributeName: kMainColor!,NSFontAttributeName:UIFont.systemFont(ofSize: 14)]
        self.contentLbl.activeLinkAttributes = [NSForegroundColorAttributeName: kBlueColor,NSFontAttributeName:UIFont.systemFont(ofSize: 14)]
        self.contentLbl.delegate = self
        self.addSubview(self.contentLbl)
        self.contentLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.userHead.snp.right).offset(scaleFromiPhone6Desgin(x: 10))
            make.top.equalTo(self.userHead.snp.top)
            make.right.equalTo(-kBasePadding)
        }
        
        self.addSubview(self.commentLbl)
        self.commentLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentLbl.snp.left)
            make.right.equalTo(self.contentLbl.snp.right)
            make.top.equalTo(self.contentLbl.snp.bottom).offset(scaleFromiPhone6Desgin(x: 10))
            make.bottom.equalTo(-kBasePadding)
        }
        
    }
    
    func setComment(comment: Comment) {
        self.userHead.sd_setImage(with: URL.init(string: comment.user.headPic), placeholderImage: kNoImgDefaultImage)
        
        var commentType = ""
        if comment.commentType == kCommentTypeArticle {
            commentType = "评论了文章"
        } else if comment.commentType == kCommentTypeBook {
            commentType = "评论了书籍"
        } else if comment.commentType == kCommentTypeDocument {
            commentType = "评论了资料"
        }
        let title = comment.user.nickName + " " + commentType + " " + comment.title
        
        let len = comment.title.characters.count
        self.contentLbl.text = title
        self.contentLbl.addLink(to: URL.init(string: ""), with: NSMakeRange(title.characters.count - len, len))
        self.commentLbl.text = comment.commentContent
        
    }
    
    static func cellHeightWithComment(comment: Comment) -> CGFloat {
        
        var commentType = ""
        if comment.commentType == kCommentTypeArticle {
            commentType = "评论了文章"
        } else if comment.commentType == kCommentTypeBook {
            commentType = "评论了书籍"
        } else if comment.commentType == kCommentTypeDocument {
            commentType = "评论了资料"
        }
        let title = comment.user.nickName + " " + commentType + " " + comment.title
        
        let titleHeight = title.heightWithConstrainedWidth(width: kScreenWidth - 2 * kBasePadding - scaleFromiPhone6Desgin(x: 40), font: UIFont.systemFont(ofSize: 14))
        
        let commentHeight = comment.commentContent.heightWithConstrainedWidth(width: kScreenWidth - 2 * kBasePadding - scaleFromiPhone6Desgin(x: 40), font: UIFont.systemFont(ofSize: 12))
        
        return titleHeight + commentHeight + scaleFromiPhone6Desgin(x: 10) + 2 * kBasePadding
        
    }
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        
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
