//
//  SettingTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 06/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdSettingTableViewCell = "SettingTableViewCell"

class SettingTableViewCell: UITableViewCell {

    lazy var titleLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.text = "头像"
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = UIColor(hex: 0x555555)
        return lbl
        
    }()
    
    lazy var portraitImageView: UIImageView = {
        let portraitImageView = UIImageView()
        portraitImageView.image = kUserDefaultImage
        portraitImageView.contentMode = .scaleAspectFill
        portraitImageView.layer.cornerRadius = scaleFromiPhone6Desgin(x: 19)
        portraitImageView.clipsToBounds = true
        return portraitImageView
    }()
    
    lazy var descLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor(hex: 0x888888)
        return lbl
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectedBackgroundView = UIView.init(frame: self.frame)
        self.selectedBackgroundView?.backgroundColor = kSelectedCellBgColor
        
        self.addSubview(titleLbl)
        titleLbl.snp.makeConstraints{
            make -> Void in
            make.left.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.width.equalTo(kScreenWidth / 2)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        self.portraitImageView.image = kUserDefaultImage
        self.addSubview(self.portraitImageView)
        self.portraitImageView.snp.makeConstraints{
            make -> Void in
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 35))
            make.width.height.equalTo(scaleFromiPhone6Desgin(x: 38))
            make.centerY.equalTo(self.snp.centerY)
        }
        
        self.addSubview(descLbl)
        descLbl.snp.makeConstraints{
            make -> Void in
            make.right.equalTo(-scaleFromiPhone6Desgin(x: 33))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.width.equalTo(kScreenWidth / 2)
            make.centerY.equalTo(self.snp.centerY)
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
