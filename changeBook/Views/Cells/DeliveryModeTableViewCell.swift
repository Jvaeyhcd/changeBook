//
//  DeliveryModeTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 28/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdDeliveryModeTableViewCell = "DeliveryModeTableViewCell"

class DeliveryModeTableViewCell: UITableViewCell {
    
    var deliveryMode: Int!
    var deliveryWayBlock: ((Int)->())!
    
    private lazy var iconImgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = UIViewContentMode.scaleAspectFill
        img.clipsToBounds = true
        img.backgroundColor = kMainBgColor
        img.image = UIImage(named: "dingdan_icon_peisong")
        img.layer.cornerRadius = scaleFromiPhone6Desgin(x: 8)
        return img
    }()
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.text = "配送方式"
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor(hex: 0x555555)
        return lbl
    }()
    
    private lazy var tipsLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.text = "免运费"
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = UIColor(hex: 0x555555)
        return lbl
    }()
    
    private lazy var ownPickBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.titleLabel?.textColor = UIColor.white
        btn.backgroundColor = UIColor(hex: 0xF85B5A)
        btn.layer.cornerRadius = 4
        btn.setTitle("书库自取", for: .normal)
        return btn
    }()
    
    private lazy var deliveryBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.titleLabel?.textColor = UIColor.white
        btn.setTitle("送货上门", for: .normal)
        btn.layer.cornerRadius = 4
        btn.backgroundColor = UIColor(hex: 0xE0E0E0)
        return btn
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
            make.centerY.equalTo(self.snp.centerY)
        }
        
        self.addSubview(self.deliveryBtn)
        self.deliveryBtn.addTarget(self, action: #selector(buttonClicked(btn:)), for: .touchUpInside)
        self.deliveryBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(20)
            make.width.equalTo(60)
            make.centerY.equalTo(self.iconImgView.snp.centerY)
        }
        
        self.addSubview(self.ownPickBtn)
        self.ownPickBtn.addTarget(self, action: #selector(buttonClicked(btn:)), for: .touchUpInside)
        self.ownPickBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.deliveryBtn.snp.left).offset(-8)
            make.height.equalTo(20)
            make.width.equalTo(60)
            make.centerY.equalTo(self.iconImgView.snp.centerY)
        }
        
        self.addSubview(self.tipsLbl)
        self.tipsLbl.snp.makeConstraints { (make) in
            make.right.equalTo(self.ownPickBtn.snp.left).offset(-8)
            make.height.equalTo(20)
            make.width.equalTo(50)
            make.centerY.equalTo(self.iconImgView.snp.centerY)
        }
        
        self.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(iconImgView.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.centerY.equalTo(self.snp.centerY)
            make.right.equalTo(self.tipsLbl.snp.left).offset(-8)
        }
    }
    
    @objc private func buttonClicked(btn: UIButton) {
        
        switch btn {
        case self.ownPickBtn:
            self.ownPickBtn.backgroundColor = UIColor(hex: 0xF85B5A)
            self.deliveryBtn.backgroundColor = UIColor(hex: 0xE0E0E0)
            self.tipsLbl.isHidden = false
            self.deliveryMode = kDeliveryModeZhiQu
        case self.deliveryBtn:
            self.ownPickBtn.backgroundColor = UIColor(hex: 0xE0E0E0)
            self.deliveryBtn.backgroundColor = UIColor(hex: 0xF85B5A)
            self.tipsLbl.isHidden = true
            self.deliveryMode = kDeliveryModePeiSong
        default:
            break
        }
        
        if nil != self.deliveryWayBlock {
            self.deliveryWayBlock(self.deliveryMode)
        }
    }
    
    func setDeliveryWay(deliveryWay: Int) {
        self.deliveryMode = deliveryWay
        if self.deliveryMode == kDeliveryModePeiSong {
            self.ownPickBtn.backgroundColor = UIColor(hex: 0xE0E0E0)
            self.deliveryBtn.backgroundColor = UIColor(hex: 0xF85B5A)
            self.tipsLbl.isHidden = true
        } else if self.deliveryMode == kDeliveryModeZhiQu {
            self.ownPickBtn.backgroundColor = UIColor(hex: 0xF85B5A)
            self.deliveryBtn.backgroundColor = UIColor(hex: 0xE0E0E0)
            self.tipsLbl.isHidden = false
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
