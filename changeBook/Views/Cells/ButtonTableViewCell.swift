//
//  ButtonTableViewCell.swift
//  govlan
//
//  Created by Jvaeyhcd on 10/04/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdButtonTableViewCell = "ButtonTableViewCell"


class ButtonTableViewCell: UITableViewCell {
    
    lazy var btnSure = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSuviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSuviews() {
        btnSure.frame = CGRect(x: 10, y: scaleFromiPhone6Desgin(x: 5), width: kScreenWidth - 20, height: scaleFromiPhone6Desgin(x: 40))
        btnSure.titleLabel?.font = kBarButtonItemTitleFont
        btnSure.setTitleColor(UIColor.white, for: UIControlState.normal)
        btnSure.setBackgroundImage(UIImage.init(color: kBtnNormalBgColor!, size: btnSure.frame.size), for: .normal)
        btnSure.setBackgroundImage(UIImage.init(color: kBtnTouchInBgColor!, size: btnSure.frame.size), for: .selected)
        btnSure.setBackgroundImage(UIImage.init(color: kBtnDisableBgColor!, size: btnSure.frame.size), for: .disabled)
        
        btnSure.layer.cornerRadius = 4
        btnSure.clipsToBounds = true
        self.addSubview(btnSure)
        btnSure.snp.makeConstraints{
            make -> Void in
            make.height.equalTo(scaleFromiPhone6Desgin(x: 50))
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.centerY.equalTo(self.snp.centerY)
        }
        
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 110)
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
