//
//  MenuTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 24/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdMenuTableViewCell = "MenuTableViewCell"

class MenuTableViewCell: UITableViewCell {
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView.init()
        iconImageView.clipsToBounds = true
        iconImageView.contentMode = .scaleAspectFill
        return iconImageView
    }()
    
    lazy var titleLbl: UILabel = {
        let titleLbl = UILabel.init()
        titleLbl.font = UIFont.systemFont(ofSize: 16)
        titleLbl.textColor = UIColor.init(hex: 0x232323)
        titleLbl.textAlignment = .left
        return titleLbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectedBackgroundView = UIView.init(frame: self.frame)
        self.selectedBackgroundView?.backgroundColor = kSelectedCellBgColor
        
        self.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(scaleFromiPhone6Desgin(x: 26))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.centerY.equalTo(self.snp.centerY)
        }
        
        self.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(scaleFromiPhone6Desgin(x: 10))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(-kScreenWidth / 6 - scaleFromiPhone6Desgin(x: 80))
        }
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 54)
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
