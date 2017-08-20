//
//  SignleImageTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 20/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdSignleImageTableViewCell = "SignleImageTableViewCell"

class SignleImageTableViewCell: UITableViewCell {

    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = UIViewContentMode.scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.addSubview(self.imgView)
        self.imgView.snp.makeConstraints { (make) in
            make.left.equalTo(kBasePadding)
            make.top.equalTo(0.0 * kBasePadding)
            make.right.equalTo(-kBasePadding)
            make.bottom.equalTo(-kBasePadding)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func cellHeight() -> CGFloat {
        let height = kBasePadding + (kScreenWidth - 2 * kBasePadding) * CGFloat(584) / CGFloat(960)
        return height
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
