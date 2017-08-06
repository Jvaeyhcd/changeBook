//
//  ArticleToolBarView.swift
//  changeBook
//
//  Created by Jvaeyhcd on 06/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class ArticleToolBarView: UIView {

    var addCommentBlock: VoidBlock!
    var goToCommentsBlock: VoidBlock!
    var likeBlock: VoidBlock!
    var addRewordBlock: VoidBlock!
    
    enum InfomationToolBarViewButtonTag: Int {
        case rewordBtnTag, likeBtnTag, commentBtnTag, addCommentBtnTag
    }
    
    fileprivate lazy var rewordBtn: UIButton = {
        let rewordBtn = UIButton()
        rewordBtn.setImage(UIImage.init(named: "wenzhang_btn_dashang"), for: .normal)
        rewordBtn.contentMode = .scaleAspectFit
        rewordBtn.tag = InfomationToolBarViewButtonTag.rewordBtnTag.rawValue
        return rewordBtn
    }()
    
    fileprivate lazy var likeBtn: UIButton = {
        let likeBtn = UIButton()
        likeBtn.setImage(UIImage.init(named: "pingjia_btn_zan"), for: .normal)
        likeBtn.setImage(UIImage.init(named: "pingjia_btn_zan_pre"), for: .selected)
        likeBtn.contentMode = .scaleAspectFit
        likeBtn.tag = InfomationToolBarViewButtonTag.likeBtnTag.rawValue
        return likeBtn
    }()
    
    fileprivate lazy var commentBtn: UIButton = {
        let commentBtn = UIButton()
        commentBtn.setImage(UIImage.init(named: "pingjia_btn_pinglun"), for: .normal)
        commentBtn.contentMode = .scaleAspectFit
        commentBtn.tag = InfomationToolBarViewButtonTag.commentBtnTag.rawValue
        return commentBtn
    }()
    
    private lazy var tipsLbl: UILabel = {
        let tipsLbl = UILabel()
        tipsLbl.font = kBaseFont
        tipsLbl.textColor = UIColor(hex: 0xBDBDBD)
        tipsLbl.textAlignment = .left
        tipsLbl.text = "说点什么呗..."
        return tipsLbl
    }()
    
    private lazy var addCommentBtn: UIButton = {
        let addCommentBtn = UIButton()
        addCommentBtn.backgroundColor = UIColor.clear
        addCommentBtn.tag = InfomationToolBarViewButtonTag.addCommentBtnTag.rawValue
        return addCommentBtn
    }()
    
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = kMainColor
        return lineView
    }()
    
    private lazy var commentNumLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.layer.cornerRadius = 7
        lbl.clipsToBounds = true
        lbl.font = kSmallTextFont
        lbl.textAlignment = .center
        lbl.backgroundColor = kMainColor
        lbl.textColor = UIColor.white
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(hex: 0xFFFFFF)
        
        self.commentBtn.addTarget(self, action: #selector(buttonClicked(button:)), for: UIControlEvents.touchUpInside)
        self.addSubview(self.commentBtn)
        self.commentBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 8))
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        self.likeBtn.addTarget(self, action: #selector(buttonClicked(button:)), for: UIControlEvents.touchUpInside)
        self.addSubview(self.likeBtn)
        self.likeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.commentBtn.snp.left).offset(-kBasePadding)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        self.rewordBtn.addTarget(self, action: #selector(buttonClicked(button:)), for: UIControlEvents.touchUpInside)
        self.addSubview(self.rewordBtn)
        self.rewordBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.likeBtn.snp.left).offset(-kBasePadding)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        self.addSubview(self.lineView)
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 12))
            make.width.equalTo(2)
            make.height.equalTo(20)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        self.addSubview(self.tipsLbl)
        self.tipsLbl.snp.makeConstraints { (make) in
            make.right.equalTo(self.rewordBtn.snp.left)
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(lineView.snp.right).offset(8)
            make.height.equalTo(20)
        }
        
        self.addCommentBtn.addTarget(self, action: #selector(buttonClicked(button:)), for: UIControlEvents.touchUpInside)
        self.addSubview(self.addCommentBtn)
        self.addCommentBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.rewordBtn.snp.left)
            make.top.equalTo(0)
            make.left.equalTo(lineView.snp.right).offset(8)
            make.bottom.equalTo(0)
        }
        
        let sepratorlineView = UIView()
        sepratorlineView.backgroundColor = kMainBgColor
        self.addSubview(sepratorlineView)
        sepratorlineView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(1)
        }
        
        self.addSubview(self.commentNumLbl)
    }
    
    func setLike(isLike: Int) {
        if isLike == INT_TRUE {
            self.likeBtn.setImage(UIImage.init(named: "pingjia_btn_zan_pre"), for: .normal)
        } else {
            self.likeBtn.setImage(UIImage.init(named: "pingjia_btn_zan"), for: .normal)
        }
    }
    
    func setCommentNum(commentNum: Int) {
        
        if commentNum == 0 {
            self.commentNumLbl.isHidden = true
        } else {
            self.commentNumLbl.isHidden = false
            
            var text = ""
            if commentNum > 999 {
                text = "999+"
            } else {
                text = String(format: "%d", commentNum)
            }
            self.commentNumLbl.text = text
            
            var width = text.widthWithConstrainedWidth(width: kScreenWidth, font: kSmallTextFont) + 8
            if width < 14 {
                width = 14
            }
            let x = kScreenWidth - 2 * kBasePadding - scaleFromiPhone6Desgin(x: 8) - width / 2 - 84
            //self.commentNumLbl.frame = CGRect(x: x, y: 6, width: width, height: 14)
            self.commentNumLbl.frame = CGRect(x: x - 8, y: 8, width: width, height: 14)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonClicked(button: UIButton) {
        switch button.tag {
        case InfomationToolBarViewButtonTag.rewordBtnTag.rawValue:
            if nil != self.addRewordBlock {
                self.addRewordBlock()
            }
        case InfomationToolBarViewButtonTag.likeBtnTag.rawValue:
            if nil != self.likeBlock {
                self.likeBlock()
            }
        case InfomationToolBarViewButtonTag.addCommentBtnTag.rawValue:
            if nil != self.addCommentBlock {
                self.addCommentBlock()
            }
        case InfomationToolBarViewButtonTag.commentBtnTag.rawValue:
            if nil != self.goToCommentsBlock {
                self.goToCommentsBlock()
            }
        default:
            break
        }
    }

}
