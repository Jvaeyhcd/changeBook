//
//  OrderStatusTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 02/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//  订单状态的Cell

import UIKit

let kCellIdOrderStatusTableViewCell = "OrderStatusTableViewCell"

class OrderStatusTableViewCell: UITableViewCell {
    
    private lazy var iconImgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = UIViewContentMode.scaleAspectFill
        img.clipsToBounds = true
        img.backgroundColor = kMainBgColor
        img.image = UIImage(named: "dingdan_icon_done")
        img.layer.cornerRadius = scaleFromiPhone6Desgin(x: 8)
        return img
    }()
    
    private lazy var statusLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.text = "已完成"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor(hex: 0x555555)
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubviews()
    }
    
    private func initSubviews() {
        
        self.selectionStyle = .none
        
        self.addSubview(self.iconImgView)
        self.iconImgView.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.centerY.equalTo(self.snp.centerY)
        }
        
        self.addSubview(self.statusLbl)
        self.statusLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImgView.snp.right).offset(scaleFromiPhone6Desgin(x: 10))
            make.right.equalTo(-kBasePadding)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
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
