//
//  TeacherListTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 01/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdTeacherListTableViewCell = "TeacherListTableViewCell"

class TeacherListTableViewCell: UITableViewCell {
    
    // 头像
    private lazy var headImg: UIImageView = {
        let coverImg = UIImageView.init()
        coverImg.backgroundColor = kMainBgColor
        coverImg.contentMode = .scaleAspectFill
        return coverImg
    }()
    
    // 姓名
    private lazy var nameLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x555555)
        return lbl
    }()
    
    // 职称
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x888888)
        return lbl
    }()
    
    // 学院
    private lazy var collegeLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x888888)
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubviews()
    }
    
    private func initSubviews() {
        
        self.selectedBackgroundView = UIView.init(frame: self.frame)
        self.selectedBackgroundView?.backgroundColor = kSelectedCellBgColor
        
        self.addSubview(self.headImg)
        self.headImg.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 70))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 80))
        }
        
        self.nameLbl.text = "黄成达 成都信息工程大学"
        self.addSubview(self.nameLbl)
        self.nameLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImg.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.headImg.snp.top)
            make.right.equalTo(-kBasePadding)
        }
        
        self.titleLbl.text = "副教授"
        self.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImg.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.nameLbl.snp.bottom)
            make.right.equalTo(-kBasePadding)
        }
        
        self.collegeLbl.text = "数学与应用数学学院"
        self.addSubview(self.collegeLbl)
        self.collegeLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImg.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.titleLbl.snp.bottom)
            make.right.equalTo(-kBasePadding)
        }
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 80) + 2 * kBasePadding
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
