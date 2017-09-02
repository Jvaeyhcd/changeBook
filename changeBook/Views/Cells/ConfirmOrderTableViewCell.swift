//
//  ConfirmOrderTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 30/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdConfirmOrderTableViewCell = "ConfirmOrderTableViewCell"

class ConfirmOrderTableViewCell: UITableViewCell {
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView.init()
        iconImageView.clipsToBounds = true
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()
    
    lazy var descLbl: UILabel = {
        let titleLbl = UILabel.init()
        titleLbl.font = UIFont.systemFont(ofSize: 14)
        titleLbl.textColor = UIColor.init(hex: 0x888888)
        titleLbl.textAlignment = .right
        return titleLbl
    }()
    
    lazy var titleLbl: UILabel = {
        let titleLbl = UILabel.init()
        titleLbl.font = UIFont.systemFont(ofSize: 16)
        titleLbl.textColor = UIColor.init(hex: 0x555555)
        titleLbl.textAlignment = .left
        return titleLbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .disclosureIndicator
        
        self.selectedBackgroundView = UIView.init(frame: self.frame)
        self.selectedBackgroundView?.backgroundColor = kSelectedCellBgColor
        
        self.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 16))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 16))
            make.centerY.equalTo(self.snp.centerY)
        }
        
        self.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(70)
        }
        
        self.addSubview(self.descLbl)
        self.descLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLbl.snp.right).offset(8)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 33))
        }
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 56)
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
