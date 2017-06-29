//
//  NormalCollectionViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 29/06/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdNormalCollectionViewCell = "NormalCollectionViewCell"

class NormalCollectionViewCell: UICollectionViewCell {
    
    lazy var iconImage: UIImageView = {
        let iconImage = UIImageView()
        iconImage.backgroundColor = .clear
        iconImage.clipsToBounds = true
        iconImage.contentMode = .scaleAspectFill
        return iconImage
    }()
    
    lazy var titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.font = kBaseFont
        titleLbl.textColor = UIColor(hex: 0x222222)
        titleLbl.textAlignment = .center
        return titleLbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 设置选中的颜色
        self.selectedBackgroundView = UIView.init(frame: self.frame)
        self.selectedBackgroundView?.backgroundColor = kSelectedCellBgColor
        self.backgroundColor = UIColor.white
        
        self.contentView.addSubview(self.iconImage)
        self.iconImage.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.width.height.equalTo(frame.width / 2)
            make.centerY.equalTo(self.snp.centerY).offset(-15)
        }
        
        self.contentView.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(20)
            make.top.equalTo(self.iconImage.snp.bottom).offset(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
