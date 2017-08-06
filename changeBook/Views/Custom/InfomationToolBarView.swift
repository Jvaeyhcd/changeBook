//
//  InfomationToolBarView.swift
//  govlan
//
//  Created by Jvaeyhcd on 25/04/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class InfomationToolBarView: UIView {
    
    var addCommentBlock: VoidBlock!
    var goToCommentsBlock: VoidBlock!
    var praiseBlock: VoidBlock!
    
    enum InfomationToolBarViewButtonTag: Int {
        case commentBtnTag, praiseBtnTag, addCommentBtnTag
    }
    
    fileprivate lazy var commentBtn: UIButton = {
        let commentBtn = UIButton()
        commentBtn.setTitle("", for: .normal)
        commentBtn.setImage(UIImage.init(named: "pingjia_btn_pinglun"), for: .normal)
        commentBtn.contentMode = .scaleAspectFit
        commentBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        commentBtn.setTitleColor(UIColor(hex: 0x888888), for: .normal)
        commentBtn.tag = InfomationToolBarViewButtonTag.commentBtnTag.rawValue
        commentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3)
        commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3)
        return commentBtn
    }()
    
    fileprivate lazy var praiseBtn: UIButton = {
        let praiseBtn = UIButton()
        praiseBtn.setTitle("", for: .normal)
        praiseBtn.setImage(UIImage.init(named: "pingjia_btn_zan"), for: .normal)
        praiseBtn.setImage(UIImage.init(named: "pingjia_btn_zan_pre"), for: .selected)
        praiseBtn.contentMode = .scaleAspectFit
        praiseBtn.tag = InfomationToolBarViewButtonTag.praiseBtnTag.rawValue
        praiseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3)
        praiseBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3)
        praiseBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        praiseBtn.setTitleColor(UIColor(hex: 0x888888), for: .normal)
        return praiseBtn
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(hex: 0xFFFFFF)
        
        self.commentBtn.addTarget(self, action: #selector(buttonClicked(button:)), for: UIControlEvents.touchUpInside)
        self.addSubview(self.commentBtn)
        self.commentBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 12))
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 60))
            make.height.equalTo(40)
        }
        
        self.praiseBtn.addTarget(self, action: #selector(buttonClicked(button:)), for: UIControlEvents.touchUpInside)
        self.addSubview(self.praiseBtn)
        self.praiseBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.commentBtn.snp.left).offset(-kBasePadding)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 60))
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
            make.right.equalTo(self.praiseBtn.snp.left)
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(lineView.snp.right).offset(8)
            make.height.equalTo(20)
        }
        
        self.addCommentBtn.addTarget(self, action: #selector(buttonClicked(button:)), for: UIControlEvents.touchUpInside)
        self.addSubview(self.addCommentBtn)
        self.addCommentBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.praiseBtn.snp.left)
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
        
    }
    
    func setLiked(isLike: Int) {
        if isLike == INT_TRUE {
            self.praiseBtn.setImage(UIImage.init(named: "pingjia_btn_zan_pre"), for: .normal)
        } else {
            self.praiseBtn.setImage(UIImage.init(named: "pingjia_btn_zan"), for: .normal)
        }
    }
    
    func setReplyNumber(number: String) {
        self.commentBtn.setTitle(number, for: .normal)
    }
    
    func setPraiseNumber(number: String) {
        self.praiseBtn.setTitle(number, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonClicked(button: UIButton) {
        switch button.tag {
        case InfomationToolBarViewButtonTag.commentBtnTag.rawValue:
            if nil != self.goToCommentsBlock {
                self.goToCommentsBlock()
            }
        case InfomationToolBarViewButtonTag.praiseBtnTag.rawValue:
            if nil != self.praiseBlock {
                self.praiseBlock()
            }
        case InfomationToolBarViewButtonTag.addCommentBtnTag.rawValue:
            if nil != self.addCommentBlock {
                self.addCommentBlock()
            }
        default:
            break
        }
    }
    
}
