//
//  SchoolListTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 11/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdSchoolListTableViewCell = "SchoolListTableViewCell"

class SchoolListTableViewCell: UITableViewCell {
    
    lazy var titleLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = UIColor(hex: 0x555555)
        return lbl
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectedBackgroundView = UIView.init(frame: self.frame)
        self.selectedBackgroundView?.backgroundColor = kSelectedCellBgColor
        
        self.addSubview(titleLbl)
        titleLbl.snp.makeConstraints{
            make -> Void in
            make.left.equalTo(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.right.equalTo(scaleFromiPhone6Desgin(x: 70))
            make.centerY.equalTo(self.snp.centerY)
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
