//
//  AddressListTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 12/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdAddressListTableViewCell = "AddressListTableViewCell"

class AddressListTableViewCell: UITableViewCell {
    
    private lazy var nameAndPhoneLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var addressLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor(hex: 0x888888)
        lbl.textAlignment = .left
        return lbl
    }()
    
    var defaultBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("默认地址", for: .selected)
        btn.setTitle("设为默认", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(UIColor(hex: 0x888888), for: .normal)
        btn.setImage(UIImage(named: "zhifu_rb"), for: .normal)
        btn.setImage(UIImage(named: "zhifu_rb_pre"), for: .selected)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3)
        return btn
    }()
    
    var editBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("编辑", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(UIColor(hex: 0x888888), for: .normal)
        btn.setImage(UIImage(named: "dizhi_btn_xiugai"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3)
        return btn
    }()
    
    var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("删除", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setTitleColor(UIColor(hex: 0x888888), for: .normal)
        btn.setImage(UIImage(named: "dizhi_btn_shanchu"), for: .normal)
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3)
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, -3)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubviews()
    }
    
    private func initSubviews() {
        
        self.backgroundColor = UIColor.white
        
        let largeLine = UIView()
        largeLine.backgroundColor = kMainBgColor
        self.addSubview(largeLine)
        largeLine.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 15))
        }
        
        self.nameAndPhoneLbl.text = "黄成达 18782962370"
        self.addSubview(self.nameAndPhoneLbl)
        self.nameAndPhoneLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(largeLine.snp.bottom).offset(scaleFromiPhone6Desgin(x: 10))
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 25))
        }
        
        self.addressLbl.text = "电子科技大学清水河校区"
        self.addSubview(self.addressLbl)
        self.addressLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(self.nameAndPhoneLbl.snp.bottom).offset(scaleFromiPhone6Desgin(x: 5))
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
        }
        
        let lineView = UIView()
        lineView.backgroundColor = kMainBgColor
        self.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(1)
            make.top.equalTo(self.addressLbl.snp.bottom).offset(scaleFromiPhone6Desgin(x: 5))
        }
        
        self.addSubview(self.defaultBtn)
        self.defaultBtn.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(lineView.snp.bottom).offset(scaleFromiPhone6Desgin(x: 5))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.width.equalTo(80)
        }
        
        self.addSubview(self.deleteBtn)
        self.deleteBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kBasePadding)
            make.centerY.equalTo(self.defaultBtn.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.width.equalTo(54)
        }
        
        self.addSubview(self.editBtn)
        self.editBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.deleteBtn.snp.left).offset(-kBasePadding)
            make.centerY.equalTo(self.defaultBtn.snp.centerY)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.width.equalTo(54)
        }
    }
    
    func setAddress(address: Address) {
        self.addressLbl.text = address.addressDetail
        self.nameAndPhoneLbl.text = address.userName + "  " + address.phone
        self.defaultBtn.isSelected = address.isDefault
        
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 135)
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
