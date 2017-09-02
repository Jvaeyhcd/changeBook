//
//  SimpleInputTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 05/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdSimpleInputTableViewCell = "SimpleInputTableViewCell"

class SimpleInputTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    var textChangedBlock: ((String)->())!

    lazy var lbName = UILabel()
    lazy var tfName = UITextField()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        self.selectionStyle = .none
        
        lbName.textAlignment = NSTextAlignment.left
        lbName.numberOfLines = 1
        lbName.font = UIFont.systemFont(ofSize: 16)
        lbName.textColor = UIColor(hex: 0x555555)
        self.addSubview(lbName)
        lbName.snp.makeConstraints{
            make -> Void in
            make.left.equalTo(kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 100))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.centerY.equalTo(self.snp.centerY)
        }
        
        tfName.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        tfName.font = UIFont.systemFont(ofSize: 15)
        tfName.textColor = UIColor(hex: 0x666666)
        tfName.textAlignment = NSTextAlignment.right
        self.addSubview(tfName)
        tfName.snp.makeConstraints{
            make -> Void in
            make.left.equalTo(lbName.snp.right).offset(scaleFromiPhone6Desgin(x: 8))
            make.right.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.centerY.equalTo(self.snp.centerY)
        }
        
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 56)
    }
    
    func textFieldDidChange(textField: UITextField) {
        if nil != self.textChangedBlock {
            self.textChangedBlock(textField.text!)
        }
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
