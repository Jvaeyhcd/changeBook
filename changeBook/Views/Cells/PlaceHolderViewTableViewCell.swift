//
//  PlaceHolderViewTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 03/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdPlaceHolderViewTableViewCell = "PlaceHolderViewTableViewCell"

class PlaceHolderViewTableViewCell: UITableViewCell {
    
    lazy var placeHolder: UIPlaceHolderTextView = {
        let textView = UIPlaceHolderTextView.init(frame: CGRect(x: scaleFromiPhone6Desgin(x: 10), y: kBasePadding, width: kScreenWidth - scaleFromiPhone6Desgin(x: 20), height: scaleFromiPhone6Desgin(x: 120)))
        textView.placeholder = "请输入评价"
        return textView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.placeHolder)
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 120) + 2 * kBasePadding
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
