//
//  OrderBookTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 02/07/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdOrderBookTableViewCell = "OrderBookTableViewCell"

class OrderBookTableViewCell: BookListTableViewCell {
    
    private var numberLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 12)
        lbl.textAlignment = .right
        lbl.textColor = UIColor(hex: 0xF85B5A)
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.numberLbl.text = "x2"
        self.addSubview(self.numberLbl)
        self.numberLbl.snp.makeConstraints { (make) in
            make.right.equalTo(kBasePadding)
            make.bottom.equalTo(-kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 60))
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
