//
//  AddressInfoTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 13/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdAddressInfoTableViewCell = "AddressInfoTableViewCell"

class AddressInfoTableViewCell: UITableViewCell {
    
    lazy var lbTitle: UILabel = {
    
        let lbTitle = UILabel()
        lbTitle.textAlignment = NSTextAlignment.left
        lbTitle.font = UIFont.systemFont(ofSize: 14)
        lbTitle.textColor = UIColor(hex: 0x555555)
        return lbTitle
        
    }()
    
    lazy var inputText: UITextField = {
        let inputText = UITextField()
        inputText.font = UIFont.systemFont(ofSize: 14)
        inputText.textColor = UIColor(hex: 0x555555)
        inputText.textAlignment = NSTextAlignment.left
        return inputText
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubviews()
    }
    
    private func initSubviews() {
        
        self.selectionStyle = .none
        
        self.addSubview(self.lbTitle)
        self.lbTitle.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(scaleFromiPhone6Desgin(x: 10))
            make.bottom.equalTo(-scaleFromiPhone6Desgin(x: 10))
            make.width.equalTo(60)
        }
        
        self.addSubview(self.inputText)
        self.inputText.snp.makeConstraints { (make) in
            make.left.equalTo(self.lbTitle.snp.right).offset(scaleFromiPhone6Desgin(x: 10))
            make.right.equalTo(-kBasePadding)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 54)
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
