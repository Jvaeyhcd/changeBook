//
//  IntegralLogTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 02/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdIntegralLogTableViewCell = "IntegralLogTableViewCell"

class IntegralLogTableViewCell: UITableViewCell {
    
    private lazy var titleLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var dateLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textColor = UIColor(hex: 0x888888)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var integralLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = UIColor(hex: 0x555555)
        lbl.textAlignment = .right
        return lbl
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubviews()
    }
    
    private func initSubviews() {
        
        self.selectionStyle = .none
        
        self.integralLbl.text = ""
        self.addSubview(self.integralLbl)
        self.integralLbl.snp.makeConstraints { (make) in
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.centerY.equalTo(self.snp.centerY)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 50))
            make.right.equalTo(-kBasePadding)
        }
        
        self.titleLbl.text = ""
        self.addSubview(self.titleLbl)
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.right.equalTo(self.integralLbl.snp.left)
        }
        
        self.dateLbl.text = ""
        self.addSubview(self.dateLbl)
        self.dateLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(self.titleLbl.snp.bottom)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.right.equalTo(self.integralLbl.snp.left)
        }
    }
    
    func setIntegralLog(integralLog: IntegralLog) {
        self.titleLbl.text = integralLog.integralStr
        self.dateLbl.text = integralLog.createAt
        self.integralLbl.text = integralLog.integral
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
