//
//  DepositTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 20/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdDepositTableViewCell = "DepositTableViewCell"

class DepositTableViewCell: UITableViewCell {
    
    lazy var bookNumberLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var moneyLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.textAlignment = .right
        return lbl
    }()
    
    lazy var selectBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: "zhifu_rb"), for: .normal)
        btn.setImage(UIImage(named: "zhifu_rb_pre"), for: .selected)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubviews()
    }
    
    private func initSubviews() {
        self.selectedBackgroundView = UIView.init(frame: self.frame)
        self.selectedBackgroundView?.backgroundColor = kSelectedCellBgColor
        
        self.addSubview(self.selectBtn)
        self.selectBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.centerY.equalTo(self.snp.centerY)
        }
        
        self.addSubview(self.moneyLbl)
        self.moneyLbl.snp.makeConstraints { (make) in
            make.right.equalTo(self.selectBtn.snp.left).offset(-8)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 100))
            make.height.equalTo(20)
            make.centerY.equalTo(self.snp.centerY)
        }
        
        self.addSubview(self.bookNumberLbl)
        self.bookNumberLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.right.equalTo(self.moneyLbl.snp.left).offset(-8)
            make.height.equalTo(20)
            make.centerY.equalTo(self.snp.centerY)
        }
    }
    
    func setCellSelected(selected: Bool) {
        if selected == true {
            self.selectBtn.setImage(UIImage(named: "zhifu_rb_pre"), for: .normal)
        } else {
            self.selectBtn.setImage(UIImage(named: "zhifu_rb"), for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 56)
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
