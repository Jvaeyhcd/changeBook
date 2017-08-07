//
//  UsersCommentTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 07/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdUsersCommentTableViewCell = "UsersCommentTableViewCell"

class UsersCommentTableViewCell: UITableViewCell {
    
    private lazy var userHead: UITapImageView = {
        let imgView = UITapImageView()
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    private lazy var contentLbl: UITTTAttributedLabel = {
        let lbl = UITTTAttributedLabel.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        lbl.font = UIFont.systemFont(ofSize: 16)
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubviews() {
        
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
