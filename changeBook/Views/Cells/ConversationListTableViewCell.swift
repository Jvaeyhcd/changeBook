//
//  ConversationListTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 12/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdConversationListTableViewCell = "ConversationListTableViewCell"

class ConversationListTableViewCell: UITableViewCell {
    
    lazy var headImg: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = scaleFromiPhone6Desgin(x: 20)
        imgView.clipsToBounds = true
        imgView.contentMode = UIViewContentMode.scaleAspectFill
        imgView.backgroundColor = kMainBgColor
        return imgView
    }()
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x555555)
        return lbl
    }()
    
    lazy var contentLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x888888)
        return lbl
    }()
    
    lazy var timeLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .right
        lbl.textColor = UIColor(hex: 0x888888)
        return lbl
    }()
    
    private lazy var badgeLabel: PersistentBackgroundLabel = {
        let lbl = PersistentBackgroundLabel()
        lbl.setPersistentBackgroundColor(kMainColor)
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor  = UIColor.white
        lbl.backgroundColor = kMainColor
        lbl.layer.cornerRadius = 8
        lbl.clipsToBounds = true
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubviews()
    }
    
    private func initSubviews() {
        self.selectedBackgroundView = UIView.init(frame: self.frame)
        self.selectedBackgroundView?.backgroundColor = kSelectedCellBgColor
        
        self.backgroundColor = .white
        self.addSubview(self.headImg)
        self.headImg.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 40))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 40))
        }
        
        self.addSubview(self.timeLbl)
        self.timeLbl.snp.makeConstraints { (make) in
            make.top.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 150))
        }
        
        self.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImg.snp.right).offset(scaleFromiPhone6Desgin(x: 10))
            make.right.equalTo(self.timeLbl.snp.left).offset(-scaleFromiPhone6Desgin(x: 10))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(kBasePadding)
        }
        
        self.addSubview(self.badgeLabel)
        
        self.addSubview(self.contentLbl)
        self.contentLbl.snp.makeConstraints { (make) in
            make.left.equalTo(self.headImg.snp.right).offset(scaleFromiPhone6Desgin(x: 10))
            make.top.equalTo(self.titleLbl.snp.bottom)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.right.equalTo(-kBasePadding-40)
        }
    }
    
    func setBadge(badge: Int) {
        var width = CGFloat(16)
        if "\(badge)".widthWithConstrainedWidth(width: CGFloat(40), font: UIFont.systemFont(ofSize: 12)) > width {
            width = "\(badge)".widthWithConstrainedWidth(width: CGFloat(40), font: UIFont.systemFont(ofSize: 12))
        }
        self.badgeLabel.text = "\(badge)"
        self.badgeLabel.frame = CGRect(x: kScreenWidth - kBasePadding - width, y: kBasePadding + scaleFromiPhone6Desgin(x: 20), width: width, height: CGFloat(16))
        if badge == 0 {
            self.badgeLabel.isHidden = true
        } else {
            self.badgeLabel.isHidden = false
        }
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 40) + 2 * kBasePadding
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
