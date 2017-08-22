//
//  InfoDetailTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 17/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdInfoDetailTableViewCell = "InfoDetailTableViewCell"

class InfoDetailTableViewCell: UITableViewCell {
    
    lazy var detailLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.textAlignment = .left
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubviews()
    }
    
    private func initSubviews() {
        
        self.selectionStyle = .none
        
        self.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(scaleFromiPhone6Desgin(x: 10))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.right.equalTo(-kBasePadding)
        }
        
        let spLine = UIView()
        spLine.backgroundColor = kMainBgColor
        self.addSubview(spLine)
        spLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(self.titleLbl.snp.bottom).offset(scaleFromiPhone6Desgin(x: 10))
        }
        
        let bototmLine = UIView()
        bototmLine.backgroundColor = kMainBgColor
        self.addSubview(bototmLine)
        bototmLine.snp.makeConstraints { (make) in
            make.height.equalTo(kBasePadding)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        self.addSubview(self.detailLbl)
        self.detailLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(spLine.snp.bottom).offset(scaleFromiPhone6Desgin(x: 10))
            make.right.equalTo(-kBasePadding)
            make.bottom.equalTo(bototmLine.snp.top).offset(-scaleFromiPhone6Desgin(x: 10))
        }
        
    }
    
    static func cellHeightWithStr(str: String)-> CGFloat {
        
        var height = scaleFromiPhone6Desgin(x: 60) + kBasePadding
        
        var detailHeight = str.heightWithConstrainedWidth(width: kScreenWidth - 2 * kBasePadding, font: UIFont.systemFont(ofSize: 14)) + 8
        if detailHeight < 20 {
            detailHeight = 20
        }
        
        height += detailHeight
        
        return height
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
