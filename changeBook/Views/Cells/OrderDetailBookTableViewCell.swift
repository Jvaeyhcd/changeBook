//
//  OrderDetailBookTableViewCell.swift
//  changeBook
//
//  Created by Jvaeyhcd on 02/08/2017.
//  Copyright © 2017 Jvaeyhcd. All rights reserved.
//

import UIKit

let kCellIdOrderDetailBookTableViewCell = "OrderDetailBookTableViewCell"

class OrderDetailBookTableViewCell: BookListTableViewCell {
    
    var commentBlock: ((Book)->())!
    
    private var book: Book!

    // 评价按钮
    private lazy var btn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = kMainColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        self.btn.setTitle("评价得积分", for: .normal)
        self.btn.addTarget(self, action: #selector(commentBtnClicked), for: .touchUpInside)
        self.addSubview(self.btn)
        self.btn.snp.makeConstraints { (make) in
            make.right.equalTo(-kBasePadding)
            make.width.equalTo(scaleFromiPhone6Desgin(x: 90))
            make.height.equalTo(scaleFromiPhone6Desgin(x: 30))
            make.top.equalTo(self.titleLbl.snp.top)
        }
        
        self.titleLbl.snp.remakeConstraints { (make) in
            make.left.equalTo(self.coverImg.snp.right).offset(kBasePadding)
            make.height.equalTo(scaleFromiPhone6Desgin(x: 20))
            make.top.equalTo(self.coverImg.snp.top)
            make.right.equalTo(self.btn.snp.left).offset(scaleFromiPhone6Desgin(x: 8))
        }
    }
    
    @objc private func commentBtnClicked() {
        if nil != self.commentBlock {
            self.commentBlock(self.book)
        }
    }
    
    override func setBook(book: Book) {
        self.book = book
        super.setBook(book: book)
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
