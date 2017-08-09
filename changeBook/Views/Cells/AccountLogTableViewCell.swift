//
//  AccountLogTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 09/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdAccountLogTableViewCell = "AccountLogTableViewCell"

class AccountLogTableViewCell: UITableViewCell {
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    lazy var timeLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = UIColor(hex: 0x888888)
        lbl.font = UIFont.systemFont(ofSize: 12)
        return lbl
    }()
    
    lazy var statusLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    private func initSubviews() {
        self.selectionStyle = .none
        
        self.addSubview(self.statusLbl)
        self.statusLbl.snp.makeConstraints { (make) in
            make.right.equalTo(-kBasePadding)
            make.top.equalTo(kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 100))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
        }
        
        self.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.right.equalTo(self.statusLbl.snp.left)
        }
        
        self.addSubview(self.timeLbl)
        self.timeLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.top.equalTo(self.statusLbl.snp.bottom).offset(scaleFromiPhone6Desgin(x: 5))
            make.bottom.equalTo(-kBasePadding)
        }
    }
    
    func  setAccountLog(accountLog: AccountLog) {
        self.titleLbl.text = accountLog.content
        self.timeLbl.text = NSDate.stringTimesAgo(fromTimeInterval: accountLog.createAt.doubleValue)
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 45) + 2 * kBasePadding
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
