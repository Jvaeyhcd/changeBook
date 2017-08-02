//
//  OrderAddressTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 02/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//  订单详情中地址Cell

import UIKit

let kCellIdOrderAddressTableViewCell = "OrderAddressTableViewCell"

class OrderAddressTableViewCell: UITableViewCell {
    
    private lazy var iconImgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = UIViewContentMode.scaleAspectFill
        img.clipsToBounds = true
        img.backgroundColor = kMainBgColor
        img.image = UIImage(named: "dingdan_icon_dizhi")
        img.layer.cornerRadius = scaleFromiPhone6Desgin(x: 8)
        return img
    }()
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.text = "已完成"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor(hex: 0x555555)
        return lbl
    }()
    
    private lazy var addressLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.text = "已完成"
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
        
        self.addSubview(self.iconImgView)
        self.iconImgView.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 16))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 16))
            make.top.equalTo(kBasePadding)
        }
        
        self.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImgView.snp.right).offset(scaleFromiPhone6Desgin(x: 10))
            make.right.equalTo(-kBasePadding)
            make.centerY.equalTo(self.iconImgView.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.addressLbl)
        self.addressLbl.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLbl.snp.bottom).offset(scaleFromiPhone6Desgin(x: 10))
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.bottom.equalTo(-kBasePadding)
        }
        
    }
    
    static func cellHeightWithOrder(order: BookOrder) -> CGFloat {
        var addressHeight = scaleFromiPhone6Desgin(x: 20)
        if order.address.heightWithConstrainedWidth(width: kScreenWidth - 2 * kBasePadding, font: UIFont.systemFont(ofSize: 14)) > scaleFromiPhone6Desgin(x: 20) {
            addressHeight = order.address.heightWithConstrainedWidth(width: kScreenWidth - 2 * kBasePadding, font: UIFont.systemFont(ofSize: 14))
        }
        
        return scaleFromiPhone6Desgin(x: 30) + 2 * kBasePadding + addressHeight
    }
    
    func setOrderAddress(order: BookOrder) {
        self.titleLbl.text = order.userName + " " + order.phone
        self.addressLbl.text = order.address
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
