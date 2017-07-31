//
//  UserDetailView.swift
//  changeBook
//
//  Created by Jvaeyhcd on 31/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

class UserDetailView: UIView {

    private lazy var userHeadImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = scaleFromiPhone6Desgin(x: 30)
        imgView.contentMode = .scaleAspectFill
        imgView.isUserInteractionEnabled = true
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = 1
        imgView.backgroundColor = kMainColor
        return imgView
    }()
    
    private lazy var userNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = UIColor.init(hex: 0x555555)
        return lbl
    }()
    
    private lazy var descLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 13)
        lbl.numberOfLines = 0
        lbl.textColor = UIColor.init(hex: 0x888888)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.userHeadImageView)
        self.userHeadImageView.snp.makeConstraints { (make) in
            make.width.equalTo(scaleFromiPhone6Desgin(x: 60))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 60))
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(kBasePadding)
        }
        
        self.addSubview(self.userNameLbl)
        self.userNameLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.userHeadImageView.snp.bottom).offset(scaleFromiPhone6Desgin(x: 10))
        }
        
        self.addSubview(self.descLbl)
        self.descLbl.snp.makeConstraints { (make) in
            make.top.equalTo(self.userNameLbl.snp.bottom).offset(scaleFromiPhone6Desgin(x: 10))
            make.bottom.equalTo(-kBasePadding)
            make.left.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 30))
        }
        
    }
    
    func setUser(user: User) {
        self.userNameLbl.text = user.userName
        self.descLbl.text = user.introduce
        self.userHeadImageView.sd_setImage(with: URL.init(string: user.headPic), placeholderImage: kNoImgDefaultImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
