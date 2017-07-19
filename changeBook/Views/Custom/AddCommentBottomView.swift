//
//  AddCommentBottomView.swift
//  changeBook
//
//  Created by Jvaeyhcd on 19/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class AddCommentBottomView: UIView {

    var addCommentBlock: (()->())!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        bottomView.layer.cornerRadius = 4
        bottomView.clipsToBounds = true
        
        self.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding / 2)
            make.top.equalTo(kBasePadding / 2)
            make.right.equalTo(-kBasePadding / 2)
            make.bottom.equalTo(-kBasePadding / 2)
        }
        
        let commentBtn = UIButton(type: .custom)
        commentBtn.contentHorizontalAlignment = .left
        commentBtn.titleLabel!.font = kBaseFont
        commentBtn.setTitle("添加评论", for: .normal)
        commentBtn.setTitleColor(UIColor(hex: 0x888888), for: .normal)
        commentBtn.backgroundColor = UIColor.white
        commentBtn.addTarget(self, action: #selector(commentBtnClicked), for: .touchUpInside)
        
        bottomView.addSubview(commentBtn)
        commentBtn.snp.makeConstraints{
            make -> Void in
            make.left.equalTo(bottomView.snp.left).offset(kBasePadding / 2)
            make.right.equalTo(bottomView.snp.right).offset(-kBasePadding / 2)
            make.top.equalTo(kBasePadding / 2)
            make.bottom.equalTo(-kBasePadding / 2)
        }
    }
    
    @objc private func commentBtnClicked() {
        if nil != addCommentBlock {
            self.addCommentBlock()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
