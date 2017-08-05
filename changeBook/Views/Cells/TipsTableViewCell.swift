//
//  TipsTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 05/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdTipsTableViewCell = "TipsTableViewCell"

class TipsTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        self.textLabel?.textAlignment = NSTextAlignment.left
        self.textLabel?.numberOfLines = 0
        self.textLabel?.font = kBaseFont
        self.textLabel?.textColor = UIColor(hex: 0x999999)
        
    }
    
    static func cellHeightWithStr(str: String) -> CGFloat {
        let height = str.heightWithConstrainedWidth(width: kScreenWidth - 2 * kBasePadding, font: kBaseFont)
        return height + 2 * kBasePadding
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
