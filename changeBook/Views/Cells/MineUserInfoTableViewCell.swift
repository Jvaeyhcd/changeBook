//
//  MineUserInfoTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 06/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdMineUserInfoTableViewCell = "MineUserInfoTableViewCell"

class MineUserInfoTableViewCell: UITableViewCell {

    private lazy var headbgImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.backgroundColor = kMainColor
        return imgView
    }()
    
    private lazy var userHeadImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = scaleFromiPhone6Desgin(x: 30)
        imgView.contentMode = .scaleAspectFill
        imgView.isUserInteractionEnabled = true
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.borderWidth = 1
        imgView.backgroundColor = kMainBgColor
        return imgView
    }()
    
    private lazy var userNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 17)
        lbl.textColor = UIColor.init(hex: 0xFFFFFF)
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUserInfo(user: User) {
        self.userHeadImageView.sd_setImage(with: URL.init(string: user.headPic), placeholderImage: kUserDefaultImage)
        self.userNameLbl.text = user.nickName
    }
    
    private func initSubviews() {
        
        let width = kScreenWidth
        self.headbgImageView.image = UIImage(named: "wode_bg")
        self.addSubview(self.headbgImageView)
        self.headbgImageView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(-kNavHeight)
            make.width.equalTo(width)
            make.height.equalTo(width * 13 / 30)
        }
        
        self.headbgImageView.addSubview(self.userHeadImageView)
        self.userHeadImageView.snp.makeConstraints { (make) in
            make.width.equalTo(scaleFromiPhone6Desgin(x: 60))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 60))
            make.left.equalTo(scaleFromiPhone6Desgin(x: 28))
            make.centerY.equalTo(self.headbgImageView.snp.centerY).offset(kNavHeight/2)
        }
        
        self.userNameLbl.text = sharedGlobal.getSavedUser().nickName
        self.headbgImageView.addSubview(self.userNameLbl)
        self.userNameLbl.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.userHeadImageView.snp.centerY)
            make.left.equalTo(self.userHeadImageView.snp.right).offset(scaleFromiPhone6Desgin(x: 8))
            make.right.equalTo(0)
            make.height.equalTo(30)
        }
    }
    
    static func cellHeight() -> CGFloat {
        return kScreenWidth * 13 / 30 - kNavHeight
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
