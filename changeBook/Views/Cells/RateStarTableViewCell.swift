//
//  RateStarTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 03/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit
import HCSStarRatingView

let kCellIdRateStarTableViewCell = "RateStarTableViewCell"

class RateStarTableViewCell: UITableViewCell {
    
    var starValueChangedBlock: ((CGFloat)->())!

    lazy var rateStarView: HCSStarRatingView = {
        let star = HCSStarRatingView.init()
        star.maximumValue = 5
        star.minimumValue = 0
        star.value = 5
        star.allowsHalfStars = false
        star.emptyStarImage = UIImage(named: "pingjia_btn_star2")
        star.filledStarImage = UIImage(named: "pingjia_btn_star1")
        star.backgroundColor = UIColor.clear
        star.isUserInteractionEnabled = true
        return star
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        let tipsLbl = UILabel.init()
        tipsLbl.text = "综合评价"
        tipsLbl.textAlignment = .left
        tipsLbl.textColor = UIColor(hex: 0x555555)
        tipsLbl.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(tipsLbl)
        tipsLbl.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(scaleFromiPhone6Desgin(x: 10))
            make.bottom.equalTo(-scaleFromiPhone6Desgin(x: 10))
            make.width.equalTo(80)
        }
        
        self.addSubview(self.rateStarView)
        self.rateStarView.addTarget(self, action: #selector(rateStarChanged), for: .touchUpInside)
        self.rateStarView.snp.makeConstraints { (make) in
            make.left.equalTo(tipsLbl.snp.right)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.width.equalTo(scaleFromiPhone6Desgin(x: 150))
            make.centerY.equalTo(tipsLbl.snp.centerY)
        }
        
    }
    
    @objc func rateStarChanged() {
        if nil != self.starValueChangedBlock {
            self.starValueChangedBlock(self.rateStarView.value)
        }
    }
    
    static func cellHeight() -> CGFloat {
        return scaleFromiPhone6Desgin(x: 60)
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
