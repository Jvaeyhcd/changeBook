//
//  SimpleShowTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 30/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//  简单的展示TableViewCell

import UIKit

let kCellIdSimpleShowTableViewCell = "SimpleShowTableViewCell"

class SimpleShowTableViewCell: UITableViewCell {
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.text = "配送方式"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor(hex: 0x555555)
        return lbl
    }()
    
    lazy var descLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.text = "免运费"
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor(hex: 0x888888)
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
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(100)
        }
        
        self.addSubview(self.descLbl)
        self.descLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLbl.snp.right).offset(8)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(-kBasePadding)
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
