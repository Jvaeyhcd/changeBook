//
//  SelectPayWayTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 30/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdSelectPayWayTableViewCell = "SelectPayWayTableViewCell"

class SelectPayWayTableViewCell: UITableViewCell {
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView.init()
        iconImageView.clipsToBounds = true
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()
    
    lazy var titleLbl: UILabel = {
        let titleLbl = UILabel.init()
        titleLbl.font = UIFont.systemFont(ofSize: 16)
        titleLbl.textColor = UIColor.init(hex: 0x555555)
        titleLbl.textAlignment = .left
        return titleLbl
    }()
    
    lazy var selectBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: "zhifu_rb"), for: .normal)
        btn.setImage(UIImage(named: "zhifu_rb_pre"), for: .selected)
        return btn
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
        
        self.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 24))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 24))
            make.centerY.equalTo(self.snp.centerY)
        }
        
        self.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(-kScreenWidth * 0.2 - scaleFromiPhone6Desgin(x: 40))
        }
        
        self.addSubview(self.selectBtn)
        self.selectBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 68)
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
